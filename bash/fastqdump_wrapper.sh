#!/bin/bash

prodir="/scratch/nmnh_corals/connellym/projects/pocillopora_hDNA_uces"
#samples=$(cat ${prodir}/data/oury_top_SRA_accessions.txt)
samples=$(cat ${prodir}/data/oury_top5_SRA_samples.txt)

JOBFILE=${prodir}/bash/jobs/fastqdump_${sample}.job

for sample in $samples
do
echo "# /bin/sh" > $JOBFILE
#
echo "#$  -S /bin/sh
#$ -pe mthread 4
#$ -q sThC.q
#$ -l mres=4G,h_data=4G,h_vmem=4G
#$ -cwd
#$ -j y
#$ -N fastqdump_${sample}
#$ -o $prodir/bash/jobs/fastqdump_${sample}
#$ -m bea
#$ -M connellym@si.edu
#" >> $JOBFILE
#

echo "module load bioinformatics/sratoolkit" >> $JOBFILE
#
echo 'echo + `date` job $JOB_NAME started in $QUEUE with jobID=$JOB_ID on $HOSTNAME' >> $JOBFILE
echo 'echo + NSLOTS = $NSLOTS' >> $JOBFILE
#
echo "fastq-dump --split-files --outdir ${prodir}/data/oury_sra/${study} --gzip $sample" >> $JOBFILE
#
echo "#" >> $JOBFILE
echo 'echo = `date` job $JOB_NAME done' >> $JOBFILE
qsub $JOBFILE
done
