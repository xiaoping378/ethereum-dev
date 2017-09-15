FROM alpine:3.5

RUN \
  apk add --update go git make gcc musl-dev linux-headers ca-certificates && \
  git clone --depth 1 --branch release/1.6 https://github.com/ethereum/go-ethereum && \
  (cd go-ethereum && make all) && \
  cp go-ethereum/build/bin/* /usr/bin && \
  apk del go git make gcc musl-dev linux-headers && \
  rm -rf /go-ethereum && rm -rf /var/cache/apk/* && \
  cd /usr/bin && rm faucet puppeth rlpdump swarm wnode

EXPOSE 8545
EXPOSE 30303

CMD ["/usr/bin/geth"]
