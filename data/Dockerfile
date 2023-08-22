FROM node:lts as node-base

ARG _USER
ARG _USER
COPY etc/passwd /etc/passwd
COPY etc/group /etc/group

RUN echo "USER: ${_USER}"
RUN apt update && apt upgrade -y

RUN apt install python3 sudo build-essential -y
RUN groupadd wheel && usermod -a -G wheel ${_USER}
RUN npm install -g npm
RUN echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

RUN echo "SWITCHED USER: ${_USER}"


RUN [ ! -d "/home/${_USER}" ] && mkdir -p /home/${_USER};
RUN chown -R ${_USER}: /home/${_USER}
USER ${_USER}

FROM golang:1.19-alpine as go-base

FROM node-base as node-mev-bot
FROM node-base as node-mev-frontend
USER root
RUN apt update && apt upgrade -y
RUN apt install -y git
USER ${_USER}

FROM node-base as node-smart-contracts
FROM node-base as node-venom

FROM go-base as mev-go-bot
RUN go clean -modcache
RUN GO111MODULE=on go install golang.org/x/sys/wasm@latest
RUN GO111MODULE=on go install github.com/go-interpreter/wagon@latest
RUN GO111MODULE=on go install github.com/go-interpreter/wagon/wasm@latest

