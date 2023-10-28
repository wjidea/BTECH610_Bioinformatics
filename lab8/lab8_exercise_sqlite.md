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

`jq` is a command-line JSON processor. 

```sh
conda install -c mysql
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



- connecting to Ensembl data us east db

```sh
mysql -h useastdb.ensembl.org -u anonymous 
```

- Run SQL queries

List human databases

```sql
show databases like "homo%";
```

Connect to the human core database

```sql
use homo_sapiens_core_110_38;
```

List all the tables

```sql
show tables;
```

Describe transcript table

```sql
desc transcript;
```



Write a query:

```sql
SELECT * FROM gene LIMIT 1\G
```

The `\G` will display result vertically.

Limit 1 will only show the first line from gene table;



another query

```sql
SELECT ts.stable_id, ts.version, ts.seq_region_start, ts.seq_region_end, ts.seq_region_strand, sr.name
FROM gene g
INNER JOIN transcript ts ON g.gene_id = ts.gene_id
INNER JOIN seq_region sr ON ts.seq_region_id = sr.seq_region_id
INNER JOIN coord_system cs ON sr.coord_system_id = cs.coord_system_id
WHERE ts.transcript_id = g.canonical_transcript_id
LIMIT 5;
```













## Option A: MySQL Datatabase localhost

If you successfully install the MySQL installed on your laptop, you can go with this path. 

https://gist.github.com/wpconsulate/40469bfdafad9fdd0afc3e260a5586a7

I am using an old mac, so my mac install path may look quite different from most of you. 

root@localhost: MldFfeoNy1&(

https://downloads.mysql.com/archives/community/

select product version 5.7.12

download **Mac OS X 10.11 (x86, 64-bit), DMG Archive**

- create database

```mysql
create database btech;
```



- connect database

```sql
use btech;
```



- Create tables

```sql
CREATE TABLE Genes (
	gene_id int unsigned NOT NULL AUTO_INCREMENT,
  name varchar(255) DEFAULT NULL,
	chrom varchar(255),
	coord_start int unsigned,
	coord_end int unsigned,
  PRIMARY KEY (gene_id)
);

CREATE TABLE Transcripts (
	trans_id int unsigned NOT NULL AUTO_INCREMENT,
  gene_id int unsigned NOT NULL,
  length int unsigned,
  PRIMARY KEY (trans_id),
  FOREIGN KEY (gene_id) REFERENCES Genes(gene_id)
);

CREATE TABLE Exons (
  exon_id int unsigned NOT NULL AUTO_INCREMENT,
  trans_id int unsigned NOT NULL,
  length int unsigned,
  PRIMARY KEY (exon_id),
  FOREIGN KEY (trans_id) REFERENCES Transcripts(trans_id)
);

CREATE TABLE Proteins (
  prot_id int unsigned NOT NULL AUTO_INCREMENT,
  trans_id int unsigned NOT NULL,
  name varchar(255) DEFAULT null,
  length int unsigned,
  PRIMARY KEY (prot_id),
  FOREIGN KEY (trans_id) REFERENCES Transcripts(trans_id)
);
```



- Insert data into tables

```sql
-- insert data to Genes table
INSERT INTO Genes (name, chrom, coord_start, coord_end) 
VALUES ('geneA', 'chr1', 1, 100), 
('geneB', 'chr1', 120, 300), 
('geneC', 'chr2', 300, 400);

-- insert data into Transcript table
INSERT INTO Transcripts (gene_id, length) 
VALUES (1, 85), (1, 70), (2, 100), (2, 110), (3, 50), (3, 60);

-- insert data into Exons table
INSERT INTO Exons (trans_id, length) 
VALUES (1, 85), (1, 70), (2, 100), (2, 110), (3, 50), (3, 60);

-- insert data into Proteins table
INSERT INTO Proteins (trans_id, length) 
VALUES (1, 10), (1, 12), (2, 15), (2, 20), (3, 13), (3, 190);
```



- query data from one table

```sql
select * from Genes;
```



- query data from multiple tables

```sq
select * from Genes
inner join Transcripts;
```



- query data with conditions

```sql
select * from Genes
where gene_id=3;
```



- query data with joined table

```sql
select * from Genes
inner join Transcripts
where gene_id=3;
```

what do you notice about this query? How to fix the error?



- update a record in table

```sql
UPDATE Proteins
SET length = 15
WHERE protein_id = 6;
```



- delete a record in table

```sql
DELETE FROM Proteins WHERE protein_id = 4;
```





## Option B: SQLite Database 

If you do not have your MySQL local server install, you can choose this option to use SQLite database instead. For most of the basic queries, they are very comparable between MySQL and SQLite. 

1. install SQLite with conda

```sh
conda install sqlite
```



2. connect to sqlite database file

```sh
```



3. 





