# SQL Exercise

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

# Files

For the following test you will have only one file named **march18_myspeed.csv**

## Exercise

1. By using a  relational database  **of your choice** load the csv file in a table called **india_telecom_data_speeds**. Describe the steps taken to load this data inside your database and attach an image of the table created. It should be similar to the below:

|Service_Provider|Technology|Test_Type|Data_Speed|Signal_Strength|LSA           |
|----------------|----------|---------|----------|---------------|--------------|
|JIO             |4G        |Upload   |7.3       |-63            |Andhra Pradesh|
|JIO             |4G        |Upload   |7.31      |-65            |Andhra Pradesh|
|JIO             |4G        |Upload   |6.91      |-65            |Andhra Pradesh|
|VODAFONE        |4G        |Download |7.73      |-90            |Maharashtra   |
|VODAFONE        |4G        |Download |6.92      |-90            |Maharashtra   |


2. Out of the 1.3 million sample data set, how many had Technology **3G** vs **4G**?  
3. Calculate the **mean** download speed for **each** Service Provider. 
4. Which Service Provider provides the best mean download speed? Is there any correlation between speed and technology? Why?
5.  Calculate the **mean** upload speed for **each** Service Provider. Which Service Provider provides the best mean upload speed?
6. For **each** LSA , print out the Service Provider that had to **worse** Signal_Strength (the worse signal strength is the value which is the greatest in the negative). Output should have 23 rows (one for each LSA) and 3 columns as follows:

	- LSA
	- Service_Provider
	- Signal_Strength

**Note** Please provide the queries used to get the results for the above questions.

7. The project should be stored in GitHub and you should only commit relevant files to the repo.