# Genome and Transcriptome Assembly

Course repository for the **Genome and Transcriptome Assembly** course at the University of Bern.

The project analyses genomic and RNA-seq data from *Arabidopsis thaliana*, including read quality control, genome size estimation, genome and transcriptome assembly, and assembly evaluation.

## Data

### Genomic data

- Accession: **Dog-4**
- ENA accession: **ERR11437350**
- Sequencing technology: **PacBio HiFi**

### Transcriptomic data

- Accession: **Sha**
- ENA accession: **ERR754081**
- Sequencing technology: **Illumina paired-end RNA-seq**

Raw sequencing files are not included in this repository because of their size.

The genomic sequencing data used in this project originate from the following studies:

- Lian Q. et al. (2024). **A pan-genome of 69 *Arabidopsis thaliana* accessions reveals a conserved genome structure throughout the global species range.** *Nature Genetics*, 56, 982–991.
- Jiao W.B. & Schneeberger K. (2020). **Chromosome-level assemblies of multiple Arabidopsis genomes reveal hotspots of rearrangements with altered evolutionary dynamics.** *Nature Communications*, 11, 1–10.

## Workflow

1. Read quality control
   - FastQC
   - fastp

2. K-mer analysis
   - Jellyfish
   - GenomeScope

3. Genome assembly
   - Flye
   - hifiasm
   - LJA

4. Transcriptome assembly
   - Trinity

5. Assembly evaluation
   - BUSCO
   - QUAST
   - Merqury

6. Genome comparison
   - nucmer
   - MUMmerplot

## Repository structure

```text
.
├── read_QC/
├── scripts/
│   ├── 01_read_statistics.sh
│   ├── 02_fastp.sh
│   ├── 03_kmer_counting.sh
│   ├── 04_flye.sh
│   ├── 05_hifiasm.sh
│   ├── 06_lja.sh
│   ├── 07_trinity.sh
│   ├── 08_busco.sh
│   ├── 09_quast.sh
│   ├── 10_merqury.sh
│   └── 11_mummer.sh
└── README.md
```

## Running the analyses

The analyses were run on the University of Bern computing cluster using SLURM.

Scripts can be submitted using, for example:

```bash
sbatch scripts/08_busco.sh
sbatch scripts/09_quast.sh
sbatch scripts/10_merqury.sh
sbatch scripts/11_mummer.sh
```

## Main results

For the Dog-4 accession, all three genome assemblers produced highly complete assemblies.

| Assembler | BUSCO complete | Merqury QV | k-mer completeness |
| --------- | -------------- | ---------- | ------------------ |
| Flye      | 99.9%          | 67.44      | 99.39%             |
| hifiasm   | 99.4%          | 56.48      | 99.11%             |
| LJA       | 99.9%          | 55.26      | 99.48%             |

Flye showed the highest consensus accuracy according to Merqury, while LJA produced the most contiguous assembly.

The Trinity transcriptome assembly had **78.8% complete BUSCOs**.

## Notes

Large sequencing files, genome assemblies, intermediate files, and SLURM output files are excluded from version control.

## Author

Dominik Julien Kaufmann  
Master's student in Bioinformatics and Computational Biology  
University of Bern