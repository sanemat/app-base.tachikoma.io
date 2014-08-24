FROM sanemat/gocha:latest

MAINTAINER sanemat sanemat@tachikoma.io

# Create user
ENV APP_USER appuser
RUN adduser $APP_USER
# error using chpasswd with host networking and ubuntu:14.04 image Issue
# github.com/docker/docker/issues/5704
# RUN echo $APP_USER:$APP_USER234 | chpasswd
RUN echo "$APP_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/docker

# Change user
USER $APP_USER
ENV HOME /home/$APP_USER
WORKDIR $HOME

# Install xbuild
RUN git clone https://github.com/tagomoris/xbuild $HOME/xbuild
RUN mkdir -p $HOME/local

# Install app languages
RUN xbuild/ruby-install 2.0.0-p481 $HOME/local/ruby-2.0
RUN xbuild/node-install v0.10.30 $HOME/local/node-v0.10
RUN xbuild/perl-install 5.20.0 $HOME/local/perl-5.20

ENV PATH $HOME/local/ruby-2.0/bin:$PATH
ENV PATH $HOME/local/node-v0.10/bin:$PATH
ENV PATH $HOME/local/perl-5.20/bin:$PATH

# Install bundle libraries
# bundler and carton already installed
RUN npm install -g david

# Re change user
USER root
