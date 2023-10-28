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



- connecting to Ensembl database US EAST db server

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





## MySQL Datatabase localhost

There are two options

1. you may install MySQL with brew by following the link below

​		https://gist.github.com/wpconsulate/40469bfdafad9fdd0afc3e260a5586a7

2. Also, you can download the official package from mysql.com

​		https://downloads.mysql.com/archives/community/

I am using an old Macbook (2013 model) so I had to use an older version MySQL server.

Select product version 5.7.12 download **Mac OS X 10.11 (x86, 64-bit), DMG Archive**



After you install your local mysql server, you can complete the rest of the lab



- Connect to local host

Open your Terminal, and type the following command

```sh
mysql -u root -p -h localhost
```

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
