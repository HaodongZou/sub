#!/bin/bash
set -e
version=$(date +"%Y%m%d%H%M%S")
container_name="subconverter"

# 更新代码
cd ACL4SSR
git pull --rebase
git checkout master
cd ..

# 复制文件
cp ACL4SSR/Clash/*.list replacements/rules/ACL4SSR/Clash/
cp -a ACL4SSR/Clash/Ruleset replacements/rules/ACL4SSR/Clash/

# 构建 Docker 镜像
docker build -t zouhd/subconverter:${version} -t zouhd/subconverter:latest .

# 停止并删除已有容器
if docker ps -a --format "{{.Names}}" | grep -q "$container_name"; then
    docker stop "$container_name"
    docker rm "$container_name"
fi

# 运行新容器
docker run -d --restart=always --name "$container_name" -p 25500:25500 zouhd/subconverter:latest


# 清理无用镜像
docker image prune -a -f
