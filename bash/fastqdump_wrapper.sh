#!/bin/bash

prodir="/scratch/nmnh_corals/connellym/projects/MetaPocillopora"
study="$1"
samples=$(cat ${prodir}/data/SRR_Acc_List_${study}.txt)

for sample in $samples
do
echo "# /bin/sh" > $prodir/bash/jobs/fastqdump_${study}_${sample}.job
#
echo "# ----------------Parameters---------------------- #" >> $prodir/bash/jobs/fastqdump_${study}_${sample}.job
echo "#$  -S /bin/sh
#$ -pe mthread 4
#$ -q sThC.q
#$ -l mres=4G,h_data=4G,h_vmem=4G
#$ -cwd
#$ -j y
#$ -N fastqdump_${study}_${sample}
#$ -o $prodir/bash/jobs/fastqdump_${study}_${sample}
#$ -m bea
#$ -M connellym@si.edu" >> $prodir/bash/jobs/fastqdump_${study}_${sample}.job
#
echo "# ----------------Modules------------------------- #" >> $prodir/bash/jobs/fastqdump_${study}_${sample}.job
echo "module load bioinformatics/sratoolkit" >> $prodir/bash/jobs/fastqdump_${study}_${sample}.job
echo "#" >> $prodir/bash/jobs/fastqdump_${study}_${sample}.job
echo "# ----------------Your Commands------------------- #" >> $prodir/bash/jobs/fastqdump_${study}_${sample}.job
#
echo 'echo + `date` job $JOB_NAME started in $QUEUE with jobID=$JOB_ID on $HOSTNAME' >> $prodir/bash/jobs/fastqdump_${study}_${sample}.job
echo 'echo + NSLOTS = $NSLOTS' >> $prodir/bash/jobs/fastqdump_${study}_${sample}.job
#
echo "mkdir ${prodir}/data/srareads/${study}" >> $prodir/bash/jobs/fastqdump_${study}_${sample}.job
echo "#" >> $prodir/bash/jobs/fastqdump_${study}_${sample}.job
#
echo "fastq-dump --split-files --outdir ${prodir}/data/srareads/${study} --gzip $sample" >> $prodir/bash/jobs/fastqdump_${study}_${sample}.job
#
echo "#" >> $prodir/bash/jobs/fastqdump_${study}_${sample}.job
echo 'echo = `date` job $JOB_NAME done' >> $prodir/bash/jobs/fastqdump_${study}_${sample}.job
qsub $prodir/bash/jobs/fastqdump_${study}_${sample}.job
done
