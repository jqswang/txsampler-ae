# 14.04
FROM ubuntu:trusty

# depedencies we can get from apt-get
RUN apt-get update && apt-get -y -q install \
  autoconf \
  build-essential \
  bzip2 \
  cmake \
  file \
  gcc \
  g++ \
  git \
  libblas-dev \
  libboost-filesystem-dev \
  libboost-thread-dev \
  libbz2-dev \
  libevent-dev \
  libfftw3-dev \
  libfreetype6-dev \
  liblapacke-dev \
  libnuma-dev \
  libpng-dev \
  libtool \
  make \
  mpich \
  patch \
  pkg-config \
  psmisc \
  python \
  python-dev \
  python-pip \
  time \
  unzip \
  zlib1g-dev \
  && apt-get clean autoclean \
  && apt-get autoremove --yes \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/

# install python pacakges
RUN pip install tqdm numpy matplotlib==2.2

RUN mkdir -p /opt/script

# install hpctoolkit-externals 
RUN git clone https://github.com/HPCToolkit/hpctoolkit-externals.git /tmp/hpctoolkit-externals && \
    cd /tmp/hpctoolkit-externals && \
    git checkout c01befe1a500406cafa02f6ae83bf60d6a5b8b56 && \
    chmod u+x configure && \
    ./configure --prefix=/opt/hpctoolkit-externals/install && \
    make -j && make install -j && \
    cd /tmp && rm -rf /tmp/hpctoolkit-externals

# install txsampler
RUN git clone https://github.com/jqswang/txsampler-new.git /tmp/txsampler && \
    cd /tmp/txsampler && \
    git checkout cbea98db9452ef9cd69be2c5547d6c657b38e04b && \
    chmod u+x configure && \
    ./configure --with-externals=/opt/hpctoolkit-externals/install --enable-mpi && \
    make -j && make install -j && \
    cd /tmp && rm -rf /tmp/txsampler

COPY script/* /opt/script/

RUN chmod a+x /opt/script/*

ENV PATH="/opt/script:${PATH}"

# for debug
RUN apt-get -y -q install \
  vim \
  && apt-get clean autoclean \
  && apt-get autoremove --yes \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/


CMD /bin/bash
