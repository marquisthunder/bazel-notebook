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

RUN sudo add-apt-repository ppa:webupd8team/java
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install oracle-java8-installer gcc-4.9 g++-4.9 clang-3.4 gdebi-core
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.9
RUN apt-get -y install unzip zip bzip2 libbz2-dev zlib1g-dev 
RUN wget https://github.com/bazelbuild/bazel/releases/download/0.2.2b/bazel_0.2.2b-linux-x86_64.deb && gdebi ./bazel_0.2.2b-linux-x86_64.deb
ENV PATH "$PATH:/bazel/output"

# Switch back to creditx to avoid accidental container runs as root
USER creditx
