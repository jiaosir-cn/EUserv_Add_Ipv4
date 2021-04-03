# EUserv_Add_Ipv4




不限于 EUserv的ipv6主机
其他OpenVZ架构的主机均可

 支持Ubuntu 18.04 20.04 
                 Debian 8 9 10
     
     
  用于ipv6添加ipv4 一键安装
   
```
wget -qO- https://cdn.jsdelivr.net/gh/jiaosir-cn/EUserv_Add_Ipv4@main/___ipv6_add_ipv4.sh | bash
```
-------------------------------------------------------------------------------------------------------
  用于ipv4添加ipv6 一键安装
  
```
wget -qO- https://cdn.jsdelivr.net/gh/jiaosir-cn/EUserv_Add_Ipv4@main/___ipv4_add_ipv6.sh | bash
```



-------------------------------------------------------------------------------------------------------



手动开启
```
wg-quick up wgcf
```

手动关闭
```
wg-quick down wgcf
```

查看当前状态
```
wg
```




感谢在网络上写文章并且编译wireguard-go的人。
感谢ViRb3的wgcf项目。


## 随时间增长的stars

[![Stargazers over time](https://starchart.cc/jiaosir-cn/EUserv_Add_Ipv4.svg)](https://starchart.cc/jiaosir-cn/EUserv_Add_Ipv4)
