# Lab 8 Database Basics - MySQL

1. Create your lab directory

```sh
cd ~  # change to home directory
cd btech 
mkdir lab8
cd lab8
```

2. activate btech conda environment

```sh
conda activate btech
```

3. Install package with conda

```sh
conda install -y mysql
```



4. Database Queries against Ensembl Public Database

The Ensembl public MySQL Servers for large amounts of data and more detailed analysis. 

| Server                | User      | Password |   Port(s)   |     Version     | Notes                                                     |
| :-------------------- | :-------- | :------- | :---------: | :-------------: | :-------------------------------------------------------- |
| ensembldb.ensembl.org | anonymous | -        | 3306 & 5306 |  MySQL 5.6.33   | From Ensembl **48** onwards only                          |
| useastdb.ensembl.org  | anonymous | -        | 3306 & 5306 | MariaDB 10.0.30 | **Current** and **previous** Ensembl version only         |
| asiadb.ensembl.org    | anonymous | -        | 3306 & 5306 | MariaDB 10.0.30 | **Current** and **previous** Ensembl version only         |
| martdb.ensembl.org    | anonymous | -        |    5316     | MariaDB 10.0.30 | From Ensembl **48** onwards only                          |
| ensembldb.ensembl.org | anonymous | -        |    3337     |  MySQl 5.6.33   | Databases for **archive GRCh37** - **release 79 onwards** |



- connecting to Ensembl database US EAST db server

```sh
mysql -h useastdb.ensembl.org -u anonymous 
```

- Run SQL queries

List human databases

```sql
show databases like "homo%";
```

Connect to the human core database, or select the latest core database version. 

```sql
use homo_sapiens_core_115_38;
```

List all the tables

```sql
show tables;
```

Describe transcript table

```sql
desc transcript;
```

Describe gene table

```sql
desc gene;
```



Write a query:

```sql
SELECT * FROM gene LIMIT 1\G
```

​	The `\G` will display result vertically, `\G` also serves as a line terminator so you don't need to type ; line terminator

​	Limit 1 will only show the first line from gene table;



- Query to transcript information for Ensembl Canonical transcripts

```sql
SELECT ts.stable_id, ts.version, ts.seq_region_start, ts.seq_region_end, ts.seq_region_strand, sr.name
FROM gene g
INNER JOIN transcript ts ON g.gene_id = ts.gene_id
INNER JOIN seq_region sr ON ts.seq_region_id = sr.seq_region_id
INNER JOIN coord_system cs ON sr.coord_system_id = cs.coord_system_id
WHERE ts.transcript_id = g.canonical_transcript_id
LIMIT 5;
```



- Query to get transcript count by gene ID

```sql
SELECT g.stable_id, count(ts.transcript_id) transcript_count 
FROM gene g
INNER JOIN transcript ts ON g.gene_id = ts.gene_id
WHERE g.stable_id = 'ENSG00000168036';
```