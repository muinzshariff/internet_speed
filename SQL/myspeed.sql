/* Author: Muinulla Shariff
	email: muinzshariff@gmail.com */
/* Selected DB : Postgres, 
   The below DDL will getcreated in default postgres db and in public schema */

/*drop table if exists*/
drop table if exists internet_speed_stg;
/* Creating a table for internet_speed*/
create table internet_speed_stg(
syspk serial,
service_provider varchar(20),
technology varchar(2),
test_type varchar(20),
data_speed_Mbps float,
signal_strength varchar(10),
lsa varchar(30)
);

/*Loading CSV into table */
\COPY internet_speed_stg(
  service_provider, technology, test_type, 
  data_speed_Mbps, signal_strength, 
  lsa
) 
FROM 
  'C:\Users\muinz\Downloads\go-interviews\go-interviews\march18_myspeed.csv' DELIMITER ',' CSV HEADER;


Select * from internet_speed_stg;

  syspk  | service_provider | technology | test_type | data_speed_mbps | signal_strength |       lsa
---------+------------------+------------+-----------+-----------------+-----------------+------------------
       1 | JIO              | 4G         | Upload    |             7.3 | -63             | Andhra Pradesh
       2 | JIO              | 4G         | Upload    |            7.31 | -65             | Andhra Pradesh
       3 | JIO              | 4G         | Upload    |            6.91 | -65             | Andhra Pradesh
       4 | VODAFONE         | 4G         | Download  |            7.73 | -90             | Maharashtra
       5 | VODAFONE         | 4G         | Download  |            6.92 | -90             | Maharashtra
       6 | VODAFONE         | 4G         | Download  |            7.69 | -87             | Maharashtra
       7 | VODAFONE         | 4G         | Download  |           13.33 | -88             | Maharashtra
       8 | VODAFONE         | 4G         | Download  |            8.58 | -80             | Maharashtra


/*2. Out of the 1.3 million sample data set, how many had Technology **3G** vs **4G**? */
select technology,count(*) from internet_speed_stg group by technology;

 technology |  count
------------+---------
 3G         |  136888
 4G         | 1186084
(2 rows) 
 
 /*Calculate the **mean** download speed for **each** Service Provider. */
 
SELECT service_provider,
       Avg(data_speed_mbps) AS mean
FROM   internet_speed_stg
WHERE  test_type = 'Download'
GROUP  BY service_provider;


 service_provider |        mean
------------------+--------------------
 AIRCEL           |  2.658333333333333
 AIRTEL           |  7.484995790723127
 CELLONE          | 2.0092185116121395
 DOLPHIN          | 1.6633333333333333
 IDEA             |  5.725223975345971
 JIO              | 17.949658776807716
 UNINOR           |  6.799024390243902
 VODAFONE         | 6.1024315027053095
(8 rows) 

/*4. Which Service Provider provides the best mean download speed? Is there any correlation between speed and technology? Why?*/

SELECT service_provider,
       technology,
       Avg(data_speed_mbps) AS mean_download_speed
FROM   internet_speed_stg
WHERE  test_type = 'Download'
GROUP  BY service_provider,
          technology
ORDER  BY service_provider,
          mean_download_speed DESC; 

 service_provider | technology | mean_download_speed
------------------+------------+--------------------
 AIRCEL           | 3G         |  2.658333333333333
 AIRTEL           | 4G         |  8.752884547800182
 AIRTEL           | 3G         |  2.249968147230583
 CELLONE          | 4G         |  4.368823529411764
 CELLONE          | 3G         | 2.0023988439306386
 DOLPHIN          | 3G         | 1.6633333333333333
 IDEA             | 4G         |   6.79393005739969
 IDEA             | 3G         | 2.3391970170796235
 JIO              | 4G         | 17.949658776807787
 UNINOR           | 4G         |  6.799024390243902
 VODAFONE         | 4G         |  7.344790058453433
 VODAFONE         | 3G         | 1.8278483150379994
