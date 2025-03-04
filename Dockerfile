FROM alpine:3.17.1 

LABEL maintainer="yiKyo <yikyo666@gmail.com>"

ARG TARGETOS TARGETARCH TARGETVARIANT CLASH_META_VERSION=v1.14.1

ENV CLASH_META_CONFIG_DIRECTORY=/etc/.clash.meta.d

EXPOSE 7890 9090

RUN apk add --update curl gzip \
    && rm -rf /var/cache/apk/*

RUN curl -LO https://github.com/MetaCubeX/Clash.Meta/releases/download/${CLASH_META_VERSION}/clash.meta-${TARGETOS}-${TARGETARCH}${TARGETVARIANT}-compatible-${CLASH_META_VERSION}.gz \
    && gunzip clash.meta-${TARGETOS}-${TARGETARCH}${TARGETVARIANT}-compatible-${CLASH_META_VERSION}.gz \
    && mv clash.meta-${TARGETOS}-${TARGETARCH}${TARGETVARIANT}-compatible-${CLASH_META_VERSION} /usr/local/bin/clash.meta \
    && chmod +x /usr/local/bin/clash.meta

ENTRYPOINT /usr/local/bin/clash.meta -d $CLASH_META_CONFIG_DIRECTORY
