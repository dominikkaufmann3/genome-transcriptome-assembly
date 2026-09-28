#!/usr/bin/env bash

#SBATCH --job-name=hifiasm
#SBATCH --partition=pibu_el8
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --mail-user=dominik.kaufmann3@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/dkaufmann3/output_hifiasm_%j.o
#SBATCH --error=/data/users/dkaufmann3/error_hifiasm_%j.e

WORKDIR=/data/users/dkaufmann3/assembly_annotation_course
OUTDIR=$WORKDIR/assemblies/hifiasm

mkdir -p "$OUTDIR"

apptainer exec /containers/apptainer/hifiasm_0.25.0.sif \
    hifiasm \
    -o "$OUTDIR/Dog-4" \
    -t 16 \
    "$WORKDIR/Dog-4/ERR11437350.fastq.gz" \
    2> "$OUTDIR/Dog-4.log"

# Convert primary contigs from GFA to FASTA
awk '/^S/{print ">"$2;print $3}' \
    "$OUTDIR/Dog-4.bp.p_ctg.gfa" \
    > "$OUTDIR/Dog-4.bp.p_ctg.fa"
