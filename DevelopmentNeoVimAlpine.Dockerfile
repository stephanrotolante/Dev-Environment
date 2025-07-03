FROM alpine:3.22

RUN apk update \
    && apk add --no-cache \
        neovim=0.11.1-r1 \
        lua5.4=5.4.7-r0 \
        luarocks=3.11.1-r0 \
        git=2.49.0-r0 \
        curl=8.14.1-r1 \
        ripgrep=14.1.1-r0 \
        fd=10.2.0-r0 \
        bash=5.2.37-r0 \
        unzip=6.0-r15 \
        tree=2.2.1-r0 \
        gcc=14.2.0-r6 \
        musl-dev=1.2.5-r10 \
        && rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN addgroup -g $USER_GID $USERNAME \
    && adduser -u $USER_UID -G $USERNAME -s /bin/sh -D $USERNAME

USER $USERNAME

COPY ./init.lua /home/$USERNAME/.config/nvim/init.lua

# Run plugin sync
RUN nvim --headless "+Lazy! sync" +qa || true

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]
