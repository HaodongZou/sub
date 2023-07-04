# 一键打包自定义 subconverter 镜像
## 功能
一键打包不同架构的自定义 subconverter 镜像、本地部署并上传到 Docker Hub。
## 用法
* 在`/replacements/profile/`目录下创建一个文件，文件名为 你的配置名称.ini，文件内容为你的配置内容
```ini
[Profile]
;This is an example profile for the /getprofile interface
;The options works the same as the arguments in the /sub interface
;Arguments that needed URLEncode before is not needed here
;For more available options, please check the readme section

target=clash
url=ss://Y2hhY2hhMjAtaWV0Zi1wb2x5MTMwNTpwYXNzd29yZA@www.example.com:1080#Example
;config=config/example_external_config.ini
;ver=3
;udp=true
;emoji=false
```
* 修改`build.sh`中的`xxxxxx`为你的 Docker Hub namespace 。
* 自定义`/replacements/config/Custom.ini`。
* 执行`sh build.sh`。

> 详细说明请参考[我的博客](https://www.zouhd.top/article/subconverter-docker)