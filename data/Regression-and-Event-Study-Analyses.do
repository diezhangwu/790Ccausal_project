
*********Set directory and load data set entitled "Regression and Event Study Analyses.dta"*********
/*
use "H:\oldTS1desktop\Clean Water and Pasteurized Milk\Replication Files for AEJ Applied\Regression and Event Study Analyses.dta", clear
*/

**********Install required packages*********
/*
If using an older version of STATA, the following commands will install the boottest and coefplot packages required below:

ssc install boottest
ssc install coefplot
*/


****************************************************************************************************************************************************************
*Table 5. Summary Statistics
****************************************************************************************************************************************************************
sum filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus if mortality != .



*****************************************************************************************************************************************************************
*Table 6. The Effects of Water Quality, Sewage Treatment/Diversion, and Clean Milk on Total Mortality
*****************************************************************************************************************************************************************
sum mortality_rate

*Column (1): Water variables
xtreg ln_mortality_rate filter chlorination water_project percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)

*Column (2): Sewage variable
xtreg ln_mortality_rate sewage_treat_div percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {sewage_treat_div = 0}, reps(1000)

*Column (3): Milk variables
xtreg ln_mortality_rate bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)

*Column (4): Water + sewage variables
xtreg ln_mortality_rate filter chlorination water_project sewage_treat_div percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)

*Column (5): Water + sewage + milk variables
xtreg ln_mortality_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)



*****************************************************************************************************************************************************************
*Table 7. The Effects of Water Quality, Sewage Treatment/Diversion, and Clean Milk on Infant Mortality
*****************************************************************************************************************************************************************
sum mortality_under1_rate

*Column (1): Water variables
xtreg ln_mortality_under1_rate filter chlorination water_project percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)

*Column (2): Sewage variable
xtreg ln_mortality_under1_rate sewage_treat_div percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {sewage_treat_div = 0}, reps(1000)

*Column (3): Milk variables
xtreg ln_mortality_under1_rate bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)

*Column (4): Water + sewage variables
xtreg ln_mortality_under1_rate filter chlorination water_project sewage_treat_div percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)

*Column (5): Water + sewage + milk variables
xtreg ln_mortality_under1_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)



*****************************************************************************************************************************************************************
*Table 8. Robustness Checks: The Effects of Water Quality, Sewage Treatment/Diversion, and Clean Milk on Infant Mortality
*****************************************************************************************************************************************************************
*Column (1): Control for wages
xtreg ln_mortality_under1_rate filter chlorination water_project sewage_treat_div bact_standard TB_test real_ave_wage_imp percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)
sum mortality_under1_rate if real_ave_wage_imp != .

*Column (2): Control for region-by-year FEs
gen south = 0
replace south = 1 if (state_fips == 1 | state_fips == 5 | state_fips == 10 | state_fips == 11 | state_fips == 12 | state_fips == 13 | state_fips == 21 | state_fips == 22 | state_fips == 24 | state_fips == 28 | state_fips == 37 | state_fips == 40 | state_fips == 45 | state_fips == 47 | state_fips == 48 | state_fips == 51 | state_fips == 54)
gen northeast = 0
replace northeast = 1 if (state_fips == 9 | state_fips == 23 | state_fips == 25 | state_fips == 33 | state_fips == 34 | state_fips == 36 | state_fips == 42 | state_fips == 44 | state_fips == 50)
gen midwest = 0
replace midwest = 1 if (state_fips == 17 | state_fips == 18 | state_fips == 19 | state_fips == 20 | state_fips == 26 | state_fips == 27  | state_fips == 29 | state_fips == 31 | state_fips == 38 | state_fips == 39 | state_fips == 46 | state_fips == 55)
gen west = 0
replace west = 1 if (state_fips == 2 | state_fips == 4 | state_fips == 6 | state_fips == 8 | state_fips == 15 | state_fips == 16 | state_fips == 30 | state_fips == 32 | state_fips == 35 | state_fips == 41 | state_fips == 49 | state_fips == 53 | state_fips == 56)

quietly tab year, generate(year_fe_)

