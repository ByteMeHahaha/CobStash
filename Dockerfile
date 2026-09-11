FROM ubuntu:24.04 AS build

RUN apt-get update && \
  apt-get install -y gnucobol && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /src

COPY ./src .

RUN cobc -I ./copy \
  -free \
  -x ./main.cob \
  -o ./CobStash \
  -w -q

# ---

FROM ubuntu:24.04

WORKDIR /app

COPY --from=build /src/CobStash .

CMD ["./CobStash"]
