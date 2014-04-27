Getting-and-Cleaning-Data-Project
=================================

Object: Prepare tidy dataset derived from a UCI project that can be used for later analysis.

Steps:

1. Read data from .txt files downloaded in working directory into data frame, assign friendly names to data frames.

2. Process data with merge and cbind functions into one whole data frame.

3. Substract desired columns with "mean()" and "std()" for the tidy data.

4. Take average on features by subject and activity respectfully.

5. Export the result data frame using write.table function

Note: Detailed decriptions are embedded into the run_analysis.R script.
