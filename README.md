# 以太坊多节点私链开发

为了便于调试开发，利用docker-compose一键启动以太坊的POA共识私链


``docker-compose up``即可启动开发环境，默认启动7个节点，其中3个负责挖矿，默认RPC的通信地址是宿主机的8545端口。


### 目录介绍:

**config目录**， 放置了基本配置信息，其中创世块和账号信息可替换成自己的，具体生成过程可参考[搭建以太坊私链](https://github.com/xiaoping378/blog/blob/master/posts/%E4%BB%A5%E5%A4%AA%E5%9D%8A-%E7%A7%81%E6%9C%89%E9%93%BE%E6%90%AD%E5%BB%BA%E5%88%9D%E6%AD%A5%E5%AE%9E%E8%B7%B5.md) ， 替换后，还要修改下docker-compose.yml里的`ACCOUNT`变量


**docker目录** 是镜像的制作文件

### 调试方法

默认开放了签名节点的RPC接口，地址分别是所在宿主机IP的8545,8546,8547端口，细节如下:
```bash
➜ docker-compose ps                                 
  Name                Command               State                 Ports               
-------------------------------------------------------------------------------------
bootnode   sh -c bootnode -genkey=/ho ...   Up      30303/tcp, 8545/tcp               
node0      sh run.sh                        Up      30303/tcp, 0.0.0.0:8545->8545/tcp 
node1      sh run.sh                        Up      30303/tcp, 0.0.0.0:8546->8545/tcp 
node2      sh run.sh                        Up      30303/tcp, 0.0.0.0:8547->8545/tcp 
node3      sh run.sh                        Up      30303/tcp, 8545/tcp               
node4      sh run.sh                        Up      30303/tcp, 8545/tcp               
node5      sh run.sh                        Up      30303/tcp, 8545/tcp               
node6      sh run.sh                        Up      30303/tcp, 8545/tcp 
```

如果宿主机有geth的话，可以这样操作快捷进入console,
```bash
➜ sudo geth attach ipc:\./node0/geth.ipc
[sudo] password for xxp: 
Welcome to the Geth JavaScript console!

instance: Geth/v1.6.7-stable-ab5646c5/linux-amd64/go1.7.3
coinbase: 0x16d071a5374281dd27f2c946c08bd01283ec86eb
at block: 37 (Fri, 15 Sep 2017 16:10:11 CST)
 datadir: /root/.ethereum
 modules: admin:1.0 clique:1.0 debug:1.0 eth:1.0 miner:1.0 net:1.0 personal:1.0 rpc:1.0 txpool:1.0 web3:1.0

> 
> net.peerCount
6
>
```

如果宿主机没有geth的话，也可以利用容器特性快速操作进入console，
```
➜  docker exec -it node0 sh
/ # geth attach
Welcome to the Geth JavaScript console!

instance: Geth/v1.6.7-stable-ab5646c5/linux-amd64/go1.7.3
coinbase: 0x16d071a5374281dd27f2c946c08bd01283ec86eb
at block: 117 (Fri, 15 Sep 2017 16:14:11 CST)
 datadir: /root/.ethereum
 modules: admin:1.0 clique:1.0 debug:1.0 eth:1.0 miner:1.0 net:1.0 personal:1.0 rpc:1.0 txpool:1.0 web3:1.0

> 
> net.peerCount
6
>
```

### 前端层面

后续会对接前端UI项目
* [EthExplorer](https://github.com/AiEthLink/EthExplorer)
* [ethstats](https://github.com/cubedro/eth-netstats)
