FROM debian:11.11-slim

RUN apt update

RUN ulimit -c unlimited

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN groupadd -g 1000 stephan
RUN useradd -u 1000 -g 1000 -m -s /bin/bash stephan
USER stephan

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]