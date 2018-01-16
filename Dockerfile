FROM phusion/baseimage:latest

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive --no-install-recommends"

RUN apt-get update && \
    apt-get -y install \
    expect \
    redis-server \
    nodejs \
    npm

RUN ln -f -s /usr/bin/nodejs /usr/bin/node


RUN apt-get update && \
    apt-get install -y python3-pip

RUN pip3 install --upgrade pip
RUN pip3 install awscli

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN npm cache clean
RUN npm install -g coffee-script
RUN npm install -g yo generator-hubot
RUN npm install cheerio --save && npm install

# Create hubot user
RUN useradd -d /hubot -m -s /bin/bash -U hubot

# Activate some built-in scripts
ADD external-scripts.json /hubot/
ADD package.json /hubot/
ADD scripts/ /hubot/scripts
ADD ENV /hubot/env.sh
RUN chown -R hubot:hubot /hubot

# Log in as hubot user and change directory
USER hubot
WORKDIR /hubot

# Install hubot
RUN yo hubot --owner="Rick Russell" --name="genie" --description="HuBot on Docker" --defaults

# aws
# CMD ["/bin/sh", "-c", "aws s3 cp --region us-west-2 s3://hubot-secrets/env.sh .; . ./env.sh; bin/hubot --adapter slack"]
CMD ["/bin/sh", "-c", ". ./env.sh; bin/hubot --adapter slack"]
