#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=02:00:00
#SBATCH --job-name=jellyfish
#SBATCH --mail-user=dominik.kaufmann3@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/dkaufmann3/output_jellyfish_%j.o
#SBATCH --error=/data/users/dkaufmann3/error_jellyfish_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/dkaufmann3/assembly_annotation_course
OUTDIR=$WORKDIR/read_QC/kmer_counting

mkdir -p "$OUTDIR"

module load Jellyfish/2.3.0-GCC-10.3.0

jellyfish count \
    -C \
    -m 21 \
    -s 5G \
    -t 4 \
    -o "$OUTDIR/Dog-4_k21.jf" \
    <(zcat "$WORKDIR"/Dog-4/ERR11437350.fastq.gz)

jellyfish histo \
    -t 4 \
    "$OUTDIR/Dog-4_k21.jf" \
    > "$OUTDIR/Dog-4_k21.histo"
