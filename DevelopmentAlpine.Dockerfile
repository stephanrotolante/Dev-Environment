FROM alpine:3.22

RUN apk update \
    && apk add --no-cache bash \
    && rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN addgroup -g $USER_GID $USERNAME \
    && adduser -u $USER_UID -G $USERNAME -s /bin/sh -D $USERNAME

USER $USERNAME

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]