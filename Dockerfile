FROM debian:bullseye

RUN apt-get update && apt-get install -y ffmpeg curl && apt-get clean

ENV TWITCH_USER=""
ENV RESTREAM_KEY=""

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
