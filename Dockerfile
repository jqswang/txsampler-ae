# 14.04
FROM ubuntu:trusty

RUN apt-get update && apt-get -y -q install \
  autoconf \
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
  time \
  unzip \
  zlib1g-dev \
  && apt-get clean autoclean \
  && apt-get autoremove --yes \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN mkdir -p /opt/script

# install hpctoolkit-externals 
RUN git clone https://github.com/HPCToolkit/hpctoolkit-externals.git /tmp/hpctoolkit-externals && \
    cd /tmp/hpctoolkit-externals && \
    git checkout 3d2953623357bb06e9a4b51eca90a4b039c2710e && \
    chmod u+x configure && \
    ./configure --prefix=/opt/hpctoolkit-externals/install && \
    make -j && make install -j && \
    cd /tmp && rm -rf /tmp/hpctoolkit-externals

# install PAPI
RUN git clone https://github.com/jqswang/papi-tx.git /tmp/papi-tx && \
    cd /tmp/papi-tx/src && \
    git checkout 550f07834b24cd63f7aa17828811c035df83b0cd && \
    chmod u+x configure && \
    ./configure --prefix=/opt/papi/install && \
    make -j && make install -j && \
    cd /tmp && rm -rf /tmp/papi-tx


# install txsampler
RUN git clone https://github.com/jqswang/txsampler.git /tmp/txsampler && \
    cd /tmp/txsampler && \
    git checkout 19d2b188e712dd86be84d84c75e08af320304c2c && \
    chmod u+x configure && \
    ./configure --with-externals=/opt/hpctoolkit-externals/install --with-papi=/opt/papi/install --enable-mpi && \
    make -j && make install -j && \
    cd /tmp && rm -rf /tmp/txsampler

COPY script/* /opt/script/

RUN chmod a+x /opt/script/*

ENV PATH="/opt/script:${PATH}"

CMD /bin/bash
