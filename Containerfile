FROM --platform=${BUILDPLATFORM:-linux/amd64} container-registry.oracle.com/graalvm/jdk-ee:22.3.2

RUN microdnf -y upgrade && \
    microdnf -y install lsof curl ca-certificates openssl git tar sqlite fontconfig freetype tzdata iproute libstdc++ && \
    microdnf clean all

RUN useradd -d /home/container -m container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD [ "/bin/bash", "/entrypoint.sh" ]
