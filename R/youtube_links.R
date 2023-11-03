# Create list of links from CourseWorks submissions
library(rvest)
library(purrr)
path_to_submissions <- "~/Downloads/submissions/"
files <- list.files(path_to_submissions)
a <- map(paste0(path_to_submissions, files), read_html)
links <- map_chr(a, ~.x |> html_element("a") |> html_attr("href"))
writeLines(links, "MonWedLinks.txt")
