# Programming Exercise using Python / Bash

## Background

This is a dataset of **Government of India** collected by TRAI using MySpeed App. The data set is sampled from 1.3 Million devices on which Network speeds were measured by MySpeed App of TRAI. The samples are taken from all the states of India, from various Service providers.

The columns are as follows:
-   Service Provider
-   Technology
-   Test_type
-   Data Speed(Mbps)
-   Signal_strength
-   LSA

The dataset contains roughly equal number of Download and Upload tests, collected over march 2018 from various states of India and comprising of various Service Providers. Apart from data speeds for 4G and 3G network, the data also consists of Signal Strength while the Speeds were measured.

## Things to be aware:

- Use Python **3.7**  
- Avoid using notebooks, like **Jupyter** for instance. 

# Files

For the following tests you will have only one file named **march18_myspeed.csv**

## Exercise 1 (Python)

1. By writing a bash script, open the given file and  **only** extract the following columns:
- Service Provider
- Technology 
- Test_type
- Data Speed (Mbps)

2. Only extract data related to Test_type =  **Download**
3. Rename the column 'Test_type' to 'Test Type'
4. New field delimiter should be a a pipe **'|'**
5. Write the output into a new file called **myspeed_download_python.bcp**. It should look like the following:

    Service Provider|Technology|Test Type|Data Speed(Mbps)
    VODAFONE|4G|Download|7.73
    VODAFONE|4G|Download|6.92
    VODAFONE|4G|Download|7.69
    VODAFONE|4G|Download|13.33
    VODAFONE|4G|Download|8.58
    ....
    ....

6. Script should receive 2 arguments, the path of the input file and the path of the new output file
7. The project should be stored in GitHub and you should only commit relevant files to the repo.

**Bonus**  Add logging to the script
**Bonus** Document the code as much as possible
**Bonus** Add a **README** file explaining on a high level what the script is doing
**Bonus** Can you work out the count of of tests per Technology to produce this output (separate file)

|Count |Technology|
|------|-------|
|593521|4G|
|67994|3G|

**Bonus** Calculate the mean download speed for each Service Provider. Which Service Provider provides the best mean download speed?



## Exercise 2 (Bash)

Repeat the first exercise but this time doing it using Bash.

For step 5, name the file as  **myspeed_download_bash.bcp** and keep the same exact formatting.