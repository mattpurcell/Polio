setwd("~/desktop/polio")

require('tidyr')
h = read.csv('HDI_original.csv')
h_long = gather(h, year, HDI, X2015:X1990)
h_long$year = as.numeric(substr(h_long$year, 2, 5))

d_long = read.csv('incidence-long.csv')

c = read.csv('coverage.csv')
c_long = gather(c, year, coverage, X2016:X1980)
c_long$year = as.numeric(substr(c_long$year, 2, 5))

incidence = d_long$incidence
HDI = h_long$HDI
coverage = c_long$coverage/100

logreg = glm(incidence ~ HDI + coverage, family = binomial(link = 'logit'))
