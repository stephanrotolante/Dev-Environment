FROM debian:11.11-slim

RUN apt update

RUN ulimit -c unlimited

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN groupadd -g $USER_GID $USERNAME \
    && useradd -u $USER_UID -g $USER_GID -m -s /bin/bash $USERNAME

USER $USERNAME

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]