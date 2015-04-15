# 607-week10-assignment.R
# [For your convenience], here is provided code based in Jared Lander's R for Everyone, 

install.packages("XML")
library(XML)
theURL <- "http://www.jaredlander.com/2012/02/another-kind-of-super-bowl-pool/"
bowlPool <- readHTMLTable(theURL, which = 1, header = FALSE, stringsAsFactors = FALSE)
bowlPool

# 1. What type of data structure is bowlpool? 
str(bowlPool)
# bowlPool is a data frame with 10 observations of three variables, all of type chr

# 2. Suppose instead you call readHTMLTable() with just the URL argument,
# against the provided URL, as shown below

theURL <- "http://www.w3schools.com/html/html_tables.asp"
hvalues <- readHTMLTable(theURL)

# What is the type of variable returned in hvalues?

str(hvalues)

# hvalues is a list with 2 tables, containing 4 and 2 variables, all of type factor. 

# 3. Write R code that shows how many HTML tables are represented in hvalues

tableCount <- sapply(hvalues, class)
sum(tableCount == "data.frame")

# 4. Modify the readHTMLTable code so that just the table with Number, 
# FirstName, LastName, # and Points is returned into a dataframe

table <- readHTMLTable(theURL, which = 1, header = TRUE, stringsAsFactors = FALSE)

# 5. Modify the returned data frame so only the Last Name and Points columns are shown.

table[3:4]

# 6 Identify another interesting page on the web with HTML table values.  
# This may be somewhat tricky, because while
# HTML tables are great for web-page scrapers, many HTML designers now prefer 
# creating tables using other methods (such as <div> tags or .png files).  

#I'd like to look at the schedule for the listener-supported radio station WFMU

WFMU <- "http://www.wfmu.org/table"
schedule <-readHTMLTable(WFMU, header = TRUE, stringsAsFactors = FALSE)

# 7 How many HTML tables does that page contain?

tableCount <- sapply(schedule, class)
sum(tableCount == "data.frame")
#1

# 8 Identify your web browser, and describe (in one or two sentences) 
# how you view HTML page source in your web browser.

# In Chrome -> go to "More Tools" then "Developer Tools". Navigate to the "Elements" tab

# 9 (Optional challenge exercise)
# Instead of using readHTMLTable from the XML package, use the functionality in the rvest package to perform the same task.  
# Which method do you prefer?  Why might one prefer one package over the other?

library(rvest)

page <-html(WFMU)

schedule <- page %>%
  html_nodes(css="body > table")%>%
  html_table(fill=TRUE, header = TRUE)

# I prefer the XML package as the readHTMLTable function directly selected the table and ignored the caption. 
# I'm having an issue where I can direct rvest to the right node but can't get it to ignore the caption and recognize the header.
# However, rvest appears to be more customizable and efficient. 
