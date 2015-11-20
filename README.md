# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course. The R script, `run_analysis.R`, does the following:

1. It imports the necessary library for tidy data
2. Downloads and unzips data files if it doesn't exist already
3. Loads activity labels and features, converts them to characters
4. Extracts only the mean and standard deviation for each measurement
5. Merges train and test datasets
6. Adds labels
7. Converts activities to descriptive names
8. Convert activity and subjects into factors
9. Create tidy data using melt and dcast functions
10. Export out a `UCI_tidy.txt` file
