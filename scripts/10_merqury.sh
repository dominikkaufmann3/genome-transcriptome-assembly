#!/bin/bash
#SBATCH --job-name=merqury
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=8
#SBATCH --mem=40G
#SBATCH --time=08:00:00
#SBATCH --output=slurm-%j.out
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=dominik.kaufmann3@students.unibe.ch

set -euo pipefail

WORKDIR=/data/users/dkaufmann3/assembly_annotation_course
IMAGE=/containers/apptainer/merqury_1.3.sif

READS="$WORKDIR/Dog-4/ERR11437350.fastq.gz"

FLYE="$WORKDIR/assemblies/flye/assembly.fasta"
HIFIASM="$WORKDIR/assemblies/hifiasm/Dog-4.bp.p_ctg.fa"
LJA="$WORKDIR/assemblies/lja/assembly.fasta"

OUTDIR="$WORKDIR/assembly_evaluation/merqury"
READDB="$OUTDIR/Dog-4.k21.meryl"

export MERQURY="/usr/local/share/merqury"
export OMP_NUM_THREADS=8

mkdir -p "$OUTDIR"

# --------------------------------------------------
# 1. Build Meryl k-mer database from PacBio HiFi reads
# --------------------------------------------------

apptainer exec "$IMAGE" \
    meryl count k=21 \
    "$READS" \
    output "$READDB"


# --------------------------------------------------
# 2. Evaluate Flye
# --------------------------------------------------

mkdir -p "$OUTDIR/flye"
cd "$OUTDIR/flye"

apptainer exec "$IMAGE" \
    "$MERQURY/merqury.sh" \
    "$READDB" \
    "$FLYE" \
    flye


# --------------------------------------------------
# 3. Evaluate hifiasm
# --------------------------------------------------

mkdir -p "$OUTDIR/hifiasm"
cd "$OUTDIR/hifiasm"

apptainer exec "$IMAGE" \
    "$MERQURY/merqury.sh" \
    "$READDB" \
    "$HIFIASM" \
    hifiasm


# --------------------------------------------------
# 4. Evaluate LJA
# --------------------------------------------------

mkdir -p "$OUTDIR/lja"
cd "$OUTDIR/lja"

apptainer exec "$IMAGE" \
    "$MERQURY/merqury.sh" \
    "$READDB" \
    "$LJA" \
    lja
