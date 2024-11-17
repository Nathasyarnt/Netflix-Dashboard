library(dplyr)
library(readxl)
library(tidyr)
install.packages("tidyverse")
install.packages("Hmisc")
library(tidyverse)
library(Hmisc)

#panggil data
data <- read_excel("C:/Users/IKA ARIANTO/Downloads/Dashboard Netflix/data fix.xlsx")
View(data)

#hapus kolom
data$...10 <- NULL
data$...11 <- NULL
data$...12 <- NULL
data$...13 <- NULL
data$...14 <- NULL
data$...15 <- NULL
data$...16 <- NULL
data$...17 <- NULL
data$...18 <- NULL
View(data)
str(data)

#convert chr to numeric
data$runtime <- as.integer(data$runtime)
data$imdb_score <- as.integer(data$imdb_score)
data$imdb_votes <- as.integer(data$imdb_votes)
str(data)

#identifikasi misisng value
missing_value <- is.na(data)
print(missing_value)

#handling missing value data numerik
data$runtime <- with(data, impute(runtime, median))
data$imdb_score <- with(data, impute(imdb_score, median))
data$imdb_votes <- with(data, impute(imdb_votes, median))
str(data)

#identifikasi misisng value pada data kategori
data[data == ''] <- NA
sum(is.na(data$age_certification))

# Menghitung modus (nilai yang paling sering muncul)
modus_category <- names(sort(table(data$age_certification), decreasing = TRUE))[1]

# Menampilkan modus
print(modus_category)

# Mengganti missing value dengan modus 
data$age_certification[is.na(data$age_certification)] <- modus_category

# Menampilkan data setelah mengganti missing value
print(data)
sum(is.na(data$age_certification))

write.csv(data, "C:/Users/IKA ARIANTO/Downloads/Dashboard Netflix/datafix.csv")
