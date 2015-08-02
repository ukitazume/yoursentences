FROM alpine:3.1
RUN apk add --update-cache curl bash sudo nginx && rm -rf /var/cache/apk/*
COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /tmp/nginx/client-body
VOLUME ["/tmp/nginx/"]

COPY dist /dist
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
