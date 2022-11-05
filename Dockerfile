ARG BUILD_FROM
FROM $BUILD_FROM as builder
RUN  apk add --no-cache --virtual .build-dependencies \
      g++ \
      gcc \
      git \
      libc-dev \
      libffi-dev \
      postgresql-dev \
      linux-headers \
      make \
      rust \
      cargo \
      openssl-dev \
      py3-pip \
      python3-dev \
    \
    && apk add --no-cache \
      openssl \
      nginx \
      sqlite \
    && pip install --upgrade pip \
    && pip install daphne \
    \
    && cd /etc \
    && git clone https://github.com/etesync/server.git --branch v0.10.0 --single-branch \
    && cd server \
    && pip install -r requirements.txt \
    && ./manage.py collectstatic \
    \
    && apk del --no-cache --purge .build-dependencies \
    && rm -f -r /etc/nginx

COPY ./rootfs /
