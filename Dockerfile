FROM ruby:2-alpine AS BUILDER

RUN apk add --no-cache git=2.34.2-r0 \
                       build-base=0.5-r2 && \
    gem install gemirro:1.3.0

WORKDIR /app

FROM ruby:2-alpine

RUN apk add --no-cache tini=0.19.0-r0
COPY --from=BUILDER /usr/local/bundle /usr/local/bundle
WORKDIR /root/

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["gemirro"]
