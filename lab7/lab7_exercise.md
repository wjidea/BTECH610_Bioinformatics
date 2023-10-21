# Lab 7 Biological Databases

1. Create your lab directory

```sh
cd ~  # change to home directory
mkdir btech # create btech directory if you don't have one
cd btech 
mkdir lab7
cd lab7
```

2. activate btech conda environment

```sh
conda activate btech
```

3. Install package with conda

`jq` is a command-line JSON processor. 

```sh
conda install -c conda-forge jq
conda install -c conda-forge ncbi-datasets-cli
```



4. Database API access - Ensembl API 

Use curl to acquire gene information

Find the species and database for a single identifier e.g. gene, transcript, protein

```sh
curl -s 'https://rest.ensembl.org/lookup/id/ENSG00000157764?expand=1' \
-H 'Content-type:application/json' | \
jq -r '[.seq_region_name, .start, .end] | @tsv'
```



Query with multiple gene IDs

```sh
curl -s 'https://rest.ensembl.org/lookup/id' \
-H 'Content-type:application/json' \
-H 'Accept:application/json' \
-X POST \
-d '{ "ids" : ["ENSG00000157764", "ENSG00000171862" ] }' | \
jq '.[] | .display_name'
```



For a full list of Ensembl REST API Endpoints: https://rest.ensembl.org/



5. Use command line tool ncbi dataset to download human transcriptome

```sh
datasets download gene gene-id 1 2 3 9 10 11 12 13 14 15 16 17 --filename gene_list_1.zip
datasets download gene symbol ACRV1 A2M --taxon human --filename ACRV1_A2M.zip
datasets download gene accession NM_020107.5 NP_001334352.2 --filename gene_list_3.zip
datasets download gene gene-id 672 --include gene,protein --filename gene_list_4.zip
datasets download gene gene-id 672 --include gene,rna,cds,protein --filename gene_list_5.zip
datasets download gene gene-id 672 --include none --filename gene_list_6.zip
```



6. Use Ensembl Biomart Web App

- Navigate to https://useast.ensembl.org/biomart/martview
- Choose `Ensembl Genes 110` (or the latest release)
- Choose dataset: `Human genes (GRCh38.p14)`
- Click `Filters` link (left column) to select filters
  - select REGION
    - check `Chromosome/scaffold`
    - select/highlight chromosome `22`

  - select GENE
    - check `Gene type`
    - select/highlight `protein_coding`
- Click `Attributes` to select features to be included in the final output
  - Check Features radio button
  - Expand `GENE`
  - select 
    - Gene stable ID
    - Gene stable ID version
    - Transcript stable ID
    - Transcript stable ID version
    - Gene % GC content
    - Transcript count
    - Transcript length (including UTRs and CDS)
- Click top left corner Count to see how many genes selected
- Click top left Results button to export results
  - click Go button to download the results


Now, check your downloaded tsv file, how many lines in this file? and why?
