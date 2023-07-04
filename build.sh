#!/bin/bash
set -e
version=$(date +"%Y%m%d%H%M%S")
container_name="subconverter-custom"
builder_name="mybuilder"

# 更新代码
cd ACL4SSR
git pull
git checkout master
cd ..

# 复制文件
cp ACL4SSR/Clash/*.list replacements/rules/ACL4SSR/Clash/
cp -a ACL4SSR/Clash/Ruleset replacements/rules/ACL4SSR/Clash/

# 创建并使用构建器容器
docker buildx create --name "$builder_name"
docker buildx use "$builder_name"

# 构建 Docker 镜像
docker login
docker buildx build --platform linux/amd64,linux/arm64 --pull -t zouhaodong/subconverter-custom:${version} -t zouhaodong/subconverter-custom:latest --push .

# 停止并删除已有容器
if docker ps -a --format "{{.Names}}" | grep -q "$container_name"; then
    docker stop "$container_name"
    docker rm "$container_name"
fi

# 运行新容器
docker run -d --restart=always --name "$container_name" -p 25500:25500 zouhaodong/subconverter-custom:latest

# 删除构建器容器
docker buildx rm "$builder_name"

# 清理无用镜像
docker image prune -a -f
