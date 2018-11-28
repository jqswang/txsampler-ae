txsampler-ae
========

Artifact evaluation for TxSampler

Setups
============

1. Build and launch the docker image
   1. Download this repository
    
       ```$ git clone https://github.com/jqswang/txsampler-ae.git```
    
   1. Build the docker image
       ```
       $ cd txsampler-ae
       $ make build
       ```
      The building process may take 30~60 minutes.
   1. Run the image
      ```
      $ make start
      ```
      Then you will see the bash terminal inside the container. Now you have finished building the environment.
      Whenever you want to exit the container, use ```$ exit``` inside the container. You can come back by using ```$ make restart``` from the host.
1. Download the benchmark and input.
   
   Now you are inside the container.
   We are going to download the benchmark and input by simply using
   ```
   $ get_benchmark_and_input.sh
   ```
   You will see a folder ```/data/txsampler_benchmark```.
   Let's go there to set some environmental variables:
   ```
   $ cd /data/txsampler_benchmark
   $ source set_env
   ```
   
Evaluations
============
1. Overhead of TxSampler
   ```
   $ measure_overhead.py all
   ```
   It will measure the the overhead of all the applications, present the result in the standard output and generate a figure (named ```output.pdf```) similar to Figure 5 in the current working directory.
   You can see more options here:
   ```
   $ measure_overhead.py --help
   ```   
1. Speedup of optimized applications
   ```
   measure_speedup.py all
   ```
   The script will run all the applications shown in Table 1 in the paper and calculate the speedup.
   You can see more options here:
   ```
   measure_speedup.py --help
   ```
1. Profile analysis
   There are quite a few case studies in the paper and appendix.
   You may use the following command to produce a profile database of an application which interests you most.
   Suppose you want to profile dedup.
   ```
   generate_profile.py dedup
   ```
   The script output will tell you where the database directory is generated.
   Copy the database to whereever you want and use hpcview(download it from [here](http://hpctoolkit.org/software.html)) to open the database directory.
   You can see more options here:
   ```
   generate_profile.py --help
   ```
   

