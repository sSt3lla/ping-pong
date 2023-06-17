# syntax=docker/dockerfile:1.3-labs
FROM rust as build

WORKDIR /app
COPY Cargo.lock Cargo.toml ./
COPY src/ src
RUN --mount=type=cache,target=/usr/local/cargo/registry cargo build --release

RUN <<EOF
chown 1000:1000 /app/target/release/ping-pong
chmod u+x /app/target/release/ping-pong
EOF

FROM scratch as runtime
WORKDIR /app
USER 1000
COPY --from=build /app/target/release/ping-pong ./
CMD ["./ping-pong", "-a", "0.0.0.0", "-p", "8080"]