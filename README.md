# Docker MD

轻量的微信编辑器 [doocs/md](https://github.com/doocs/md) 的轻量容器镜像。

# 目录结构

```bash
├── docker    镜像文件目录（包含最新分支和 1.5.7 之后的版本）
│   ├── 1.5.7
│   └── latest
└── scripts                      构建镜像使用的脚本
    ├── build-base-image.sh      构建基础镜像
    ├── build-nginx.sh           构建基于Nginx的镜像
    └── build-standalone.sh      构建独立二进制版本
```

## 镜像列表

### 二进制版

镜像命名规则 `doocs/md:[版本号]`

```bash
docker run --rm -it -p 8080:80 doocs/md:latest
docker run --rm -it -p 8080:80 doocs/md:1.5.7
```

### Nginx 镜像版

镜像命名规则 `doocs/md:[版本号]-nginx`

```bash
docker run --rm -it -p 8080:80 doocs/md:latest-nginx
docker run --rm -it -p 8080:80 doocs/md:1.5.7-nginx
