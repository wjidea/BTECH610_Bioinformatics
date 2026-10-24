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
`ncbi-datasets-cli` is a command line tool for accessing NCBI data resources

```sh
conda install -c conda-forge -y jq ncbi-datasets-cli
```


4. Database API access - Ensembl API 

Use curl to acquire gene information

Find the species and database for a single identifier e.g. gene, transcript, protein

First let's take a look what's in this API endpoint return

Get the Genome ID
```sh
BASE=https://www.ensembl.org/api
GENOME=$(curl -s "$BASE/metadata/genomeid?assembly_accession_id=GCA_000001405.29" | jq -r '.genome_uuid')
echo "$GENOME"
```

First look what gene api returns
```sh
curl -s "$BASE/graphql/core" -H 'Content-Type: application/json' -d @- <<EOF | jq
{"query": "{ gene(by_id: {genome_id: \"$GENOME\", stable_id: \"ENSG00000157764\"}) { stable_id symbol name slice { region { name } location { start end } strand { code } } transcripts { stable_id } } }"}
EOF
```
  
Then, we can extract the parts we are interested.   
```sh
curl -s "$BASE/graphql/core" -H 'Content-Type: application/json' -d @- <<EOF \
  | jq -r '.data.gene | [.slice.region.name, .slice.location.start, .slice.location.end] | @tsv'
{"query": "{ gene(by_id: {genome_id: \"$GENOME\", stable_id: \"ENSG00000157764\"}) { slice { region { name } location { start end } } } }"}
EOF
```

Query with multiple gene IDs with a bulk query

```sh
curl -s "$BASE/graphql/core" -H 'Content-Type: application/json' -d @- <<EOF \
  | jq -r '.data[] | [.stable_id, .symbol] | @tsv'
{"query": "{ a: gene(by_id: {genome_id: \"$GENOME\", stable_id: \"ENSG00000157764\"}) { stable_id symbol } b: gene(by_id: {genome_id: \"$GENOME\", stable_id: \"ENSG00000171862\"}) { stable_id symbol } }"}
EOF
```


For a full list of GraphQL API Endpoints: [https://rest.ensembl.org/](https://www.ensembl.org/data/graphql)



5. Use command line tool ncbi dataset to download human transcriptome

```sh
datasets download gene gene-id 1 2 3 9 10 11 12 13 14 15 16 17 --filename gene_list_1.zip
datasets download gene symbol ACRV1 A2M --taxon human --filename ACRV1_A2M.zip
datasets download gene accession NM_020107.5 NP_001334352.2 --filename gene_list_3.zip
datasets download gene gene-id 672 --include gene,protein --filename gene_list_4.zip
datasets download gene gene-id 672 --include gene,rna,cds,protein --filename gene_list_5.zip
datasets download gene gene-id 672 --include none --filename gene_list_6.zip
```
Next, please find a `command` to decompress those zip files we just downloaded. 



6. Use Ensembl Biomart Web App

- Navigate to https://useast.ensembl.org/biomart/martview
- Choose `Ensembl Genes 115` (or the latest release)
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
    - Gene type
    - Transcript count
    - Transcript length (including UTRs and CDS)
- Click top left corner Count to see how many genes selected
- Click top left Results button to export results
  - click Go button to download the results


Now, check your downloaded tsv file, how many lines in this file? and why?
