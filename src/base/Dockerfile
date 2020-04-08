FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y python3-pip awscli openssh-server vim git iputils-ping curl 

EXPOSE 22
