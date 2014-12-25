FROM sanemat/gocha:latest

MAINTAINER sanemat sanemat@tachikoma.io

# Create user
RUN adduser appuser
# error using chpasswd with host networking and ubuntu:14.04 image Issue
# github.com/docker/docker/issues/5704
# RUN echo appuser:appuser234 | chpasswd
RUN echo "appuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/docker

# Change user
USER appuser
ENV HOME /home/appuser
WORKDIR /home/appuser

# Install xbuild
RUN git clone https://github.com/tagomoris/xbuild /home/appuser/xbuild
RUN mkdir -p /home/appuser/local

# Install app languages
RUN xbuild/ruby-install 2.0.0-p598 /home/appuser/local/ruby-2.0
RUN xbuild/node-install v0.10.31 /home/appuser/local/node-v0.10
RUN xbuild/perl-install 5.20.1 /home/appuser/local/perl-5.20
RUN xbuild/python-install 3.4.1 /home/appuser/local/python-3.4

ENV PATH /home/appuser/local/node-v0.10/bin:/home/appuser/local/perl-5.20/bin:/home/appuser/local/python-3.4/bin:/home/appuser/local/ruby-2.0/bin:$PATH

# Install bundle libraries
# bundler and carton already installed
RUN npm install -g david

# Re change user
USER root

# docker permission bug?
RUN mv /home/appuser /temporary_dir
RUN chown -R appuser:appuser /temporary_dir
RUN cp -a /temporary_dir -T /home/appuser
RUN rm -rf /temporary_dir
