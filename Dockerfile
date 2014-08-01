FROM sanemat/gocha:latest

MAINTAINER sanemat sanemat@tachikoma.io

# Change user
USER appuser
WORKDIR /home/appuser
ENV HOME /home/appuser

# Install app languages
RUN xbuild/ruby-install 2.1.2 $HOME/local/ruby-2.1
RUN xbuild/node-install v0.10.29 $HOME/local/node-v0.10

ENV PATH $HOME/local/ruby-2.1/bin:$PATH
ENV PATH $HOME/local/node-v0.10/bin:$PATH
