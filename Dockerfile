# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

FROM daocloud.io/creditx/base-notebook

MAINTAINER Jupyter Project <jupyter@googlegroups.com>

USER root

# Install all OS dependencies for fully functional notebook server
RUN apt-get update && apt-get install -yq --no-install-recommends \
    git \
    vim \
    curl \
    wget \
    python-dev \
    unzip \
    libsm6 \
    pandoc \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    libxrender1 \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install gcc-4.9 g++-4.9 clang-3.4
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.9
RUN apt-get -y install unzip zip bzip2 libbz2-dev zlib1g-dev 
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
RUN cd / && git clone https://github.com/google/bazel.git
RUN cd /bazel && ./compile.sh
ENV PATH "$PATH:/bazel/output"

# Switch back to creditx to avoid accidental container runs as root
USER creditx
