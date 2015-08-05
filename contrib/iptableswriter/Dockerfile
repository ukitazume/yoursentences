FROM alpine
RUN apk add --update-cache bash sudo curl && rm -rf /var/cache/apk/*
ADD run.sh /
ENV COREOS_PRIVATE_IPV4 127.0.0.1
RUN chmod +x run.sh
VOLUME /var/lib/iptables/
CMD ["/run.sh"]
