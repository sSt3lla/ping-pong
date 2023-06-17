FROM rust as build

WORKDIR /app
COPY Cargo.lock Cargo.toml ./

RUN cargo fetch

COPY src/ src
RUN cargo build --release

FROM scratch as runtime
WORKDIR /app
COPY --from=builder /app/target/release/ping-pong .
USER 1000
CMD ["./deciduously-com", "-a", "0.0.0.0", "-p", "8080"]