# syntax=docker/dockerfile:1.4
FROM rust:1.70-alpine3.17 as buildbase
RUN apk add pkgconfig openssl openssl-dev musl-dev --no-cache

FROM buildbase as devcontainer
RUN apk add bash docker-cli docker-cli-compose git --no-cache

FROM buildbase as build
WORKDIR /app
COPY Cargo.lock Cargo.toml ./
COPY src/ src
RUN --mount=type=cache,target=/usr/local/cargo/registry --mount=type=cache,target=/app/target <<EOF
cargo build --release
cp target/release/ping-pong ping-pong
EOF

FROM scratch as runtime
USER 1000
EXPOSE 8000
ENV ROCKET_ADDRESS=0.0.0.0
COPY --link --from=build /app/ping-pong /
ENTRYPOINT ["./ping-pong"]