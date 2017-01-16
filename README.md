# coursera-getting-and-cleaning-data
This is the project assignment for Coursera's "Getting and Cleaning Data Course".

# Project Files:

- run_analysis.R:
  This script collects and tidies the source data from the "Human Activity Recognition Using Smartphones Data Set" 
  collected at UC Irvine (UCI HAR).
  
  The run() function executes the script.
  
- tidy_data.txt:
  This is the tidy dataset produced by run_analysis.R.
  
- codebook.md
  This code book identifies the variables in the tidy_data.txt file.
  
- sourcedata:
  The run_analysis script expects the UCI HAR files to be in the "sourcedata" folder.  For convenience, this folder is included in the repository.
 
# About the project:

The goal of the project is to create a tidy dataset from the source data using Hadley Wickam's paper "Tidy Data" (https://www.jstatsoft.org/article/view/v059i10).

Note that a few of Wickam's suggestions were not followed for this project:
1) Some column headers contain values.
   Most of the measurement columns names end in "X", "Y", or "Z" to indicate the dimension being measured.  Since there may be cases
   where it is useful to analyze data by dimension, it is possible to split the dimension factors from the measurements.  However,
   in this project, the analysis simply aggregated the measurements by subject and activity, so splitting out the dimensions is
   not useful here.  Make the dataset as tidy as possible -- but no tidier!
2) Variables are mixed-case.
   Wickam recommends lower-case names.  However, because the names of the measurements are fairly long, "tBodyAccelerometerMagnitudeMean" for example,
   the names were left in mixed case for ease of reading the names.