(12 rows)

--Jio provides the better download speed, yes there is a correlation between speed and technology, 4G gives you best download speed, 3G is less

/*5.  Calculate the **mean** upload speed for **each** Service Provider. Which Service Provider provides the best mean upload speed?*/

SELECT service_provider,
       technology,
       Avg(data_speed_mbps) AS mean_upload_speed
FROM   internet_speed_stg
WHERE  test_type = 'Upload'
GROUP  BY service_provider,
          technology
ORDER  BY mean_upload_speed DESC;


 service_provider | technology | mean_upload_speed
------------------+------------+--------------------
 IDEA             | 4G         |  7.002556478202461
 CELLONE          | 4G         |  5.790588235294117
 VODAFONE         | 4G         |  5.071127954032238
 JIO              | 4G         |  4.018704229737775
 UNINOR           | 4G         | 3.8826829268292684
 AIRTEL           | 4G         |  3.788641600082646
 VODAFONE         | 3G         | 1.5162869326835242
 IDEA             | 3G         | 1.4788836239575485
 AIRCEL           | 3G         | 1.1843333333333335
 AIRTEL           | 3G         | 1.0803881095756984
 CELLONE          | 3G         | 1.0564038069340573
 DOLPHIN          | 3G         |              0.918
(12 rows)

--IDEA with 4g technology gives a better upload speed 

/*6. For **each** LSA , print out the Service Provider that had to **worse** Signal_Strength 
(the worse signal strength is the value which is the greatest in the negative). Output should have 23 rows (one for each LSA) and 3 columns as follows:
	- LSA
	- Service_Provider
	- Signal_Strength */
	

SELECT lsa,
       service_provider,
       signal_strength AS worst_signal_strength
FROM   (SELECT *,
               Row_number()
                 over (
                   PARTITION BY lsa) AS r_no
        FROM   (SELECT lsa,
                       service_provider,
                       Avg(CASE
                             WHEN signal_strength = 'na' THEN '0' :: INT
                             ELSE signal_strength :: INT
                           END) AS signal_strength
                FROM   internet_speed_stg
                GROUP  BY lsa,
                          service_provider
                ORDER  BY lsa ASC,
                          signal_strength ASC) a) b
WHERE  r_no = 1;  

       lsa        | service_provider | worst_signal_strength
------------------+------------------+-----------------------
 Andhra Pradesh   | AIRTEL           |  -83.5010483870967742
 Assam            | IDEA             |  -93.5753424657534247
 Bihar            | JIO              |  -86.5209774299235530
 Chennai          | AIRCEL           |  -91.0000000000000000
 Delhi            | AIRTEL           |  -85.8070937752627324
 Gujarat          | VODAFONE         |  -85.7116893435296454
 Haryana          | AIRTEL           |  -84.8362774666092202
 Himachal Pradesh | AIRTEL           |  -83.7670250896057348
 Jammu & Kashmir  | JIO              |  -88.0337093389296957
 Karnataka        | IDEA             |  -85.9546500164311535
 Kerala           | AIRTEL           |  -87.6748196926936344
 Kolkata          | JIO              |  -91.3625449619283412
 Madhya Pradesh   | AIRTEL           |  -84.4809692409825183
 Maharashtra      | CELLONE          |  -88.6000000000000000
 Mumbai           | DOLPHIN          |  -89.5333333333333333
 North East       | JIO              |  -86.8845449649973075
 Orissa           | AIRTEL           |  -86.0025721315142026
 Punjab           | IDEA             |  -87.6828593996840442
 Rajasthan        | CELLONE          |  -89.0000000000000000
 Tamil Nadu       | AIRCEL           |  -86.0000000000000000
 UP East          | VODAFONE         |  -84.8935857918684867
 UP West          | UNINOR           |  -92.9687500000000000
 West Bengal      | VODAFONE         |  -89.2704153715738909
(23 rows)

--Note: We can also update 'na' value in signal_strength column to null and then use coalesce function to replace it with 0