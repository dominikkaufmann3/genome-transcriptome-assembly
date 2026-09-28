#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=02:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=dominik.kaufmann3@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/dkaufmann3/output_fastqc_%j.o
#SBATCH --error=/data/users/dkaufmann3/error_fastqc_%j.e
#SBATCH --partition=pshort_el8

WORKDIR=/data/users/dkaufmann3/assembly_annotation_course

module load FastQC/0.11.9-Java-11

fastqc \
    "$WORKDIR"/Dog-4/*.fastq.gz \
    "$WORKDIR"/RNAseq_Sha/*.fastq.gz \
    --outdir="$WORKDIR"/read_QC/fastqc
