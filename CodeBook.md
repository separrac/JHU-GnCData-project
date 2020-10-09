---
title: "Code Book"
subtitle: "Documentation for Getting and Cleaning Data course final project"
author: "Sebastian Parra"
date: "09-10-2020"

---

# Raw Data

We are using the *Human Activity Recognition Using Smartphones Data Set* from *UCI Machine Learning Repository*. For more information see the [Web site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

There are 3 original data sets, which were randomly partitioned into 70%-30% subsets for train and test, respectively.

* **subject** file : Contains de identification number for each volunteer for the experiment  
* **y** file : Contains the identifier for the activities performed in the experiment (*WALKING*, *WALKING_UPSTAIRS*, *WALKING_DOWNSTAIRS*, *SITTING*, *STANDING*, *LAYING*)  
* **x** file : Contains all the variables with information from gyroscope and accelerometer registered from Samsung Galaxy S II smartphone and summary information like average, maximum, minimum, etc.

There are also 4 files with information about these variables.

* **activity_labels.txt** : Dictionary of 2 columns. First is the activity id, and second is the name of the activity.  
* **features.txt** : Every name of the variables contained in the x files.  
* **features_info.txt** : Explanation of nomenclature of variables.  
* **README.txt** : General information of the data.

# Script

The run_analysis.R script contains the code that will extract the raw data and transform it to tidy data set.

This script has 5 main parts with the name of the processes for the transformation. It's inputs are all raw data sets obtained from [zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

# Processes:

* Getting information  

Before the transformation process we have to download the data from a zip file to a folder called *Data*

 1. Merges the training and the test sets to create one data set. 

First step is creating tables from every data set contained in the *Data* folder, including the activity dictionary and the data with the name of the features.

Next we merge them with *cbind* and *rbind* functions knowing that all tables are in the same subject/activity order.

After the merge, we assign this new *data.frame* to **df**, which has 10299 observations and 563 variables. They are sorted by **30** subjects and their 6 types of activities.

Finally, tables that were already merged are removed.

 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

we select the features containing *"mean()"* or *"std()"*, creating a new shorter data.frame of only 68 variables.

 3. Uses descriptive activity names to name the activities in the data set.  

Originally, the **y** data set (of 1 column) had the activities by it's id number. So we update the **df_tidy** data.frame so the activity column contains the real name from activities from the **activity_labels.txt** data.frame (dictionary).

 4. Appropriately labels the data set with descriptive variable names.  

The data.frame's features are renamed so they can be understandable by the [](# TidyFeatures) terminology.

 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

We create a second data.frame with the average summaries grouped by **subject** and **activity**. This will be the output table, which will be exported to **SummarizedTidyDataSet.txt**.

# TidyFeatures

Feature names are updated to tidy by including more information about their contents. The source from which this information is obtained is the **feature_info.txt** file contained in the **Data** folder.

* features starting with *f* are updated to *Frecuency*  
* features starting with *t* are updated to *Time*  
* *Acc*, *Gyro* and *Mag* are updated to *Acceleration*, *Gyroscope* and *Magnitude*, respectively.


