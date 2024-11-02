# Lab 9 DNA Sequencing Technologies

1. Connect to remote linux server hosted on AWS EC2

__Replace user_name__ in the command below

```sh
ssh username@ec2-34-215-52-146.us-west-2.compute.amazonaws.com
```

username is your school email user name

Please find the IP address and password from your Email



2. Create your lab directory

```sh
cd ~  # change to home directory
mkdir btech
cd btech 
mkdir lab9
cd lab9
```

3. Install conda and activate btech conda environment

```sh
bash /home/shared_resources/Miniconda3-latest-Linux-x86_64.sh -b -u -p ~/miniconda3

~/miniconda3/bin/conda init bash

source ~/.bashrc
```



4. Install package with conda

```sh
conda install -y bioconda/label/cf201901::fastp
```



5. Download Raw Reads

```sh
curl -s https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/main/lab9/Sacc.R1.fastq.gz -o Sacc.R1.fastq.gz 

curl -s https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/main/lab9/Sacc.R2.fastq.gz -o Sacc.R2.fastq.gz 
```



6. Run `fastp` to filter raw reads and get reports

```sh
fastp -i Sacc.R1.fastq.gz -I Sacc.R2.fastq.gz -o Sacc.R1.filter_fastq.gz -O Sacc.R2.filter.fastq.gz -h Sacc_R12.fastp.html
```



7. Transfer the sequence filter report back to your local computer

___NOTE: Run the following command on your local laptop___

__Replace user_name__ in the command below

```sh
scp user_name@ec2-34-215-52-146.us-west-2.compute.amazonaws.com:~/btech/lab9/Sacc_R12.fastp.html .
```



8. Check fastp filter results

```sh
open Sacc_R12.fastp.html
```

if open command is not working, you can navigate to the file and open it with your web browser (e.g., Chrome or Microsoft Edge)
