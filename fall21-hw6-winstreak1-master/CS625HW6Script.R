library(tidyverse)
library(lubridate)
library(textclean)
library(stringi)
library(ggplot2)

CROSSWORD <- read.csv("nytcrosswords-csv2.csv",stringsAsFactors = FALSE)

XWORDS <- grep("X", CROSSWORD$Word, fixed = TRUE)

CROSSWORD.SS <- CROSSWORD[XWORDS,]
CROSSWORD.SS$Month <- month(mdy(CROSSWORD.SS$Date))
CROSSWORD.SS$WordLength <- nchar(CROSSWORD.SS$Word)
CROSSWORD.SS$ClueLength <- nchar(CROSSWORD.SS$Clue)
CROSSWORD.GP <- group_by(CROSSWORD.SS, Month)
CROSSWORD.GP <- summarize(CROSSWORD.GP, count=sum(Month==Month), meanw=mean(WordLength), meanc=mean(ClueLength))

QWORDS <- grep("Q", CROSSWORD$Word, fixed = TRUE)

CROSSWORD.SSQ <- CROSSWORD[QWORDS,]
CROSSWORD.SSQ$Month <- month(mdy(CROSSWORD.SSQ$Date))
CROSSWORD.SSQ$WordLength <- nchar(CROSSWORD.SSQ$Word)
CROSSWORD.SSQ$ClueLength <- nchar(CROSSWORD.SSQ$Clue)
CROSSWORD.GPQ <- group_by(CROSSWORD.SSQ, Month)
CROSSWORD.GPQ <- summarize(CROSSWORD.GPQ, count=sum(Month==Month), meanw=mean(WordLength), meanc=mean(ClueLength))

XOWORDS <- grep("XO", CROSSWORD$Word, fixed = TRUE)
CROSSWORD.XO <- CROSSWORD[XOWORDS,]
CROSSWORD.XO$Month <- month(mdy(CROSSWORD.XO$Date))
CROSSWORD.XO$WordLength <- nchar(CROSSWORD.XO$Word)
CROSSWORD.XO$ClueLength <- nchar(CROSSWORD.XO$Clue)

CROSSWORD.GPXO <- group_by(CROSSWORD.XO, Month)
CROSSWORD.GPXO <- summarize(CROSSWORD.GPXO, count=sum(Month==Month), meanw=mean(WordLength), meanc=mean(ClueLength))

#Idioms
barplot(CROSSWORD.GP$meanc,col = c("#2B35E5", "#2BFFE5", "#E335E5", "#d9b1f0"), xlab= "Month", ylab="Mean", names.arg=month.abb[1:12],las=2, main="1993-2021 NY Times Crossword Solutions containing the letter 'X'", cex.main=0.8, family = "serif")
plot(CROSSWORD.GP$meanc, type ="l", col = c("#E335E5"), xlab="Month", ylab="Mean",main="1993-2021 NY Times Crossword Solutions containing the letter 'X'", cex.main=0.8, family = "serif")
barplot(CROSSWORD.GPQ$meanc, col = c("#2B35E5", "#2BFFE5"), xlab="Month", ylab="Mean", names.arg=month.abb[1:12],las=2, main="1993-2021 NY Times Crossword Solutions containing the letter 'Q'", cex.main=0.8, family = "serif")
plot(CROSSWORD.GPQ$meanc, type ="l", col = c("#E335E5"), xlab="Month", ylab="Mean", main="1993-2021 NY Times Crossword Solutions containing the letter 'Q'", cex.main=0.8, family = "serif")

hist(CROSSWORD.SS$ClueLength, main="Length of Characters used in Clues for Words that Contain the Letter 'X'",xlab="Character Count", ylab="Frequency", xlim=c(3,100),col = c("#2B35E5", "#2BFFE5", "#E335E5", "#d9b1f0"), breaks = 100,cex.main=0.8, family = "serif")
#boxplot(Clue~ClueLength, data=CROSSWORD.SS, col=c("#2B35E5"), 
#main="US County Population from 2010-2019", horizontal=FALSE, xlab="Pop. by Year", ylab="Population", ylim=c(-10,20))
pairs(CROSSWORD.GP,col = c("#2B35E5", "#2BFFE5", "#E335E5", "#d9b1f0"), main="1993-2021 NY Times Crossword Solutions containing the letter 'X'", cex.main=0.8, family = "serif")
pairs(~ ClueLength + WordLength + Month, data = CROSSWORD.SS, col = c( "#2BFFE5", "#E335E5", "#d9b1f0"), main="1993-2021 NY Times Crossword Solutions containing the letter 'X'", cex.main=0.8, family = "serif")

