FROM ubuntu:14.04

RUN apt-get update
RUN apt-get -y install git

RUN apt-get -y install nodejs npm
RUN ln -s /usr/bin/nodejs /usr/local/bin/node

ENV CLI_VERSION 0.1.4
RUN npm install -g ember-cli@$CLI_VERSION bower phantomjs

RUN useradd -m -u 1000 app
USER app
WORKDIR /home/app
ENV HOME /home/app

ADD package.json /home/app/package.json
RUN npm install

ADD .bowerrc /home/app/.bowerrc
ADD bower.json /home/app/bower.json
RUN bower install --config.interactive=false

CMD ["ember", "server"]
EXPOSE 4200 35729
