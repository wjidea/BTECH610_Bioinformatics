# Lab 1 Introduction to Linux

1. Setup Shell terminal on your laptop
   - If you are using a window laptop, you will need to install wsl ubuntu
   - If you are using a Mac, you can use the Terminal from your system
   - If you are using a Linux (e.g., Ubuntu), you can use the Terminal from your system




2. Create your lab 1 directory

```sh
cd ~  # change directory
mkdir jwang  # make a new directory, remember to change to your name
cd jwang 
mkdir lab1
cd lab1

pwd  # present working directory

touch file1.txt  # create an empty file 
echo "ABC" > file2.txt  # create a file with ABC cc
echo "ABC\nEFG" > file3.txt

ls
```

3. View file contents

```sh
cat file3.txt  # check what you are seeing here
head -1 file3.txt
tail -1 file3.txt

# less is more
more file3.txt
less file3.txt

# let check some big files
head -10 /usr/share/dict/words
tail -10 /usr/share/dict/words
```

4. Renaming, Copying and Deleting Files and Directories

```sh
touch file4.txt
mkdir test
rmdir test
rm file1.txt
cp file2.txt file2_cp.txt
mkdir test
mv file2.txt test/
mv file2_cp.txt file2_1.txt

```

5. Counting, Sorting and Redirecting Output

```sh
curl https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/main/lab1/words -o words

wc words

wc -l words

seq 1 100 | shuf > random_number.txt 
cat random_number.txt | sort | uniq
```



6. Downloading and Transferring Data

```sh
# download sonnet 18
wget https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/main/lab1/sonnet_18.txt

# if wget not working
curl https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/main/lab1/sonnet_18.txt -o sonnet_18.txt
```



7. Find and Replace

```sh
# search thee used in sonnet 18
grep thee sonnet_18.txt
cat sonnet_18.txt | sed 's/thee/you/'

# wild card *
ls *.txt

# wild card ?
ls file?.txt
```



8. get help or check the manual

```sh
man sed
```

