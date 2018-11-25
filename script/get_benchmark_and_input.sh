#!/bin/bash
echo "Download the benchmark suite ..."
git clone https://github.com/jqswang/txsampler_benchmark.git /data/txsampler_benchmark

echo "Download the benchmark input and decompress it ..."
cd /data/txsampler_benchmark \
  && gdown.pl https://drive.google.com/open?id=1vf_HbWKNQROHI5XIXIAFfHHfkYJYe1yu tsx_input.tar.bz2 \
  && bzip2 -d tsx_input.tar.bz2 \
  && tar -xvf tsx_input.tar
