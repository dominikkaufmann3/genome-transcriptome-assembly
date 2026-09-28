#!/usr/bin/env bash

#SBATCH --job-name=flye
#SBATCH --partition=pibu_el8
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --mail-user=dominik.kaufmann3@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/dkaufmann3/output_flye_%j.o
#SBATCH --error=/data/users/dkaufmann3/error_flye_%j.e

WORKDIR=/data/users/dkaufmann3/assembly_annotation_course
OUTDIR=$WORKDIR/assemblies/flye

mkdir -p "$OUTDIR"

apptainer exec /containers/apptainer/flye_2.9.5.sif \
    flye \
    --pacbio-hifi "$WORKDIR"/Dog-4/ERR11437350.fastq.gz \
    --out-dir "$OUTDIR" \
    --threads 16
