FROM alpine:latest AS builder

RUN set -xe; \
	apk add --no-cache --virtual .build-deps \
		git \
		alpine-sdk \
		flex \
		bison \
		sqlite-dev \
		mbedtls-dev \
		zlib-dev \
		automake \
		autoconf \
		libtool \
	\
	&& git clone https://github.com/solanum-ircd/solanum.git \
	&& cd /solanum \
        && ./autogen.sh \
	&& ./configure --prefix=/usr/local/ --enable-mbedtls \
	&& make \
        && make install \
	&& mv /usr/local/etc/ircd.conf.example /usr/local/etc/ircd.conf \
	&& apk del .build-deps \
	&& rm -rf /var/cache/apk/*

FROM alpine:latest

RUN adduser -D ircd
RUN apk add --no-cache sqlite-dev mbedtls libtool
COPY --from=builder --chown=ircd /usr/local /usr/local

USER ircd

EXPOSE 5000
EXPOSE 6665-6669
EXPOSE 6697
EXPOSE 9999

CMD ["/usr/local/bin/solanum", "-foreground"]
