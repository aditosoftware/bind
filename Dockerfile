FROM alpine:latest

RUN apk add --no-cache bind && \
        rm -f /var/cache/apk/*

# provide minimal out of the box configuration
RUN ["ln", "-s", "/etc/bind/named.conf.authoritative", "/etc/bind/named.conf"]

# directory skeleton
RUN ["mkdir", "/etc/bind/keys"]
RUN ["mkdir", "/etc/bind/zones"]
RUN ["chown", "named:named", "/etc/bind/keys", "/etc/bind/zones"]

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

USER named
EXPOSE 53/tcp 53/udp
CMD ["named", "-g"]
