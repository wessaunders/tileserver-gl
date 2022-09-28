FROM node:16-bullseye AS builder

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get -qq update \
    && apt-get -y --no-install-recommends install \
    apt-transport-https \
    curl \
    unzip \
    build-essential \
    python \
    libcairo2-dev \
    libgles2-mesa-dev \
    libgbm-dev \
    libprotobuf-dev \
    && apt-get -y --purge autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY tileserver-gl-master/. /usr/src/app

ENV NODE_ENV="production"

RUN cd /usr/src/app && npm install --production

RUN wget https://github.com/maptiler/tileserver-gl/releases/download/v1.3.0/test_data.zip
RUN unzip test_data.zip -d /usr/src/app/data

FROM node:16-bullseye-slim AS final

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get -qq update \
    && apt-get -y --no-install-recommends install \
    libgles2-mesa \
    libegl1 \
    xvfb \
    xauth \
    libopengl0 \
    libcurl4 \
    curl \
    libuv1-dev \
    libc6-dev \
    libcap2-bin \
    && apt-get -y --purge autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl http://archive.ubuntu.com/ubuntu/pool/main/libj/libjpeg-turbo/libjpeg-turbo8_2.0.3-0ubuntu1_amd64.deb --output libjpeg-turbo8_2.0.3-0ubuntu1_amd64.deb
RUN apt install ./libjpeg-turbo8_2.0.3-0ubuntu1_amd64.deb
RUN curl http://archive.ubuntu.com/ubuntu/pool/main/i/icu/libicu66_66.1-2ubuntu2_amd64.deb --output libicu66_66.1-2ubuntu2_amd64.deb
RUN apt install ./libicu66_66.1-2ubuntu2_amd64.deb

COPY --from=builder /usr/src/app /app

VOLUME /data
WORKDIR /data
COPY --from=builder /usr/src/app/data .

ENV NODE_ENV="production"
ENV CHOKIDAR_USEPOLLING=1
ENV CHOKIDAR_INTERVAL=500


EXPOSE 80


CMD [ "/app/docker-entrypoint.sh" ]
# USER node:node

# ENTRYPOINT ["/app/docker-entrypoint.sh"]


# FROM nginx:mainline
# COPY --from=final /app /usr/share/nginx
# COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf


# CMD ["nginx", "-g", "daemon off;"]
