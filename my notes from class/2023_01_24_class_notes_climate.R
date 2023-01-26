### Heather Bruck 
### 2023-01-24
### Unit 2 Melting Ice Sheets Class Notes

library(tidyverse, plyr)
ant_ice_loss <- read.table("data/antarctica_mass_200204_202209.txt",
           skip = 31, 
           sep = "", 
           header = F, 
           col.names = c("decimal_date", "mass_Gt", "sigma_GT")) #Antarctica mass data 

grn_ice_loss <- read.table("data/greenland_mass_200204_202209.txt", 
            skip = 31, 
            sep = "", 
            header = F, 
            col.names = c("decimal_date", "mass_Gt", "sigma_GT")) #Greenland ice mass loss

view(ant_ice_loss)

head(grn_ice_loss) # head() shows the first 6 columns of data, shows the name of columns
tail(grn_ice_loss) # tail() shows the last 6 columns
summary(grn_ice_loss) # looks different depending on the type of data 

# plotting Antarctic ice mass loss 
plot(mass_Gt ~ decimal_date, data = ant_ice_loss, ylab = "Antarctica Mass Loss (Gt)")
  # another way to type this: 
    # plot(x = ant_ice_loss$decimal_date, y = ant_ice_loss$mass_Gt) 
  # same plot as a line: 
    # plot(mass_Gt ~ decimal_date, data = ant_ice_loss, type = "l", ylab = "Antarctica Mass Loss (Gt)")

# plot Greenland ice mass loss 
plot(mass_Gt ~ decimal_date, data = grn_ice_loss, ylab = "Greenland Mass Loss (Gt)") 
  # mass_Gt ~ decimal_date 
      # means y (mass_Gt) as a function of x (decimal_date)

# plot Antarctic and Greenland ice mass loss together as lines 
plot(mass_Gt ~ decimal_date, data = ant_ice_loss, 
     ylab = "Ice Sheet Mass Loss (Gt)", type = 'l')
lines(mass_Gt ~ decimal_date, 
      data = grn_ice_loss, 
      col = 'red')

# expanding plot window to show all of Greenland's data 
plot(mass_Gt ~ decimal_date, data = ant_ice_loss, 
     ylab = "Antarctica Mass Loss (Gt)", 
     type = 'l', 
     ylim = range(grn_ice_loss$mass_Gt)) +
  lines(mass_Gt ~ decimal_date, data = grn_ice_loss, 
        type = 'l', 
        col = 'red')
    # can also use min(grn_ice_loss$mass_Gt) or max() instead of range

# forcing R to note the gap in data from 2017-2018
  # without this, it draws a line between the missing data which looks like we recorded it but we didnt 
# create data.frame with an NA between the GRACE missions, column names must match so it will merge with data 
data_break <- data.frame(decimal_date = 2018.0, mass_Gt = NA, sigma_GT = NA) 
data_break

# add the NA data point to the Antarctica ice trends data frame 
ant_ice_loss_with_NA <- rbind(ant_ice_loss, data_break)
grn_ice_loss_with_NA <- rbind(grn_ice_loss, data_break)

# checking data with NA 
dim(ant_ice_loss)
dim(ant_ice_loss_with_NA) # we added a row, but where? 
tail(ant_ice_loss_with_NA) # check the last few rows to see if they are there 
  # NA data gets pushed to the end (so 2018 data is at the bottom) 
  # so we need to reorder this data frame by the correct date 
order(ant_ice_loss_with_NA$decimal_date)
  # this re-orders the data to have the NA 2018 data in the right chronological spot 
  # output shows the order by the row # (see that 214, the NA, is in the middle) 
ant_ice_loss_with_NA <- ant_ice_loss_with_NA[order(ant_ice_loss_with_NA$decimal_date),]
grn_ice_loss_with_NA <- grn_ice_loss_with_NA[order(grn_ice_loss_with_NA$decimal_date), ]
  # saying take all of the data in this data frame, but reorder it to look like the output of order() 
  # , means to give me all of the columns 

plot(mass_Gt ~ decimal_date, 
     data = ant_ice_loss_with_NA, 
     ylab = 'Antarctica Mass Los (Gt)', 
     type = 'l', 
     ylim = range(grn_ice_loss_with_NA$mass_Gt, na.rm = T)) +
  lines(mass_Gt ~ decimal_date, 
        data = grn_ice_loss_with_NA, 
        type = 'l', 
        col = 'red') 
  

# adding error bars with hand coding (no special program) 
head(ant_ice_loss_with_NA)
plot(mass_Gt ~ decimal_date, 
     data = ant_ice_loss_with_NA, 
     ylab = 'Antarctica Mass Loss (Gt)', 
     xlab = 'Y ear', 
     type = 'l') +
  lines((mass_Gt+2*sigma_GT) ~ decimal_date, 
        data = ant_ice_loss_with_NA, 
        type = 'l', 
        lty = 'dashed') +
  lines((mass_Gt-2*sigma_GT) ~ decimal_date, 
        data = ant_ice_loss_with_NA, 
        type = 'l', 
        lty = 'dashed')

# saving figure as a pdf, always put this before the figure 
pdf('figures/ice_mass_trends.pdf', width = 7, height = 5)
plot(mass_Gt ~ decimal_date, 
     data = ant_ice_loss_with_NA, 
     ylab = 'Antarctica Mass Loss (Gt)', 
     xlab = 'Y ear', 
     type = 'l') +
  lines((mass_Gt+2*sigma_GT) ~ decimal_date, 
        data = ant_ice_loss_with_NA, 
        type = 'l', 
        lty = 'dashed') +
  lines((mass_Gt-2*sigma_GT) ~ decimal_date, 
        data = ant_ice_loss_with_NA, 
        type = 'l', 
        lty = 'dashed')
dev.off()
  # this clears the plot environment 