#!/bin/bash
#SBATCH --job-name=busco
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=8
#SBATCH --mem=24G
#SBATCH --time=08:00:00
#SBATCH --output=slurm-%j.out
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=dominik.kaufmann3@students.unibe.ch

set -euo pipefail

WORKDIR=/data/users/dkaufmann3/assembly_annotation_course
BUSCO=/containers/apptainer/busco_5.7.1.sif

mkdir -p "$WORKDIR/assembly_evaluation/busco"

# Flye
apptainer exec "$BUSCO" busco \
    -i "$WORKDIR/assemblies/flye/assembly.fasta" \
    -o flye_busco \
    --out_path "$WORKDIR/assembly_evaluation/busco" \
    -m genome \
    -l brassicales_odb10 \
    -c 8

# hifiasm
apptainer exec "$BUSCO" busco \
    -i "$WORKDIR/assemblies/hifiasm/Dog-4.bp.p_ctg.fa" \
    -o hifiasm_busco \
    --out_path "$WORKDIR/assembly_evaluation/busco" \
    -m genome \
    -l brassicales_odb10 \
    -c 8

# LJA
apptainer exec "$BUSCO" busco \
    -i "$WORKDIR/assemblies/lja/assembly.fasta" \
    -o lja_busco \
    --out_path "$WORKDIR/assembly_evaluation/busco" \
    -m genome \
    -l brassicales_odb10 \
    -c 8

# Trinity
apptainer exec "$BUSCO" busco \
    -i "$WORKDIR/assemblies/trinity.Trinity.fasta" \
    -o trinity_busco \
    --out_path "$WORKDIR/assembly_evaluation/busco" \
    -m transcriptome \
    -l brassicales_odb10 \
    -c 8