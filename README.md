# Docker MD

[![docker](https://img.shields.io/badge/docker-latest-42cc23?style=flat-square&labelColor=564341)](https://hub.docker.com/r/doocs/md)

轻量的微信编辑器 [doocs/md](https://github.com/doocs/md) 的轻量容器镜像。

# 目录结构

```bash
├── docker    镜像文件目录（包含最新分支和 1.6.0 之后的版本）
│   ├── 1.6.0
│   ├── 2.0.0
│   ├── 2.0.1
│   ├── 2.0.2
│   ├── 2.0.3
│   ├── 2.0.4
│   ├── 2.1.0
│   └── latest
└── scripts                      构建镜像使用的脚本
    ├── build-base-image.sh      构建基础镜像
    ├── build-nginx.sh           构建基于 Nginx 的镜像
    ├── build-standalone.sh      构建独立二进制版本
    ├── build-static.sh          构建静态镜像
    └── build-multiarch.sh       构建多架构镜像(linux/amd64,linux/arm64)
```

## 镜像列表

### 二进制版

镜像命名规则 `doocs/md:[版本号]`

```bash
docker run --rm -it -p 8080:80 doocs/md:latest
docker run --rm -it -p 8080:80 doocs/md:2.1.0
docker run --rm -it -p 8080:80 doocs/md:2.0.4
docker run --rm -it -p 8080:80 doocs/md:2.0.3
docker run --rm -it -p 8080:80 doocs/md:2.0.2
docker run --rm -it -p 8080:80 doocs/md:2.0.1
docker run --rm -it -p 8080:80 doocs/md:2.0.0
docker run --rm -it -p 8080:80 doocs/md:1.6.0
```

### Nginx 镜像版

镜像命名规则 `doocs/md:[版本号]-nginx`

```bash
docker run --rm -it -p 8080:80 doocs/md:latest-nginx
docker run --rm -it -p 8080:80 doocs/md:2.1.0-nginx
docker run --rm -it -p 8080:80 doocs/md:2.0.4-nginx
docker run --rm -it -p 8080:80 doocs/md:2.0.3-nginx
docker run --rm -it -p 8080:80 doocs/md:2.0.2-nginx
docker run --rm -it -p 8080:80 doocs/md:2.0.1-nginx
docker run --rm -it -p 8080:80 doocs/md:2.0.0-nginx
docker run --rm -it -p 8080:80 doocs/md:1.6.0-nginx
```
