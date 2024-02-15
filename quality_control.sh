!#bin/bash/
#system time and date at the start
date
#Download the fastq reads
wget http://ftp.sra.ebi.ac.uk/vol1/run/ERR008/ERR008613/200x100x100-081224_EAS20_0008_FC30TBBAAXX-6.tar.gz
#unzip the downloaded file
tar -xfv 200x100x100-081224_EAS20_0008_FC30TBBAAXX-6.tar.gz
#taking only the first 2 million reads (4(number of lines in a single fastq read)* number of reads)
head -8000000 s_6_1.fastq | gzip -f > s_6_1.2M.fastq.gz
head -8000000 s_6_2.fastq | gzip -f > s_6_2.2M.fastq.gz
#Run fastqc for each file to visulaize the reads quality
fastqc s_6_1.2M.fastq.gz s_6_2.2M.fastq.gz
#Run Trimmomatic for both fastq files to remove low quality reads
java -jar /path/to/Trimmomatic-.039/trimmomatic-0.39.jar PE s_6_1.2M.fastq.gz s_6_2.2M.fastq.gz s_6_1_paired.2M.fastq.gz s_6_1_unpaired.2M.fastq.gz s_6_2_paired.2M.fastq.gz s_6_2_unpaired.2M.fastq.gz
ILLUMINACLIP:/path/to/Trimmomatic-0.39/adapters/TruSeq2-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:30 MINLEN:30
# Run FastQC on each fastq output:
fastqc s_6_1_paired.2M.fastq.gz s_6_1_unpaired.2M.fastq.gz s_6_2_paired.2M.fastq.gz s_6_2_unpaired.2M.fastq.gz
# system time and date at the end
date
