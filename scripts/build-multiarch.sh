#!/bin/bash

set -euo pipefail

RELEASE_DIR="./docker"
REPO_NAME="doocs/md"
PLATFORMS="linux/amd64,linux/arm64"

# 可以通过环境变量指定要构建的版本，用空格分隔
# 例如: BUILD_VERSIONS="2.1.0 latest" ./build-multiarch.sh
# 如果不指定，默认只构建最新的 3 个版本
if [ -z "${BUILD_VERSIONS:-}" ]; then
    BUILD_VERSIONS=$(ls -1 "$RELEASE_DIR" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$|^latest$' | sort -V | tail -3)
    BUILD_VERSIONS="$BUILD_VERSIONS latest"
fi

echo "🔧 Multi-arch Docker build started..."
echo "📁 Scanning directory: $RELEASE_DIR"
echo "🎯 Versions to build: $BUILD_VERSIONS"

for tag in $BUILD_VERSIONS; do
    app_ver="$RELEASE_DIR/$tag"
    [ -d "$app_ver" ] || continue

    env_file="$app_ver/.env"

    if [ ! -f "$env_file" ]; then
        echo "⚠️ Skipping $tag - missing .env file"
        continue
    fi

    set -a
    . "$env_file"
    set +a

    echo "🚀 Building images for version: $tag"
    echo "    VER_APP: $VER_APP"
    echo "    VER_NGX: $VER_NGX"
    echo "    VER_GOLANG: $VER_GOLANG"
    echo "    VER_ALPINE: $VER_ALPINE"

    # 构建 base 镜像
    if [ -f "$app_ver/Dockerfile.base" ]; then
        echo "📦 Building base image: $REPO_NAME:${VER_APP}-assets"
        docker buildx build \
            --platform "$PLATFORMS" \
            --build-arg VER_APP="$VER_APP" \
            -f "$app_ver/Dockerfile.base" \
            -t "$REPO_NAME:${VER_APP}-assets" \
            --push \
            "$app_ver"
    fi

    # 构建 nginx 镜像
    if [ -f "$app_ver/Dockerfile.nginx" ]; then
        echo "📦 Building nginx image: $REPO_NAME:${VER_APP}-nginx"
        docker buildx build \
            --platform "$PLATFORMS" \
            --build-arg VER_APP="$VER_APP" \
            --build-arg VER_NGX="$VER_NGX" \
            -f "$app_ver/Dockerfile.nginx" \
            -t "$REPO_NAME:${VER_APP}-nginx" \
            --push \
            "$app_ver"
    fi

    # 构建 standalone 镜像
    if [ -f "$app_ver/Dockerfile.standalone" ]; then
        echo "📦 Building standalone image: $REPO_NAME:${VER_APP}"
        docker buildx build \
            --platform "$PLATFORMS" \
            --build-arg VER_APP="$VER_APP" \
            --build-arg VER_NGX="$VER_NGX" \
            -f "$app_ver/Dockerfile.standalone" \
            -t "$REPO_NAME:${VER_APP}" \
            --push \
            "$app_ver"
    fi

    # 构建 static 镜像
    if [ -f "$app_ver/Dockerfile.static" ]; then
        echo "📦 Building static image: $REPO_NAME:${VER_APP}-static"
        docker buildx build \
            --platform "$PLATFORMS" \
            --build-arg VER_APP="$VER_APP" \
            --build-arg VER_NGX="$VER_NGX" \
            -f "$app_ver/Dockerfile.static" \
            -t "$REPO_NAME:${VER_APP}-static" \
            --push \
            "$app_ver"
    fi

    echo "✅ Completed version: $tag"
done

echo "🎉 All images built and pushed successfully."
