# Lab 5 Install Jupyter Notebook

1. Create your lab directory

```sh
cd ~  # change to home directory
mkdir btech # create btech directory if you don't have one
cd btech 
mkdir lab5
cd lab5

curl -s https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/refs/heads/main/lab5/lab5_jupyter_notebook.ipynb -o lab5_jupyter_notebook.ipynb
```

2. activate btech conda environment

```sh
conda activate btech
```

3. install dependency packages

```sh
conda install jupyterlab pandas seaborn scipy numpy -y 
```



4. Launch Jupyter Notebook session

```sh
jupyter lab
```

Now let's work on the second part of the lab in a Jupyter Notebook. Please Download the Jupyter notebook to your lab5 folder and open it within Jupyter lab.