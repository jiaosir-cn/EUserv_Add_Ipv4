#!/bin/bash
#更新安装环境
echo -e "更新安装环境"
apt update
UCF_FORCE_CONFOLD=1 DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" -y install curl
apt install lsb-release iptables -y
echo "deb http://deb.debian.org/debian $(lsb_release -sc)-backports main" | sudo tee /etc/apt/sources.list.d/backports.list
apt update
apt install -y net-tools iproute2 openresolv dnsutils
apt install wireguard-tools --no-install-recommends



#download wgcf wireguard-go
echo -e "download wgcf wireguard-go"
wget https://cdn.jsdelivr.net/gh/jiaosir-cn/EUserv_Add_Ipv4/wgcf_reg/wgcf_2.2.3_linux_amd64 -O /usr/local/bin/wgcf
wget https://cdn.jsdelivr.net/gh/jiaosir-cn/EUserv_Add_Ipv4@main/down__wireguard-go/wireguard-go -O /usr/bin/wireguard-go


#添加权限
echo -e "添加权限"
chmod +x /usr/local/bin/wgcf
chmod +x /usr/bin/wireguard-go

#注册生成wgcf账号，配置文件
echo -e "注册生成wgcf账号，配置文件"
echo|wgcf register
wgcf generate

#替换配置文件
echo -e "替换配置文件"
sed -i 's/1.1.1.1/9.9.9.10,8.8.8.8,1.1.1.1/g' wgcf-profile.conf
sed -i '/0\.0\.0\.0\/0/d' wgcf-profile.conf

#创建文件夹copy文件
echo -e "创建文件夹copy文件"
mkdir -p /etc/wireguard
cp wgcf-profile.conf /etc/wireguard/wgcf.conf

#关闭->启动warp
wg-quick down wgcf
echo -e "启动warp"
wg-quick up wgcf

#设置进程守护 开机启动
echo -e "设置进程守护 开机启动"
systemctl enable wg-quick@wgcf
systemctl start wg-quick@wgcf

#删除本地路径多余文件
echo -e "删除本地路径多余文件"
rm -f ___ipv6_add_ipv4* wgcf* wireguard-go*

#设置ipv4优先并测试
echo -e "设置ipv4优先并测试"
echo 'precedence  ::ffff:0:0/96   100' |  tee -a /etc/gai.conf
echo -e "显示ipv4地址即成功"
curl ip.p3terx.com
