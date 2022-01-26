# Docker MD

轻量的微信编辑器 [doocs/md](https://github.com/doocs/md) 的轻量容器镜像。

# 目录结构

```bash
├── docker    镜像文件目录（包含最新分支和最近三个版本）
│   ├── 1.5.7
│   └── trunk
└── scripts                      构建镜像使用的脚本
    ├── build-base-image.sh      构建基础镜像
    ├── build-nginx.sh           构建基于Nginx的镜像
    └── build-standalone.sh      构建独立二进制版本
```
