#!/usr/bin/env bash

#SBATCH --job-name=trinity
#SBATCH --partition=pibu_el8
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --mail-user=dominik.kaufmann3@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/dkaufmann3/output_trinity_%j.o
#SBATCH --error=/data/users/dkaufmann3/error_trinity_%j.e

WORKDIR=/data/users/dkaufmann3/assembly_annotation_course
OUTDIR=$WORKDIR/assemblies/trinity

mkdir -p "$OUTDIR"

module load Trinity/2.15.1-foss-2021a

Trinity \
    --seqType fq \
    --left "$WORKDIR"/read_QC/fastp/ERR754081_1_trimmed.fastq.gz \
    --right "$WORKDIR"/read_QC/fastp/ERR754081_2_trimmed.fastq.gz \
    --CPU 16 \
    --max_memory 64G \
    --output "$OUTDIR"
