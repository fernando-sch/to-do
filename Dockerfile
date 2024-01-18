# https://hub.docker.com/_/elixir/
FROM elixir:1.14-alpine

# init
RUN apk update && \
    apk add ca-certificates && update-ca-certificates && \
    apk add git bash postgresql-client openssl curl alpine-sdk coreutils && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install hex phx_new --force

COPY . /opt
ENV MIX_ENV=dev PORT=4000 APPSIGNAL_BUILD_FOR_MUSL=1

WORKDIR /opt
EXPOSE 4000
CMD ["sh", "-c", "mix do ecto.create, ecto.migrate; mix phx.server"]
