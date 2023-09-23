# Lab 3 Introduction to Python

1. Create your lab directory

```sh
cd ~  # change to home directory
mkdir btech # create btech directory if you don't have one
cd btech 
mkdir lab3
cd lab3
```



2. Let's start a Terminal session first

Let's start your conda environment

```sh
conda activate btech
python -V
```

If you install the conda environment with python=3.10, you should see the following message

```sh
Python 3.10.13
```

Then, we can start an interactive python

```sh
python
```

The python session will look at this:

```python 
Python 3.10.13 (main, Sep 11 2023, 08:39:02) [Clang 14.0.6 ] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>>
```



​		**Please don't copy the python prompt `>>>` **



3. Let's answer the questions from the lecture 

   1. Determine what 2146 divided by 13 is. Show with floating point and round two digits after decimal

   ```python
   >>> round(2146 / 13, 2)
   ```

   2. assign a string to a variable, determine how long the string is, print out the first 2 letters of the string

   ```python
   >>> var = "hello"
   >>> len(var)
   >>> print(var[:2])
   ```

   3. create a list from the string "a-b-cc-de-fgh" where the '-' separate the words. print out the length of list.

   ```python
   >>> var = "a-b-cc-de-fgh"
   >>> var_list = var.split('-')
   >>> print(len(var_list))
   ```

   4. Make a list mixed with words and numbers, sort it. How does it behave?

   ```python
   >>> my_list = ["he", "she", "Apple", 12, 2003]
   >>> my_list.sort()
   ```

   What happened after your enter the sort function?

   5. Calculate the mean of a list of numbers (4, 8, 15, 16, 23, 42)

   ```python
   >>> num_list = [4, 8, 15, 16, 23, 42]
   >>> sum_val = 0
   >>> for n in num_list:
   ...     sum_val += n
   ...
   >>> print(sum_val/len(num_list))
   ```

   Can you think of a different way to calculate the mean?

   ```python
   >>> num_list = [4, 8, 15, 16, 23, 42]
   >>> 
   ```

   

4. To quit interactive python

```python 
>>> exit()
```



5. Bonus, if we have some extra time, let work on the FizzBuzz code challenge.

Here is the rule:

**FizzBuzz**

Write a program that prints the numbers from 1 to 100. But for multiples of three print "Fizz" instead of the number and for the multiples of five print "Buzz". For numbers which are multiples of both three and five print "FizzBuzz".

Example output:

```sh
1
2
Fizz
4 
Buzz
Fizz
7
8
Fizz
Buzz
11
Fizz
13
14
FizzBuzz
16
17
Fizz
19
Buzz
... etc up to 100
```

Your code here

```python
# Hint this requires both loop and contional controls
```

