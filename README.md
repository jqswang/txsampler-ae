txsampler-ae
========

Artifact evaluation for TxSampler

Setups
============

1. Build and launch the docker image
   
   **Note:** You will need root privilege to use [Docker](https://www.docker.com/).
   You may refer to the [document](https://docs.docker.com/install/#supported-platforms) to install it if Docker is not available on your system.
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
      
      The directory ```./mydata``` on the host system is mapped to ```/data``` inside the container and you may utilize it to transfer files between the host and the container. It is also recommended to perform all the experiments under ```/data``` or its subdirectories.
      
   1. *(optional) Rebuild the image
      
      In case you want to rebuild the image, temporally move ```./mydata``` out of the current directory; otherwise you will experience significant slow-down.
      When finished, put ```mydata``` back under the current directory.
      
1. Download the benchmark and input.
   
   Now you are inside the container.
   We are going to download the benchmark and input by simply using
   ```
   $ get_benchmark_and_input.sh
   ```
   The input file is quite large and it may take 15 mins or longer to finish the decompression.
   
   You will see a folder ```/data/txsampler_benchmark```.
   Let's go there to set some environmental variables:
   ```
   $ cd /data/txsampler_benchmark
   $ source set_env
   ```
1. Modify the ```run.conf``` file
   You need to edit ```/data/txsampler_benchmark/run.conf``` to fit your current platform. There are two fields you need to set:
   
   `num_threads`: the number of threads you want to launch for each application (not applicable to PARSEC)
   
   `cpu_list`: the CPUs that the launched application will run on (e.g., `1,2,3,4`, `1-4`)
   
   It is recommended to run all the experiments in one single NUMA node and fully occupy every core of this NUMA node. Probably you can use the following commands to help you decide:
   ```
   # Set num_threads to the output from the following command:
   $ lscpu | grep "Core(s) per socket" | awk '{print $NF}'
   # Set cpu_list to the output from the following command:
   $ lscpu | grep "NUMA node0" | awk '{print $NF}' | cut -d',' -f1-$(lscpu | grep "Core(s) per socket" | awk '{print $NF}')
   ```
   
   
   
Evaluations
============
For all the scripts introduced below, you can use `--help` option to view all the available options. It is also recommended to use `--verbose` for all experiments so that you could keep track of the progress.

1. Overhead of TxSampler
   ```
   $ measure_overhead.py all
   ```
   It will measure the the overhead of all the applications, present the result in the standard output and generate a figure (named ```output.pdf```) similar to Figure 5 in the current working directory.

1. Speedup of optimized applications
   ```
   measure_speedup.py all
   ```
   The script will run all the applications shown in Table 1 in the paper and calculate the speedup.

1. Profile analysis
   There are quite a few case studies in the paper and appendix.
   You may use the following command to produce a profile database of an application which interests you most.
   Suppose you want to profile dedup.
   ```
   generate_profile.py dedup
   ```
   The script output will tell you where the database directory is generated.
   Copy the database to whereever you want and use hpcview(download it from [here](http://hpctoolkit.org/software.html)) to open the database directory.
   
   We have also prepared the database of dedup we generated, and you can download it [here](https://drive.google.com/open?id=1uKVT9eNEJ6MimwYtGFDF_-Xsmd2DOdo_). 

