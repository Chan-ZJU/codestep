# LAB-0: 实验环境

> 预计花费三个小时。

我是在 win10 系统上做实验的，而实验环境要求 linux 平台，建议安装 docker 。除此之外 win10 可以选择使用 WSL ，这也完全可行。

为什么使用 docker ？

首先虚拟机笨重，docker 是单进程，轻量级。其次如果你不想在终端中编程的话，虚拟机需要重新安装 IDE ，例如 clion 或 vscode 之类的。而使用 docker 可以直接在 windows 下编程，使用 docker 编译。总之 docker 具备轻量和便捷的特点。

所以不论你是什么系统，安装好 docker 后，后续步骤都相同。

具体的环境搭建：https://cs.weijiew.com/book/csapp/lab0.html

## 0. 安装 docker 

建议先安装 docker

* [Windows Docker 安装](https://www.runoob.com/docker/windows-docker-install.html)
* [Mac下安装docker的三种方法](https://zhuanlan.zhihu.com/p/91116621)

## 1. 使用 docker

docker 安装完毕后打开 CMD 输入如下命令。

下面这个镜像是我已经打包好的镜像，你可以直接拉取。或者选择跳过这一步选择自己制作镜像。 

```sh
docker pull weijiew/csapp_datalab
```

启动镜像:

```
docker container run -it --name=csapp_datalab weijiew/csapp_datalab /bin/bash
```

实验文件都在 `/csapp/data_lab` 中。

如果你不想在终端中敲代码，可以使用 vscode attach 这个容器就可以开始写代码了。（注意安装 docker 插件）

## 2. 自己搭建实验环境

1.  拉取一个 ubuntu:18.04 的镜像。

```
docker pull ubuntu:18.04
```

2. 根据镜像构建容器并设置共享文件夹。

```
docker container run -it -v E:/Repo/CSAPP-Labs:/csapp --name=csapp_env ubuntu:18.04 /bin/bash
```

`E:/Repo/CSAPP-Labs:/csapp` 中 `E:/Repo/CSAPP-Labs` 是本地路径，而 `/csapp` 则是映射到容器中的路径，设置好后二者的内容都是同步的。可以在`E:/Repo/CSAPP-Labs:/csapp`中编辑，在`/csapp`中编译。

查看共享情况：

```
root@ec3dec38c3a9:/# ls
bin  boot  csapp  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@ec3dec38c3a9:/# cd csapp/
```

## 3. 配置容器

1. 更新

更新软件并安装 sudo ，提权操作。
```
apt-get update
apt-get install sudo
``` 

2. 换源

> 这步可以跳过，如果在国内还是建议换一下，速度更快。

安装 vim ，文本编辑工具，为下一步的换源做准备，[vim 使用参考](https://www.runoob.com/linux/linux-vim.html)。

```
apt-get install vim
```

备份并编辑：

```
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo vim /etc/apt/sources.list
```

删除或注释原始内容，并将如下内容贴入：

```
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
```

更新

```
sudo apt-get update
```

3. 安装 c++ 编译环境

```
sudo apt-get install build-essential
sudo apt-get install gcc-multilib
```

## 4. 退出并启动容器

* `exit` 退出容器。
* `docker ps -a` 找到 csapp_env 的容器 ID 。
* `docker start 容器id` 启动容器。
* `docker exec -it 容器id /bin/bash` 进入容器。

# 5. 参考

[windows](https://zhuanlan.zhihu.com/p/340283308) 下环境配置。