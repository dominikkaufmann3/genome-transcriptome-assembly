#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastp
#SBATCH --mail-user=dominik.kaufmann3@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/dkaufmann3/output_fastp_%j.o
#SBATCH --error=/data/users/dkaufmann3/error_fastp_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/dkaufmann3/assembly_annotation_course
OUTDIR=$WORKDIR/read_QC/fastp

mkdir -p "$OUTDIR"

module load fastp/0.23.4-GCC-10.3.0

# Illumina paired-end RNA-seq: filter and trim
fastp \
    --in1 "$WORKDIR"/RNAseq_Sha/ERR754081_1.fastq.gz \
    --in2 "$WORKDIR"/RNAseq_Sha/ERR754081_2.fastq.gz \
    --out1 "$OUTDIR"/ERR754081_1_trimmed.fastq.gz \
    --out2 "$OUTDIR"/ERR754081_2_trimmed.fastq.gz \
    --html "$OUTDIR"/RNAseq_Sha_fastp.html \
    --json "$OUTDIR"/RNAseq_Sha_fastp.json \
    --thread 4

# PacBio HiFi: statistics only, no filtering
fastp \
    --in1 "$WORKDIR"/Dog-4/ERR11437350.fastq.gz \
    --disable_quality_filtering \
    --disable_length_filtering \
    --disable_adapter_trimming \
    --html "$OUTDIR"/Dog-4_fastp.html \
    --json "$OUTDIR"/Dog-4_fastp.json \
    --thread 4 \
    --stdout > /dev/null
