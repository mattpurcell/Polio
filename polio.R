#setwd("~/desktop/polio")

require('tidyr')
h = read.csv('HDI_original.csv')
h_long = gather(h, year, HDI, X2015:X1990)
h_long$year = as.numeric(substr(h_long$year, 2, 5))
h_long$Country = trimws(h_long$Country)

d_long = read.csv('incidence-long.csv')
names(d_long)[names(d_long) == 'Cname'] = 'Country'

c = read.csv('coverage.csv')
c_long = gather(c, year, coverage, X2016:X1980)
c_long$year = as.numeric(substr(c_long$year, 2, 5))

merged_data = merge(c_long, h_long[,c('Country', 'year', 'HDI')])
merged_data = merge(merged_data, d_long[,c('Country', 'year', 'incidence')])
merged_data$coverage = merged_data$coverage/100
attach(merged_data)

logreg = glm(incidence ~ HDI + coverage, family = binomial(link = 'logit'))

detach(merged_data)