foreach var of varlist year_fe_* {
	gen `var'_south = `var'*south
	gen `var'_northeast = `var'*northeast
	gen `var'_midwest = `var'*midwest
	gen `var'_west = `var'*west
	drop `var'
}

xtreg ln_mortality_under1_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend year_fe* [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)

*Column (3): Unweighted
xtreg ln_mortality_under1_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend, fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)

*Column (4): Drop NYC
xtreg ln_mortality_under1_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave] if state_city_id != 3634, fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)
sum mortality_under1_rate if state_city_id != 3634

*Column (5): Drop 1917-1920
xtreg ln_mortality_under1_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave] if (year < 1917 | year > 1920), fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)
sum mortality_under1_rate if (year < 1917 | year > 1920)

*Column (6): Dependent variable in levels
xtreg mortality_under1_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)



*****************************************************************************************************************************************************************
*Table 9. Infant Mortality and Lags of Filtration
*****************************************************************************************************************************************************************
*Column (1): 3 lags
xtreg ln_mortality_under1_rate filter_time0 filter_lag1 filter_lag2 filter_lag3plus chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter_time0 = 0}, reps(1000)
boottest {filter_lag1 = 0}, reps(1000)
boottest {filter_lag2 = 0}, reps(1000)
boottest {filter_lag3plus = 0}, reps(1000)

*Column (2): 5 lags
xtreg ln_mortality_under1_rate filter_time0 filter_lag1 filter_lag2 filter_lag3 filter_lag4 filter_lag5plus chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter_time0 = 0}, reps(1000)
boottest {filter_lag1 = 0}, reps(1000)
boottest {filter_lag2 = 0}, reps(1000)
boottest {filter_lag3 = 0}, reps(1000)
boottest {filter_lag4 = 0}, reps(1000)
boottest {filter_lag5plus = 0}, reps(1000)

*Column (3): 7 lags
xtreg ln_mortality_under1_rate filter_time0 filter_lag1 filter_lag2 filter_lag3 filter_lag4 filter_lag5 filter_lag6 filter_lag7plus chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter_time0 = 0}, reps(1000)
boottest {filter_lag1 = 0}, reps(1000)
boottest {filter_lag2 = 0}, reps(1000)
boottest {filter_lag3 = 0}, reps(1000)
boottest {filter_lag4 = 0}, reps(1000)
boottest {filter_lag5 = 0}, reps(1000)
boottest {filter_lag6 = 0}, reps(1000)
boottest {filter_lag7plus = 0}, reps(1000)



*****************************************************************************************************************************************************************
*Table 10. The Effects of Water Quality, Sewage Treatment/Diversion, and Clean Milk on Mortality by Cause
*****************************************************************************************************************************************************************
*Column (1): Typhoid mortality 
xtreg typhoid_rate_quart filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
sum typhoid_rate
di 4*(_b[filter])*(12.63^(.75))
di 4*(_b[chlorination])*(12.63^(.75))
di 4*(_b[water_project])*(12.63^(.75))
di 4*(_b[sewage_treat_div])*(12.63^(.75))
di 4*(_b[bact_standard])*(12.63^(.75))
di 4*(_b[TB_test])*(12.63^(.75))
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)

*Column (2): Diarrhea/enteritis mortality
xtreg ln_diarrhea_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)
sum diarrhea_rate

*Column (3): Diarrhea/enteritis (under age 2) mortality
xtreg ln_diarrhea_under2_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)
sum diarrhea_under2_rate

*Column (4): Nonpulmonary TB mortality
xtreg ln_nonpul_TB_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)
sum nonpul_TB_rate

*Column (5): Nonpulmonary TB (under age 2) mortality
xtreg nonpul_TB_under2_rate_quart filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
sum nonpul_TB_under2_rate
di 4*(_b[filter])*(3.98^(.75))
di 4*(_b[chlorination])*(3.98^(.75))
di 4*(_b[water_project])*(3.98^(.75))
di 4*(_b[sewage_treat_div])*(3.98^(.75))
di 4*(_b[bact_standard])*(3.98^(.75))
di 4*(_b[TB_test])*(3.98^(.75))
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)




*************************************************************************************************************************************************************************************
*Tables for Online Appendix
*************************************************************************************************************************************************************************************
*****************************************************************************************************************************************************************
*Appendix Table 1. Robustness Checks: The Effects of Water Quality, Sewage Treatment/Diversion, and Clean Milk on Typhoid Mortality
*****************************************************************************************************************************************************************
*Column (1): Control for wages 
xtreg typhoid_rate_quart filter chlorination water_project sewage_treat_div bact_standard TB_test real_ave_wage_imp percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
sum typhoid_rate if real_ave_wage_imp != .
di 4*(_b[filter])*(13.58^(.75))
di 4*(_b[chlorination])*(13.58^(.75))
di 4*(_b[water_project])*(13.58^(.75))
di 4*(_b[sewage_treat_div])*(13.58^(.75))
di 4*(_b[bact_standard])*(13.58^(.75))
di 4*(_b[TB_test])*(13.58^(.75))
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)

*Column (2): Control for region-by-year FEs
xtreg typhoid_rate_quart filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend year_fe* [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
sum typhoid_rate
di 4*(_b[filter])*(12.63^(.75))
di 4*(_b[chlorination])*(12.63^(.75))
di 4*(_b[water_project])*(12.63^(.75))
di 4*(_b[sewage_treat_div])*(12.63^(.75))
di 4*(_b[bact_standard])*(12.63^(.75))
di 4*(_b[TB_test])*(12.63^(.75))
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)

*Column (3): Unweighted
xtreg typhoid_rate_quart filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend, fe i(state_city_id) cluster(state_city_id)
sum typhoid_rate
di 4*(_b[filter])*(12.63^(.75))
di 4*(_b[chlorination])*(12.63^(.75))
di 4*(_b[water_project])*(12.63^(.75))
di 4*(_b[sewage_treat_div])*(12.63^(.75))
di 4*(_b[bact_standard])*(12.63^(.75))
di 4*(_b[TB_test])*(12.63^(.75))
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)

*Column (4): Drop NYC
xtreg typhoid_rate_quart filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave] if state_city_id != 3634, fe i(state_city_id) cluster(state_city_id)
sum typhoid_rate if state_city_id != 3634
di 4*(_b[filter])*(12.89^(.75))
di 4*(_b[chlorination])*(12.89^(.75))
di 4*(_b[water_project])*(12.89^(.75))
di 4*(_b[sewage_treat_div])*(12.89^(.75))
di 4*(_b[bact_standard])*(12.89^(.75))
di 4*(_b[TB_test])*(12.89^(.75))
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)

*Column (5): Drop 1917-1920
xtreg typhoid_rate_quart filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave] if (year < 1917 | year > 1920), fe i(state_city_id) cluster(state_city_id)
sum typhoid_rate if (year < 1917 | year > 1920)
di 4*(_b[filter])*(13.25^(.75))
di 4*(_b[chlorination])*(13.25^(.75))
di 4*(_b[water_project])*(13.25^(.75))
di 4*(_b[sewage_treat_div])*(13.25^(.75))
di 4*(_b[bact_standard])*(13.25^(.75))
di 4*(_b[TB_test])*(13.25^(.75))
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)

*Column (6): Dependent variable in levels
xtreg typhoid_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)
sum typhoid_rate



*****************************************************************************************************************************************************************
*Appendix Table 2. Typhoid Mortality and Lags of Filtration
*****************************************************************************************************************************************************************
*Column (1): 3 lags
xtreg typhoid_rate_quart filter_time0 filter_lag1 filter_lag2 filter_lag3plus chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
di 4*(_b[filter_time0])*(12.63^(.75))
di 4*(_b[filter_lag1])*(12.63^(.75))
di 4*(_b[filter_lag2])*(12.63^(.75))
di 4*(_b[filter_lag3plus])*(12.63^(.75))
set seed 93843
boottest {filter_time0 = 0}, reps(1000)
boottest {filter_lag1 = 0}, reps(1000)
boottest {filter_lag2 = 0}, reps(1000)
boottest {filter_lag3plus = 0}, reps(1000)

*Column (2): 5 lags
xtreg typhoid_rate_quart filter_time0 filter_lag1 filter_lag2 filter_lag3 filter_lag4 filter_lag5plus chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
di 4*(_b[filter_time0])*(12.63^(.75))
di 4*(_b[filter_lag1])*(12.63^(.75))
di 4*(_b[filter_lag2])*(12.63^(.75))
di 4*(_b[filter_lag3])*(12.63^(.75))
di 4*(_b[filter_lag4])*(12.63^(.75))
di 4*(_b[filter_lag5plus])*(12.63^(.75))
set seed 93843
boottest {filter_time0 = 0}, reps(1000)
boottest {filter_lag1 = 0}, reps(1000)
boottest {filter_lag2 = 0}, reps(1000)
boottest {filter_lag3 = 0}, reps(1000)
boottest {filter_lag4 = 0}, reps(1000)
boottest {filter_lag5plus = 0}, reps(1000)

*Column (3): 7 lags
xtreg typhoid_rate_quart filter_time0 filter_lag1 filter_lag2 filter_lag3 filter_lag4 filter_lag5 filter_lag6 filter_lag7plus chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
di 4*(_b[filter_time0])*(12.63^(.75))
di 4*(_b[filter_lag1])*(12.63^(.75))
di 4*(_b[filter_lag2])*(12.63^(.75))
di 4*(_b[filter_lag3])*(12.63^(.75))
di 4*(_b[filter_lag4])*(12.63^(.75))
di 4*(_b[filter_lag5])*(12.63^(.75))
di 4*(_b[filter_lag6])*(12.63^(.75))
di 4*(_b[filter_lag7plus])*(12.63^(.75))
set seed 93843
boottest {filter_time0 = 0}, reps(1000)
boottest {filter_lag1 = 0}, reps(1000)
boottest {filter_lag2 = 0}, reps(1000)
boottest {filter_lag3 = 0}, reps(1000)
boottest {filter_lag4 = 0}, reps(1000)
boottest {filter_lag5 = 0}, reps(1000)
boottest {filter_lag6 = 0}, reps(1000)
boottest {filter_lag7plus = 0}, reps(1000)



*****************************************************************************************************************************************************************
*Appendix Table 3. Robustness Checks: The Effects of Water Quality, Sewage Treatment/Diversion, and Clean Milk on Diarrhea/Enteritis Mortality
*****************************************************************************************************************************************************************
*Column (1): Control for wages
xtreg ln_diarrhea_rate filter chlorination water_project sewage_treat_div bact_standard TB_test real_ave_wage_imp percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)
sum diarrhea_rate if real_ave_wage_imp != .

*Column (2): Control for region-by-year FEs
xtreg ln_diarrhea_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend year_fe* [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)
sum diarrhea_rate

*Column (3): Unweighted
xtreg ln_diarrhea_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend, fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)

*Column (4): Drop NYC
xtreg ln_diarrhea_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave] if state_city_id != 3634, fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)
sum diarrhea_rate if state_city_id != 3634

*Column (5): Drop 1917-1920
xtreg ln_diarrhea_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave] if (year < 1917 | year > 1920), fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)
sum diarrhea_rate if (year < 1917 | year > 1920)

*Column (6): Dependent variable in levels
xtreg diarrhea_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {water_project = 0}, reps(1000)
boottest {sewage_treat_div = 0}, reps(1000)
boottest {bact_standard = 0}, reps(1000)
boottest {TB_test = 0}, reps(1000)



*****************************************************************************************************************************************************************
*Appendix Table 4. Diarrhea/Enteritis Mortality and Lags of Filtration
*****************************************************************************************************************************************************************
*Column (1): 3 lags
xtreg ln_diarrhea_rate filter_time0 filter_lag1 filter_lag2 filter_lag3plus chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter_time0 = 0}, reps(1000)
boottest {filter_lag1 = 0}, reps(1000)
boottest {filter_lag2 = 0}, reps(1000)
boottest {filter_lag3plus = 0}, reps(1000)

*Column (2): 5 lags
xtreg ln_diarrhea_rate filter_time0 filter_lag1 filter_lag2 filter_lag3 filter_lag4 filter_lag5plus chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter_time0 = 0}, reps(1000)
boottest {filter_lag1 = 0}, reps(1000)
boottest {filter_lag2 = 0}, reps(1000)
boottest {filter_lag3 = 0}, reps(1000)
boottest {filter_lag4 = 0}, reps(1000)
boottest {filter_lag5plus = 0}, reps(1000)

*Column (3): 7 lags
xtreg ln_diarrhea_rate filter_time0 filter_lag1 filter_lag2 filter_lag3 filter_lag4 filter_lag5 filter_lag6 filter_lag7plus chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)
set seed 93843
boottest {filter_time0 = 0}, reps(1000)
boottest {filter_lag1 = 0}, reps(1000)
boottest {filter_lag2 = 0}, reps(1000)
boottest {filter_lag3 = 0}, reps(1000)
boottest {filter_lag4 = 0}, reps(1000)
boottest {filter_lag5 = 0}, reps(1000)
boottest {filter_lag6 = 0}, reps(1000)
boottest {filter_lag7plus = 0}, reps(1000)



****************************************************************************************************************************************************************
*Appendix Table 6. Comparing City Characteristics of our Sample to that of Cutler and Miller (2005) 
****************************************************************************************************************************************************************
*C&M sample
sum pop percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus if mortality != . & (cutler_miller_sample == 1 & (year > 1904 & year < 1937))

*Our sample
sum pop percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus if mortality != .




*************************************************************************************************************************************************************************************
*Event Study Figures
*************************************************************************************************************************************************************************************
******************************************************************************************************************************************
*Figure 5. Pre- and Post-Filtration Trends in Infant Mortality
******************************************************************************************************************************************
gen zero = 0
label var zero "-1"

xtreg ln_mortality_under1_rate filter_lead5plus filter_lead4 filter_lead3 filter_lead2 zero filter_time0 filter_lag1 filter_lag2 filter_lag3 filter_lag4 filter_lag5plus chlorination water_project sewage_treat_div TB_test bact_standard percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)

estimates store leads_lags

coefplot leads_lags, omitted keep(filter_lead5plus filter_lead4 filter_lead3 filter_lead2 zero ///
filter_time0 filter_lag1 filter_lag2 filter_lag3 filter_lag4 filter_lag5plus) ///
vertical title("{bf:Figure 5. Pre- and Post-Filtration Trends in Infant Mortality}", color(black) size(medlarge)) ///
xtitle("Years Since Filtration Came Into Effect") xscale(titlegap(2))  xline(5, lcolor(black)) xlabel(, labsize(small)) ///
yline(-.2 -.1 0 .1 .2, lwidth(vvvthin) lpattern(dash) lcolor(black)) ///
note("Notes: OLS coefficient estimates (and their 90% confidence intervals) are reported, where the omitted category" ///
"is 1 year before treatment. The dependent variable is equal to the natural log of the number of infant deaths per" ///
"100,000 population in city {it:c} and year {it:t}. Controls include the demographic characteristics and remaining public" ///
"health interventions listed in Table 5, city fixed effects, year fixed effects, and city-specific linear trends." ///
"Regressions are weighted by city population. Standard errors are corrected for clustering at the city level.", margin(small)) ///
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) ///
ciopts(recast(rcap) lcolor(black)) level(90) mcolor(black) 



******************************************************************************************************************************************
*Figure 6. Pre- and Post-Filtration Trends in Typhoid Mortality
******************************************************************************************************************************************
xtreg typhoid_rate_quart filter_lead5plus filter_lead4 filter_lead3 filter_lead2 zero filter_time0 filter_lag1 filter_lag2 filter_lag3 filter_lag4 filter_lag5plus chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)

estimates store leads_lags

coefplot leads_lags, omitted keep(filter_lead5plus filter_lead4 filter_lead3 filter_lead2 zero ///
filter_time0 filter_lag1 filter_lag2 filter_lag3 filter_lag4 filter_lag5plus) ///
vertical title("{bf:Figure 6. Pre- and Post-Filtration Trends in Typhoid Mortality}", color(black) size(medlarge)) ///
xtitle("Years Since Filtration Came Into Effect") xscale(titlegap(2))  xline(5, lcolor(black)) xlabel(, labsize(small)) ///
yline(-.4 -.3 -.2 -.1 0 .1, lwidth(vvvthin) lpattern(dash) lcolor(black)) ///
note("Notes: OLS coefficient estimates (and their 90% confidence intervals) are reported, where the omitted category" ///
"is 1 year before treatment. The dependent variable is equal to the quartic root of the number of typhoid deaths" ///
"per 100,000 population in city {it:c} and year {it:t}. Controls include the demographic characteristics and remaining" ///
"public health interventions listed in Table 5, city fixed effects, year fixed effects, and city-specific linear trends." ///
"Regressions are weighted by city population. Standard errors are corrected for clustering at the city level.", margin(small)) ///
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) ///
ciopts(recast(rcap) lcolor(black)) level(90) mcolor(black) 



******************************************************************************************************************************************
*Appendix Figure 7. Pre- and Post-Water-Related Intervention Trends in Total Mortality
******************************************************************************************************************************************
xtreg ln_mortality_rate filter_lead5plus filter_lead4 filter_lead3 filter_lead2 zero filter_time0 filter_lag1 filter_lag2 filter_lag3 filter_lag4 filter_lag5plus chlorination water_project sewage_treat_div TB_test bact_standard percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)

estimates store leads_lags

coefplot leads_lags, omitted keep(filter_lead5plus filter_lead4 filter_lead3 filter_lead2 zero ///
filter_time0 filter_lag1 filter_lag2 filter_lag3 filter_lag4 filter_lag5plus) ///
vertical title("{bf:Appendix Figure 7. Pre- and Post-Filtration Trends in Total Mortality}", color(black) size(medlarge)) ///
xtitle("Years Since Filtration Came Into Effect") xscale(titlegap(2))  xline(5, lcolor(black)) xlabel(, labsize(small)) ///
yline(-.1 -.05 0 .05 .1, lwidth(vvvthin) lpattern(dash) lcolor(black)) ///
note("Notes: OLS coefficient estimates (and their 90% confidence intervals) are reported, where the omitted category" ///
"is 1 year before treatment. The dependent variable is equal to the natural log of the number of deaths per" ///
"100,000 population in city {it:c} and year {it:t}. Controls include the demographic characteristics and remaining public" ///
"health interventions listed in Table 5, city fixed effects, year fixed effects, and city-specific linear trends." ///
"Regressions are weighted by city population. Standard errors are corrected for clustering at the city level.", margin(small)) ///
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) ///
ciopts(recast(rcap) lcolor(black)) level(90) mcolor(black) 




******************************************************************************************************************************************
*Appendix Figure 8. Pre- and Post-Water-Related Intervention Trends in Total Mortality
******************************************************************************************************************************************
*Chlorination
xtreg ln_mortality_rate chlorination_lead5plus chlorination_lead4 chlorination_lead3 chlorination_lead2 zero chlorination_time0 chlorination_lag1 chlorination_lag2 chlorination_lag3 chlorination_lag4 chlorination_lag5plus filter water_project sewage_treat_div TB_test bact_standard percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)

estimates store leads_lags

coefplot leads_lags, omitted keep(chlorination_lead5plus chlorination_lead4 chlorination_lead3 chlorination_lead2 zero ///
chlorination_time0 chlorination_lag1 chlorination_lag2 chlorination_lag3 chlorination_lag4 chlorination_lag5plus) ///
vertical  title("{bf:Pre- and Post-Chlorination Trends in Total Mortality}", color(black) size(medlarge)) ///
xtitle("Years Since Chlorination Came Into Effect") xscale(titlegap(2))  xline(5, lcolor(black)) xlabel(, labsize(small)) ///
yline(-.04 -.02 0 .02 .04, lwidth(vvvthin) lpattern(dash) lcolor(black)) ///
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) ///
ciopts(recast(rcap) lcolor(black)) level(90) mcolor(black) 


*Clean water projects
xtreg ln_mortality_rate water_project_lead5plus water_project_lead4 water_project_lead3 water_project_lead2 zero water_project_time0 water_project_lag1 water_project_lag2 water_project_lag3 water_project_lag4 water_project_lag5plus filter chlorination sewage_treat_div TB_test bact_standard percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)

estimates store leads_lags

coefplot leads_lags, omitted keep(water_project_lead5plus water_project_lead4 water_project_lead3 water_project_lead2 zero ///
water_project_time0 water_project_lag1 water_project_lag2 water_project_lag3 water_project_lag4 water_project_lag5plus) ///
vertical  title("{bf:Pre- and Post-Clean Water Project Trends in Total Mortality}", color(black) size(medlarge)) ///
xtitle("Years Since Clean Water Project Came Into Effect") xscale(titlegap(2))  xline(5, lcolor(black)) xlabel(, labsize(small)) ///
yline(-.1 -.05 0 .05 .1, lwidth(vvvthin) lpattern(dash) lcolor(black)) ///
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) ///
ciopts(recast(rcap) lcolor(black)) level(90) mcolor(black) 


*Sewage treatment/diversion
xtreg ln_mortality_rate sewage_treat_div_lead5plus sewage_treat_div_lead4 sewage_treat_div_lead3 sewage_treat_div_lead2 zero sewage_treat_div_time0 sewage_treat_div_lag1 sewage_treat_div_lag2 sewage_treat_div_lag3 sewage_treat_div_lag4 sewage_treat_div_lag5plus filter chlorination water_project TB_test bact_standard percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)

estimates store leads_lags

coefplot leads_lags, omitted keep(sewage_treat_div_lead5plus sewage_treat_div_lead4 sewage_treat_div_lead3 sewage_treat_div_lead2 zero ///
sewage_treat_div_time0 sewage_treat_div_lag1 sewage_treat_div_lag2 sewage_treat_div_lag3 sewage_treat_div_lag4 sewage_treat_div_lag5plus) ///
vertical  title("{bf:Pre- and Post-Sewage Treatment/Diversion Trends in Total Mortality}", color(black) size(medlarge)) ///
xtitle("Years Since Sewage Treatment/Diversion Came Into Effect") xscale(titlegap(2))  xline(5, lcolor(black)) xlabel(, labsize(small)) ///
yline(-.05 0 .05 .1, lwidth(vvvthin) lpattern(dash) lcolor(black)) ///
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) ///
ciopts(recast(rcap) lcolor(black)) level(90) mcolor(black) 



******************************************************************************************************************************************
*Appendix Figure 9. Pre- and Post-Milk-Related Intervention Trends in Total Mortality
******************************************************************************************************************************************
*Bacteriological standard
xtreg ln_mortality_rate bact_standard_lead5plus bact_standard_lead4 bact_standard_lead3 bact_standard_lead2 zero bact_standard_time0 bact_standard_lag1 bact_standard_lag2 bact_standard_lag3 bact_standard_lag4 bact_standard_lag5plus filter chlorination water_project sewage_treat_div TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)

estimates store leads_lags

coefplot leads_lags, omitted keep(bact_standard_lead5plus bact_standard_lead4 bact_standard_lead3 bact_standard_lead2 zero ///
bact_standard_time0 bact_standard_lag1 bact_standard_lag2 bact_standard_lag3 bact_standard_lag4 bact_standard_lag5plus) ///
vertical  title("{bf:Pre- and Post-Bacteriological Standard Trends in Total Mortality}", color(black) size(medlarge)) ///
xtitle("Years Since Bacteriological Standard Came Into Effect") xscale(titlegap(2))  xline(5, lcolor(black)) xlabel(, labsize(small)) ///
yline(-.05 0 .05 .1, lwidth(vvvthin) lpattern(dash) lcolor(black)) ///
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) ///
ciopts(recast(rcap) lcolor(black)) level(90) mcolor(black) 


*TB Test
xtreg ln_mortality_rate TB_test_lead5plus TB_test_lead4 TB_test_lead3 TB_test_lead2 zero TB_test_time0 TB_test_lag1 TB_test_lag2 TB_test_lag3 TB_test_lag4 TB_test_lag5plus filter chlorination water_project sewage_treat_div bact_standard percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)

estimates store leads_lags

coefplot leads_lags, omitted keep(TB_test_lead5plus TB_test_lead4 TB_test_lead3 TB_test_lead2 zero ///
TB_test_time0 TB_test_lag1 TB_test_lag2 TB_test_lag3 TB_test_lag4 TB_test_lag5plus) ///
vertical  title("{bf:Pre- and Post-TB Test Trends in Total Mortality}", color(black) size(medlarge)) ///
xtitle("Years Since TB Test Came Into Effect") xscale(titlegap(2))  xline(5, lcolor(black)) xlabel(, labsize(small)) ///
yline(-.02 0 .02 .04 .06, lwidth(vvvthin) lpattern(dash) lcolor(black)) ///
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) ///
ciopts(recast(rcap) lcolor(black)) level(90) mcolor(black) 



******************************************************************************************************************************************
*Appendix Figure 10. Pre- and Post-Water-Related Intervention Trends in Infant Mortality
******************************************************************************************************************************************
*Chlorination
xtreg ln_mortality_under1_rate chlorination_lead5plus chlorination_lead4 chlorination_lead3 chlorination_lead2 zero chlorination_time0 chlorination_lag1 chlorination_lag2 chlorination_lag3 chlorination_lag4 chlorination_lag5plus filter water_project sewage_treat_div TB_test bact_standard percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)

estimates store leads_lags

coefplot leads_lags, omitted keep(chlorination_lead5plus chlorination_lead4 chlorination_lead3 chlorination_lead2 zero ///
chlorination_time0 chlorination_lag1 chlorination_lag2 chlorination_lag3 chlorination_lag4 chlorination_lag5plus) ///
vertical  title("{bf:Pre- and Post-Chlorination Trends in Infant Mortality}", color(black) size(medlarge)) ///
xtitle("Years Since Chlorination Came Into Effect") xscale(titlegap(2))  xline(5, lcolor(black)) xlabel(, labsize(small)) ///
yline(-.1 -.05 0 .05 .1 .15, lwidth(vvvthin) lpattern(dash) lcolor(black)) ///
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) ///
ciopts(recast(rcap) lcolor(black)) level(90) mcolor(black) 


*Clean water projects
xtreg ln_mortality_under1_rate water_project_lead5plus water_project_lead4 water_project_lead3 water_project_lead2 zero water_project_time0 water_project_lag1 water_project_lag2 water_project_lag3 water_project_lag4 water_project_lag5plus filter chlorination sewage_treat_div TB_test bact_standard percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)

estimates store leads_lags

coefplot leads_lags, omitted keep(water_project_lead5plus water_project_lead4 water_project_lead3 water_project_lead2 zero ///
water_project_time0 water_project_lag1 water_project_lag2 water_project_lag3 water_project_lag4 water_project_lag5plus) ///
vertical  title("{bf:Pre- and Post-Clean Water Project Trends in Infant Mortality}", color(black) size(medlarge)) ///
xtitle("Years Since Clean Water Project Came Into Effect") xscale(titlegap(2))  xline(5, lcolor(black)) xlabel(, labsize(small)) ///
yline(-.2 -.1 0 .1, lwidth(vvvthin) lpattern(dash) lcolor(black)) ///
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) ///
ciopts(recast(rcap) lcolor(black)) level(90) mcolor(black) 


*Sewage treatment/diversion
xtreg ln_mortality_under1_rate sewage_treat_div_lead5plus sewage_treat_div_lead4 sewage_treat_div_lead3 sewage_treat_div_lead2 zero sewage_treat_div_time0 sewage_treat_div_lag1 sewage_treat_div_lag2 sewage_treat_div_lag3 sewage_treat_div_lag4 sewage_treat_div_lag5plus filter chlorination water_project TB_test bact_standard percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)

estimates store leads_lags

coefplot leads_lags, omitted keep(sewage_treat_div_lead5plus sewage_treat_div_lead4 sewage_treat_div_lead3 sewage_treat_div_lead2 zero ///
sewage_treat_div_time0 sewage_treat_div_lag1 sewage_treat_div_lag2 sewage_treat_div_lag3 sewage_treat_div_lag4 sewage_treat_div_lag5plus) ///
vertical  title("{bf:Pre- and Post-Sewage Treatment/Diversion Trends in Infant Mortality}", color(black) size(medlarge)) ///
xtitle("Years Since Sewage Treatment/Diversion Came Into Effect") xscale(titlegap(2))  xline(5, lcolor(black)) xlabel(, labsize(small)) ///
yline(-.1 0 .1 .2, lwidth(vvvthin) lpattern(dash) lcolor(black)) ///
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) ///
ciopts(recast(rcap) lcolor(black)) level(90) mcolor(black) 



******************************************************************************************************************************************
*Appendix Figure 11. Pre- and Post-Milk-Related Intervention Trends in Infant Mortality
******************************************************************************************************************************************
*Bacteriological standard
xtreg ln_mortality_under1_rate bact_standard_lead5plus bact_standard_lead4 bact_standard_lead3 bact_standard_lead2 zero bact_standard_time0 bact_standard_lag1 bact_standard_lag2 bact_standard_lag3 bact_standard_lag4 bact_standard_lag5plus filter chlorination water_project sewage_treat_div TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)

estimates store leads_lags

coefplot leads_lags, omitted keep(bact_standard_lead5plus bact_standard_lead4 bact_standard_lead3 bact_standard_lead2 zero ///
bact_standard_time0 bact_standard_lag1 bact_standard_lag2 bact_standard_lag3 bact_standard_lag4 bact_standard_lag5plus) ///
vertical  title("{bf:Pre- and Post-Bacteriological Standard Trends in Infant Mortality}", color(black) size(medlarge)) ///
xtitle("Years Since Bacteriological Standard Came Into Effect") xscale(titlegap(2))  xline(5, lcolor(black)) xlabel(, labsize(small)) ///
yline(-.1 0 .1 .2, lwidth(vvvthin) lpattern(dash) lcolor(black)) ///
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) ///
ciopts(recast(rcap) lcolor(black)) level(90) mcolor(black) 


*TB Test
xtreg ln_mortality_under1_rate TB_test_lead5plus TB_test_lead4 TB_test_lead3 TB_test_lead2 zero TB_test_time0 TB_test_lag1 TB_test_lag2 TB_test_lag3 TB_test_lag4 TB_test_lag5plus filter chlorination water_project sewage_treat_div bact_standard percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)

estimates store leads_lags

coefplot leads_lags, omitted keep(TB_test_lead5plus TB_test_lead4 TB_test_lead3 TB_test_lead2 zero ///
TB_test_time0 TB_test_lag1 TB_test_lag2 TB_test_lag3 TB_test_lag4 TB_test_lag5plus) ///
vertical  title("{bf:Pre- and Post-TB Test Trends in Infant Mortality}", color(black) size(medlarge)) ///
xtitle("Years Since TB Test Came Into Effect") xscale(titlegap(2))  xline(5, lcolor(black)) xlabel(, labsize(small)) ///
yline(-.05 0 .05 .1 .15, lwidth(vvvthin) lpattern(dash) lcolor(black)) ///
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) ///
ciopts(recast(rcap) lcolor(black)) level(90) mcolor(black) 



******************************************************************************************************************************************
*Appendix Figure 14. Pre- and Post-Filtration Trends in Diarrhea/Enteritis Mortality
******************************************************************************************************************************************
xtreg ln_diarrhea_rate filter_lead5plus filter_lead4 filter_lead3 filter_lead2 zero filter_time0 filter_lag1 filter_lag2 filter_lag3 filter_lag4 filter_lag5plus chlorination water_project sewage_treat_div TB_test bact_standard percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id#c.trend [pweight = pop_ave], fe i(state_city_id) cluster(state_city_id)

estimates store leads_lags

coefplot leads_lags, omitted keep(filter_lead5plus filter_lead4 filter_lead3 filter_lead2 zero ///
filter_time0 filter_lag1 filter_lag2 filter_lag3 filter_lag4 filter_lag5plus) ///
vertical title("{bf:Appendix Figure 14. Pre- and Post-Filtration Trends in Diarrhea/Enteritis Mortality}", color(black) size(medsmall)) ///
xtitle("Years Since Filtration Came Into Effect") xscale(titlegap(2))  xline(5, lcolor(black)) xlabel(, labsize(small)) ///
yline(-.4 -.2 0 .2, lwidth(vvvthin) lpattern(dash) lcolor(black)) ///
note("Notes: OLS coefficient estimates (and their 90% confidence intervals) are reported, where the omitted category" ///
"is 1 year before treatment. The dependent variable is equal to the natural log of the number of diarrhea/enteritis" ///
"deaths per 100,000 population in city {it:c} and year {it:t}. Controls include the demographic characteristics and" ///
"remaining public health interventions listed in Table 5, city fixed effects, year fixed effects, and city-specific linear" ///
"trends. Regressions are weighted by city population. Standard errors are corrected for clustering at the city level.", margin(small)) ///
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) ///
ciopts(recast(rcap) lcolor(black)) level(90) mcolor(black) 

