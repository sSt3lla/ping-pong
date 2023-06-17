# syntax=docker/dockerfile:1.4
FROM rust as buildbase

FROM buildbase as devcontainer

FROM buildbase as build

WORKDIR /app
COPY Cargo.lock Cargo.toml ./
COPY src/ src
RUN --mount=type=cache,target=/usr/local/cargo/registry cargo build --bins --release

ENTRYPOINT ["./target/release/ping-pong"]

FROM rust as runtime
#USER 1000
COPY --link --from=build /app/target/release/ping-pong /
ENTRYPOINT ["./ping-pong"]