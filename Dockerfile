FROM golang:latest AS development
RUN apt update
RUN apt install ca-certificates
#RUN git clone --progress --verbose --depth=1 https://github.com/Bpazy/webhook-forwarder /webhook-forwarder
ADD . /webhook-forwarder
WORKDIR /webhook-forwarder
RUN go env && make linux-amd64

FROM ubuntu:latest AS production
COPY entrypoint.sh /usr/local/bin
COPY --from=development /etc/ssl /etc/ssl
COPY --from=development /webhook-forwarder/bin/webhook-forwarder-linux-amd64 /usr/local/bin/webhook-forwarder
RUN useradd -mU -u 1000  whf && chmod -c 0755 /usr/local/bin/entrypoint.sh
USER 1000
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
