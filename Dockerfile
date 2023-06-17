# syntax=docker/dockerfile:1.3-labs
FROM rust as build

WORKDIR /app
COPY Cargo.lock Cargo.toml ./


# Downloads dependencies. Needs a fake main.rs file to allow this
RUN --mount=type=cache,target=/usr/local/cargo/registry <<EOF
mkdir src
echo "fn main() {}" > src/main.rs
cargo fetch
EOF

COPY src/ src
RUN --mount=type=cache,target=/usr/local/cargo/registry cargo build --release

FROM scratch as runtime
WORKDIR /app
COPY --from=build /app/target/release/ping-pong .
USER 1000
CMD ["./ping-pong", "-a", "0.0.0.0", "-p", "8080"]