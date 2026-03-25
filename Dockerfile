FROM golang:1.24 AS builder

RUN apt-get update && apt-get install -y git curl bash file && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://github.com/mikefarah/yq/releases/download/v4.9.5/yq_linux_amd64 \
    -o /usr/local/bin/yq && chmod +x /usr/local/bin/yq

COPY . /registry

RUN git clone https://github.com/devfile/registry-support.git /registry-support

RUN bash /registry-support/build-tools/build.sh /registry /build

FROM quay.io/devfile/devfile-index-base:next

COPY --from=builder /build /build
