FROM ubuntu AS Builder

RUN set -ex \
    && apt-get update \
    && apt-get install -y \
        curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workdir

RUN set -ex \
    && curl -L -o azcopy.tar.gz \
    https://aka.ms/downloadazcopy-v10-linux \
    && tar -xf azcopy.tar.gz --strip-components=1 \
    && rm -f azcopy.tar.gz

FROM ubuntu

RUN set -ex \
    && apt-get update \
    && apt-get install -y \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY --from=Builder /workdir/azcopy /usr/local/bin

RUN echo "azcopy login --identity\nwhile true\ndo\n    azcopy sync \$SOURCE \$DEST --recursive=true\n    if [ -z \${REPEAT+x} ]\n    then\n        break\n    fi\n    sleep \$((\$REPEAT*60))\ndone" > /entrypoint.sh

ENTRYPOINT [ "/bin/bash", "/entrypoint.sh" ]
