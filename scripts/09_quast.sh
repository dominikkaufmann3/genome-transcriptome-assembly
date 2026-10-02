#!/bin/bash
#SBATCH --job-name=quast
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=08:00:00
#SBATCH --output=slurm-%j.out
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=dominik.kaufmann3@students.unibe.ch

set -euo pipefail

WORKDIR=/data/users/dkaufmann3/assembly_annotation_course
QUAST=/containers/apptainer/quast_5.2.0.sif

REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
ANNOT=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.57.gff3

FLYE="$WORKDIR/assemblies/flye/assembly.fasta"
HIFIASM="$WORKDIR/assemblies/hifiasm/Dog-4.bp.p_ctg.fa"
LJA="$WORKDIR/assemblies/lja/assembly.fasta"

OUTDIR="$WORKDIR/assembly_evaluation/quast"

mkdir -p "$OUTDIR"

# ----------------------------
# QUAST without reference
# ----------------------------

apptainer exec "$QUAST" quast.py \
    "$FLYE" \
    "$HIFIASM" \
    "$LJA" \
    --labels Flye,hifiasm,LJA \
    --eukaryote \
    --est-ref-size 147200000 \
    --threads 8 \
    --output-dir "$OUTDIR/no_reference"


# ----------------------------
# QUAST with reference
# ----------------------------

apptainer exec "$QUAST" quast.py \
    "$FLYE" \
    "$HIFIASM" \
    "$LJA" \
    --labels Flye,hifiasm,LJA \
    --eukaryote \
    --threads 8 \
    -r "$REF" \
    --features "$ANNOT" \
    --output-dir "$OUTDIR/with_reference"
