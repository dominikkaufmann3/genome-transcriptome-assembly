#!/bin/bash
#SBATCH --job-name=mummer
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=04:00:00
#SBATCH --output=slurm-%j.out
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=dominik.kaufmann3@students.unibe.ch

set -euo pipefail

WORKDIR=/data/users/dkaufmann3/assembly_annotation_course
IMAGE=/containers/apptainer/mummer4_gnuplot.sif

REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa

FLYE="$WORKDIR/assemblies/flye/assembly.fasta"
HIFIASM="$WORKDIR/assemblies/hifiasm/Dog-4.bp.p_ctg.fa"
LJA="$WORKDIR/assemblies/lja/assembly.fasta"

OUTDIR="$WORKDIR/genome_comparison/mummer"
mkdir -p "$OUTDIR"

run_comparison () {

    REF_FASTA=$1
    QUERY_FASTA=$2
    NAME=$3

    mkdir -p "$OUTDIR/$NAME"
    cd "$OUTDIR/$NAME"

    # Align genomes
    apptainer exec "$IMAGE" nucmer \
        --threads "$SLURM_CPUS_PER_TASK" \
        --prefix="$NAME" \
        --breaklen 1000 \
        --mincluster 1000 \
        "$REF_FASTA" \
        "$QUERY_FASTA"

    # Make dotplot
    apptainer exec "$IMAGE" mummerplot \
        -R "$REF_FASTA" \
        -Q "$QUERY_FASTA" \
        --filter \
        -t png \
        --large \
        --layout \
        --fat \
        --prefix "$NAME" \
        "$NAME.delta"
}


# Assemblies vs TAIR10
run_comparison "$REF" "$FLYE" ref_vs_flye
run_comparison "$REF" "$HIFIASM" ref_vs_hifiasm
run_comparison "$REF" "$LJA" ref_vs_lja

# Assemblies vs each other
run_comparison "$FLYE" "$HIFIASM" flye_vs_hifiasm
run_comparison "$FLYE" "$LJA" flye_vs_lja
run_comparison "$HIFIASM" "$LJA" hifiasm_vs_lja