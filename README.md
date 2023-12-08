
(
	echo "
	  deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse
	  deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
	  deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
	  deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
	" > /etc/apt/sources.list
)

export DEBIAN_FRONTEND=noninteractive

apt update -y

apt install -y clang libicu-dev libcurl4-openssl-dev libssl-dev libpython2.7

# 安装 swift

(
	if [ ! -f /usr/bin/swift ]; then

		_sum=""
		if [ -f ~/swift-5.9.1-RELEASE-ubuntu22.04.tar.gz ]; then
			_sum="`sha256sum ~/swift-5.9.1-RELEASE-ubuntu22.04.tar.gz | \
			grep ea2fe1190a9cb8abed8c5e7b94223a06a23c7dc8cd498850a1c79b8a87e7c251`"
		fi

		if [ "$_sum" == "" ]; then
			u1='https://download.swift.org/swift-5.9.1-release/ubuntu2204'
			u2='/swift-5.9.1-RELEASE/swift-5.9.1-RELEASE-ubuntu22.04.tar.gz'
			wget  -O ~/swift-5.9.1-RELEASE-ubuntu22.04.tar.gz $u1$u2
		fi

		if [ ! -d ~/swift-5.9.1-RELEASE-ubuntu22.04 ]; then
			tar xvzf ~/swift-5.9.1-RELEASE-ubuntu22.04.tar.gz -C ~/
		fi

		if [ -d ~/swift-5.9.1-RELEASE-ubuntu22.04 ]; then
			cp -r -f ~/swift-5.9.1-RELEASE-ubuntu22.04/* /
		fi

	fi
)


# 创建 Winter-kitura

mkdir -p ~/Winter-kitura && cd ~/Winter-kitura && swift package init --type executable


# 调试 
cd ~/Winter-kitura && swift run


# 清除

cd ~/Winter-kitura && swift package clean 


# 编译

cd ~/Winter-kitura && swift build -c release --static-swift-stdlib


# 运行

./.build/release/Winter-kitura





