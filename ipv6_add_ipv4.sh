#!/bin/bash
//更新安装环境
apt update && apt install curl sudo lsb-release iptables -y
echo "deb http://deb.debian.org/debian $(lsb_release -sc)-backports main" | sudo tee /etc/apt/sources.list.d/backports.list
apt update
apt install net-tools iproute2 openresolv dnsutils -y
apt install wireguard-tools --no-install-recommends -y


//download wgcf wireguard-go
wget https://cdn.jsdelivr.net/gh/jiaosir-cn/EUserv_Add_Ipv4/wgcf_reg/wgcf_2.2.3_linux_amd64 -O /usr/local/bin/wgcf
wget https://cdn.jsdelivr.net/gh/jiaosir-cn/EUserv_Add_Ipv4/Down_wireguard-go/wireguard-go -O /usr/bin/wireguard-go


//添加权限
chmod +x /usr/local/bin/wgcf
chmod +x /usr/bin/wireguard-go

//注册生成wgcf账号，配置文件
echo|wgcf register
wgcf generate

//替换配置文件
sed -i 's/engage.cloudflareclient.com/2606:4700:d0::a29f:c001/g' wgcf-profile.conf
sed -i '/\:\:\/0/d' wgcf-profile.conf

//创建文件夹copy文件
mkdir -p /etc/wireguard
cp wgcf-profile.conf /etc/wireguard/wgcf.conf

//设置进程守护 开机启动
systemctl enable wg-quick@wgcf
systemctl start wg-quick@wgcf

//删除本地路径多余文件
rm -f ipv6_add_ipv4* wgcf* wireguard-go*

//设置ipv4优先并测试
echo 'precedence  ::ffff:0:0/96   100' |  tee -a /etc/gai.conf
echo -e "显示ipv4地址即成功"
curl ip.p3terx.com
