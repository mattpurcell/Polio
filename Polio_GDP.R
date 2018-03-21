setwd("~/desktop/polio")

require('tidyr')


d_long = read.csv('incidence-long.csv')
names(d_long)[names(d_long) == 'Cname'] = 'Country'

c = read.csv('coverage.csv')
c_long = gather(c, year, coverage, X2016:X1980)
c_long$year = as.numeric(substr(c_long$year, 2, 5))

g = read.csv('GDP.csv')
g_long = gather(g, year, GDP, X2016:X1960)
g_long$year = as.numeric(substr(g_long$year, 2, 5))

merged_data = merge(c_long, g_long[,c('Country', 'year', 'GDP')])
merged_data = merge(merged_data, d_long[,c('Country', 'year', 'incidence')])
merged_data$coverage = merged_data$coverage/100
attach(merged_data)

incidence = merged_data$incidence
GDP = merged_data$GDP
coverage = merged_data$coverage

logreg = glm(incidence!=0 ~ GDP + coverage, family = binomial(link = 'logit'))

summary(logreg)
detach(merged_data)
