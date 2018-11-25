#!/bin/bash
echo "Download the benchmark suite ..."
git clone https://github.com/jqswang/txsampler_benchmark.git /data/txsampler_benchmark
cd /data/txsampler_benchmark/lib && make

echo "Download the benchmark input and decompress it ... It may take long time..."
cd /data/txsampler_benchmark \
  && python /opt/script/download_gdrive.py 1vf_HbWKNQROHI5XIXIAFfHHfkYJYe1yu tsx_input.tar.bz2 \
  && bzip2 -d tsx_input.tar.bz2 \
  && tar -xvf tsx_input.tar
