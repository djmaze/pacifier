FROM ubuntu:14.04

RUN apt-get update
RUN apt-get -y install git

RUN apt-get -y install nodejs npm
RUN ln -s /usr/bin/nodejs /usr/local/bin/node

ENV CLI_VERSION 0.0.42
RUN npm install -g ember-cli bower phantomjs

RUN useradd -m -u 1000 app
USER app
WORKDIR /home/app
ENV HOME /home/app

CMD ["ember", "server"]
EXPOSE 4200 35729
