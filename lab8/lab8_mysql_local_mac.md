## MySQL Datatabase localhost

1. Step 1: Install Homebrew

​		`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

2. Step 2: Install MySQL Server

    `brew install mysql`
    
3. Step 3: Start MySQL Server

    `brew services start mysql`​		

4. Step 4: Verify MySQL Installation

    `mysql -u root`

5. Step 5: Create a New MySQL User

    ```sql
CREATE USER 'btech'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'btech'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
    ```

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
WHERE prot_id = 6;
```



- delete a record in table

```sql
DELETE FROM Proteins WHERE prot_id = 4;
```
