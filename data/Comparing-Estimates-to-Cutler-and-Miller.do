
*********Set directory and load data set entitled "Regression and Event Study Analyses.dta"*********
/*
use "H:\oldTS1desktop\Clean Water and Pasteurized Milk\Replication Files for AEJ Applied\Regression and Event Study Analyses.dta", clear
*/


**********Merge in the data set from Cutler and Miller from appropriate directory***************
/*
merge 1:1 year state_city_id using "H:\oldTS1desktop\Clean Water and Pasteurized Milk\Cutler and Miller\Culter and Miller Data Set for Merge.dta", keepusing(year state_city_id citynum lnmort lninfmrt percfem percblck percorac percfbrn allmort infmort mort0_1 age0_1 per0_1 per1_4 per5_9 per10_14 per15_19 per20_24 per25_34 per35_44 per45_64 per65up lnmlag1 lnmlag2 lnmlag3 lnmlag4 lnmlag5 filter_from_CM chlwater filtxchl lnpop filwin5 chlwin5  treatsew trchlsew nosewout intake pop_from_CM) generate(_merge_CM)
sort state_city_id year
*/

global demographic 	= "percfem percblck percorac percfbrn per0_1 per1_4 per5_9 per10_14 per15_19 per20_24 per25_34 per35_44 per45_64 per65up"
global lagmort 		= "lnmlag1 lnmlag2 lnmlag3 lnmlag4 lnmlag5"

*Re-creating Cutler and Miller's overall mortality rates that use the correct mortality counts
gen allmort_correct = (mortality*100000)/pop_from_CM
gen lnmort_correct = ln(allmort_correct)

*Re-creating Cutler and Miller's overall mortality rates that use correct mortality counts for period post-1909
gen allmort_correct_v2 = allmort
replace allmort_correct_v2 = (mortality*100000)/pop_from_CM if year > 1909
gen lnmort_correct_v2 = ln(allmort_correct_v2)

*Re-creating Cutler and Miller's infant mortality rates that use the correct infant mortality counts
gen infmort_correct = (mortality_under1*100000)/age0_1
gen lninfmrt_correct = ln(infmort_correct)

*Re-creating Cutler and Miller's mortality lags based on natural log of mortality rates that are only corrected for Memphis 1916 error and also creating lags that use the correct mortality counts post-1909
forvalues i = 1/5 {

	gen lnmlag`i'_correct = lnmlag`i'
	replace lnmlag`i'_correct = . if (state_city_id == 4705 & year == 1916 + `i')
	label var lnmlag`i'_correct "mortality lags that correct for Memphis 1916"

	gen lnmlag`i'_correct_v2 = lnmort_correct_v2[_n-`i']
	replace lnmlag`i'_correct_v2 = . if year <= 1899 + `i'
	label var lnmlag`i'_correct_v2 "mortality lags that correct Memphis and use correct mortality counts for post-1909"
	
}

global lagmort_correct = "lnmlag1_correct lnmlag2_correct lnmlag3_correct lnmlag4_correct lnmlag5_correct"
global lagmort_correct_v2 "lnmlag1_correct_v2 lnmlag2_correct_v2 lnmlag3_correct_v2 lnmlag4_correct_v2 lnmlag5_correct_v2"

*Correcting Cutler and Miller's chlorinate- and filter-within-5-years variables based on our dates
gen filwin5_correct = filwin5
*Louisville filtration
replace filwin5_correct = 1 if state_city_id == 2106 & year == 1904
replace filwin5_correct = 0 if state_city_id == 2106 & year == 1909
*Baltimore filtration
replace filwin5_correct = 0 if state_city_id == 2402 & year == 1909
replace filwin5_correct = 1 if state_city_id == 2402 & year == 1914
*Cleveland filtration
replace filwin5_correct = 0 if state_city_id == 3911 & year == 1912
replace filwin5_correct = 1 if state_city_id == 3911 & year == 1917
*Philadelphia filtration
replace filwin5_correct = 1 if state_city_id == 4254 & (year == 1901 | year == 1902)
replace filwin5_correct = 0 if state_city_id == 4254 & (year == 1906 | year == 1907)

gen chlwin5_correct = chlwin5
*Chicago chlorination
replace chlwin5_correct = 1 if state_city_id == 1711 & (year >= 1907 & year <= 1911)
replace chlwin5_correct = 0 if state_city_id == 1711 & year > 1911
*Louisville chlorination
replace chlwin5_correct = 1 if state_city_id == 2106 & (year == 1908 | year == 1909)
replace chlwin5_correct = 0 if state_city_id == 2106 & (year == 1913 | year == 1914)
*St. Louis chlorination
replace chlwin5_correct = 1 if state_city_id == 2913 & (year >= 1908 & year <= 1912)
replace chlwin5_correct = 0 if state_city_id == 2913 & year > 1912
*Philadelphia chlorination
replace chlwin5_correct = 1 if state_city_id == 4254 & (year == 1905 | year == 1906 | year == 1907)
replace chlwin5_correct = 0 if state_city_id == 4254 & year > 1909
*Pittsburgh chlorination
replace chlwin5_correct = 1 if state_city_id == 4256 & year == 1905
replace chlwin5_correct = 0 if state_city_id == 4256 & year == 1910
*Milwaukee chlorination
replace chlwin5_correct = 1 if state_city_id == 5515 & (year >= 1905 & year <= 1909)
replace chlwin5_correct = 0 if state_city_id == 5515 & year > 1909



*****************************************************************************************************************************************************************
*Table 11. Comparing our Total Mortality Estimates to those of Cutler and Miller (2005)
*****************************************************************************************************************************************************************
*Column (1): Replicating CM's Table 5, Column (2) results 
xi: reg lnmort filter_from_CM chlwater filtxchl lnpop chlwin5 filwin5 $lagmort treatsew trchlsew nosewout intake i.citynum i.year citynum##c.year $demographic, robust
sum allmort if cutler_miller_sample == 1 & (year > 1904 & year < 1937) & allmort != 0

*Column (2): Correct CM's SEs for clustering
xi: reg lnmort filter_from_CM chlwater filtxchl lnpop chlwin5 filwin5 $lagmort treatsew trchlsew nosewout intake i.citynum i.year citynum##c.year $demographic, cluster(citynum)
set seed 93843
boottest {filter_from_CM = 0}, reps(1000)
boottest {chlwater = 0}, reps(1000)
boottest {filtxchl = 0}, reps(1000)
sum allmort if cutler_miller_sample == 1 & (year > 1904 & year < 1937) & allmort != 0

*Column (3): Correct CM's SEs for clustering + Memphis, TN correction
xi: reg lnmort filter_from_CM chlwater filtxchl lnpop chlwin5 filwin5 $lagmort_correct treatsew trchlsew nosewout intake i.citynum i.year citynum##c.year $demographic if year < 1937, cluster(citynum)
set seed 93843
boottest {filter_from_CM = 0}, reps(1000)
boottest {chlwater = 0}, reps(1000)
boottest {filtxchl = 0}, reps(1000)
sum allmort if cutler_miller_sample == 1 & (year > 1904 & year < 1937) & allmort != 0 & (lnmlag1_correct_v2 != . & lnmlag2_correct_v2 != . & lnmlag3_correct_v2 != . & lnmlag4_correct_v2 != . & lnmlag5_correct_v2 != .)

*Column (4): Correct CM's SEs for clustering + Memphis, TN correction + 1910-1917 mortality rates calculated based on imputed pop
xi: reg lnmort_correct_v2 filter_from_CM chlwater filtxchl lnpop chlwin5 filwin5 $lagmort_correct_v2 treatsew trchlsew nosewout intake i.citynum i.year citynum##c.year $demographic if year < 1937, cluster(citynum)
set seed 93843
boottest {filter_from_CM = 0}, reps(1000)
boottest {chlwater = 0}, reps(1000)
boottest {filtxchl = 0}, reps(1000)
sum allmort_correct_v2 if cutler_miller_sample == 1 & (year > 1904 & year < 1937) & allmort != 0 & (lnmlag1_correct_v2 != . & lnmlag2_correct_v2 != . & lnmlag3_correct_v2 != . & lnmlag4_correct_v2 != . & lnmlag5_correct_v2 != .)

*Column (5): Correct CM's SEs for clustering + Memphis, TN correction + 1910-1917 mortality rates calculated based on imputed pop + correct filtration and chlorination dates
xi: reg lnmort_correct_v2 filter chlorination filter_chlorination lnpop chlwin5_correct filwin5_correct $lagmort_correct_v2 treatsew trchlsew nosewout intake i.citynum i.year citynum##c.year $demographic if year < 1937, cluster(citynum)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {filter_chlorination = 0}, reps(1000)
sum allmort_correct_v2 if cutler_miller_sample == 1 & (year > 1904 & year < 1937) & allmort != 0 & (lnmlag1_correct_v2 != . & lnmlag2_correct_v2 != . & lnmlag3_correct_v2 != . & lnmlag4_correct_v2 != . & lnmlag5_correct_v2 != .)

*Column (6): Our specification limited to C&M city-years
xi: reg ln_mortality_rate filter chlorination filter_chlorination water_project sewage_treat_div TB_test bact_standard percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id state_city_id#c.trend [pweight = pop_ave] if cutler_miller_sample == 1 & (year > 1904 & year < 1937), cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {filter_chlorination = 0}, reps(1000)
sum mortality_rate if cutler_miller_sample == 1 & (year > 1904 & year < 1937)



*****************************************************************************************************************************************************************
*Table 12. Comparing our Infant Mortality Estimates to those of Cutler and Miller (2005)
*****************************************************************************************************************************************************************
*Column (1): Replicating CM's Table 5, Column (3) results 
xi: reg lninfmrt filter_from_CM chlwater filtxchl lnpop chlwin5 filwin5 $lagmort treatsew trchlsew nosewout intake i.citynum i.year citynum##c.year $demographic, robust
sum infmort if cutler_miller_sample == 1 & (year > 1904 & year < 1937) & infmort != 0

*Column (2): Correct CM's SEs for clustering
xi: reg lninfmrt filter_from_CM chlwater filtxchl lnpop chlwin5 filwin5 $lagmort treatsew trchlsew nosewout intake i.citynum i.year citynum##c.year $demographic, cluster(citynum)
set seed 93843
boottest {filter_from_CM = 0}, reps(1000)
boottest {chlwater = 0}, reps(1000)
boottest {filtxchl = 0}, reps(1000)
sum infmort if cutler_miller_sample == 1 & (year > 1904 & year < 1937) & infmort != 0

*Column (3): Correct CM's SEs for clustering + Memphis, TN correction
xi: reg lninfmrt filter_from_CM chlwater filtxchl lnpop chlwin5 filwin5 $lagmort_correct treatsew trchlsew nosewout intake i.citynum i.year citynum##c.year $demographic, cluster(citynum)
set seed 93843
boottest {filter_from_CM = 0}, reps(1000)
boottest {chlwater = 0}, reps(1000)
boottest {filtxchl = 0}, reps(1000)
sum infmort if cutler_miller_sample == 1 & (year > 1904 & year < 1937) & infmort != 0 & (lnmlag1_correct_v2 != . & lnmlag2_correct_v2 != . & lnmlag3_correct_v2 != . & lnmlag4_correct_v2 != . & lnmlag5_correct_v2 != .)

*Column (4): Correct CM's SEs for clustering + Memphis, TN correction + correct infant mortality counts
xi: reg lninfmrt_correct filter_from_CM chlwater filtxchl lnpop chlwin5 filwin5 $lagmort_correct treatsew trchlsew nosewout intake i.citynum i.year citynum##c.year $demographic if year < 1937, cluster(citynum)
set seed 93843
boottest {filter_from_CM = 0}, reps(1000)
boottest {chlwater = 0}, reps(1000)
boottest {filtxchl = 0}, reps(1000)
sum infmort_correct if cutler_miller_sample == 1 & (year > 1904 & year < 1937) & infmort != 0 & (lnmlag1_correct_v2 != . & lnmlag2_correct_v2 != . & lnmlag3_correct_v2 != . & lnmlag4_correct_v2 != . & lnmlag5_correct_v2 != .)

*Column (5): Correct CM's SEs for clustering + Memphis, TN correction + correct infant mortality counts + correct filtration and chlorination dates
xi: reg lninfmrt_correct filter chlorination filter_chlorination lnpop chlwin5_correct filwin5_correct $lagmort_correct treatsew trchlsew nosewout intake i.citynum i.year citynum##c.year $demographic if year < 1937, cluster(citynum)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {filter_chlorination = 0}, reps(1000)
sum infmort_correct if cutler_miller_sample == 1 & (year > 1904 & year < 1937) & infmort != 0 & (lnmlag1_correct_v2 != . & lnmlag2_correct_v2 != . & lnmlag3_correct_v2 != . & lnmlag4_correct_v2 != . & lnmlag5_correct_v2 != .)

*Column (6): Our specification limited to C&M city-years
xi: reg ln_mortality_under1_rate filter chlorination filter_chlorination water_project sewage_treat_div TB_test bact_standard percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id state_city_id#c.trend [pweight = pop_ave] if cutler_miller_sample == 1 & (year > 1904 & year < 1937), cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {filter_chlorination = 0}, reps(1000)
sum mortality_under1_rate if cutler_miller_sample == 1 & (year > 1904 & year < 1937)



******************************************************************************************************************************************
*Appendix Table 8. Differences in Recorded Infant Mortality Counts between Cutler and Miller (2005) and Mortality Statistics publications
******************************************************************************************************************************************
list year city mort0_1 mortality_under1 if year < 1937 & cutler_miller_sample == 1 & (mort0_1 != mortality_under1)



***************************************************************************************************************************************************************************************************************************************************************
*For Rejoinder
***************************************************************************************************************************************************************************************************************************************************************
**********Merge in the total mortality rates taking directly from Mortality Statistics for period 1910-1917 that were used by Cutler and Miller (file named "Total Mortality Rate from Mortality Statistics 1910-1917.dta")***************
/*
merge 1:1 year state_city_id using "H:\oldTS1desktop\Clean Water and Pasteurized Milk\Cutler and Miller\Total Mortality Rate from Mortality Statistics 1910-1917.dta"
sort state_city_id year
*/

gen mortality_rate_CM_1017 = mortality_rate
replace mortality_rate_CM_1017 = mortality_rate_CM if (year >= 1910 & year <= 1917)
label var mortality_rate_CM_1017 "replace our mortality rate with mortality rate used by CM for 1910-1917"

gen ln_mortality_rate_CM_1017 = ln(mortality_rate_CM_1017)
label var ln_mortality_rate_CM_1017 "ln(mortality_rate_CM_1017)"

*Change Philadelphia to 1909 for CM filtration date
gen filter_from_CM_v2 = filter_from_CM
replace filter_from_CM_v2 = 0 if (year < 1909 & state_city_id == 4254)
label var filter_from_CM_v2 "=filter_from_CM, but change Philly to turn on in 1909"


*****************************************************************************************************************************************************************
*Table 1. Sensitivity of the Estimated Effect of Filtration on Total Mortality
*****************************************************************************************************************************************************************
*Column (2). Our specification limited to C&M city-years, no controls for other public health interventions, use THEIR filtration and chlorination dates and THEIR mortality rates for 1910-1917
xi: reg ln_mortality_rate_CM_1017 filter_from_CM_v2 chlwater filtxchl percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id state_city_id#c.trend [pweight = pop_ave] if cutler_miller_sample == 1 & (year > 1904 & year < 1937), cluster(state_city_id)
set seed 93843
boottest {filter_from_CM_v2 = 0}, reps(1000)
boottest {chlwater = 0}, reps(1000)
boottest {filtxchl = 0}, reps(1000)

*Column (3). Our specification limited to C&M city-years, but use THEIR filtration and chlorination dates and THEIR mortality rates for 1910-1917
xi: reg ln_mortality_rate_CM_1017 filter_from_CM_v2 chlwater filtxchl water_project sewage_treat_div TB_test bact_standard percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id state_city_id#c.trend [pweight = pop_ave] if cutler_miller_sample == 1 & (year > 1904 & year < 1937), cluster(state_city_id)
set seed 93843
boottest {filter_from_CM_v2 = 0}, reps(1000)
boottest {chlwater = 0}, reps(1000)
boottest {filtxchl = 0}, reps(1000)

*Column (4). Our specification limited to C&M city-years, but use THEIR filtration and chlorination dates and OUR mortality rates for 1910-1917
xi: reg ln_mortality_rate filter_from_CM_v2 chlwater filtxchl water_project sewage_treat_div TB_test bact_standard percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id state_city_id#c.trend [pweight = pop_ave] if cutler_miller_sample == 1 & (year > 1904 & year < 1937), cluster(state_city_id)
set seed 93843
boottest {filter_from_CM_v2 = 0}, reps(1000)
boottest {chlwater = 0}, reps(1000)
boottest {filtxchl = 0}, reps(1000)

*Column (5). Our specification limited to C&M city-years, but use OUR filtration and chlorination dates and OUR mortality rates for 1910-1917
xi: reg ln_mortality_rate filter chlorination filter_chlorination water_project sewage_treat_div TB_test bact_standard percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id state_city_id#c.trend [pweight = pop_ave] if cutler_miller_sample == 1 & (year > 1904 & year < 1937), cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {filter_chlorination = 0}, reps(1000)

*Column (6). Our specification limtited to C&M cities only, but use OUR filtration and chlorination dates and OUR mortality rates for 1910-1917
xi: reg ln_mortality_rate filter chlorination filter_chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id state_city_id#c.trend [pweight = pop_ave] if cutler_miller_sample == 1, cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {filter_chlorination = 0}, reps(1000)

*Column (7). Our full sample and use OUR filtration and chlorination dates and OUR mortality rates for 1910-1917
xi: reg ln_mortality_rate filter chlorination filter_chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus i.year i.state_city_id state_city_id#c.trend [pweight = pop_ave], cluster(state_city_id)
set seed 93843
boottest {filter = 0}, reps(1000)
boottest {chlorination = 0}, reps(1000)
boottest {filter_chlorination = 0}, reps(1000)



*****************************************************************************************************************************************************************
*Table 2. The Estimated Effect of Filtration on Total Mortality: Cutler and Miller (2005) vs. Catillon, Cutler and Getzen (2018)
*****************************************************************************************************************************************************************
*Column (1): Replicating CM, with SEs corrected for clustering
xi: reg lnmort filter_from_CM chlwater filtxchl lnpop chlwin5 filwin5 $lagmort treatsew trchlsew nosewout intake i.citynum i.year citynum##c.year $demographic, cluster(citynum)
set seed 93843
boottest {filter_from_CM = 0}, reps(1000)
boottest {chlwater = 0}, reps(1000)
boottest {filtxchl = 0}, reps(1000)

*Column (2): Correct CM's SEs for clustering + Memphis, TN correction
xi: reg lnmort filter_from_CM chlwater filtxchl lnpop chlwin5 filwin5 $lagmort_correct treatsew trchlsew nosewout intake i.citynum i.year citynum##c.year $demographic if year < 1937, cluster(citynum)
set seed 93843
boottest {filter_from_CM = 0}, reps(1000)
boottest {chlwater = 0}, reps(1000)
boottest {filtxchl = 0}, reps(1000)

*Column (3): Correct CM's SEs for clustering + Memphis, TN correction + dump city trends
xi: reg lnmort filter_from_CM chlwater filtxchl lnpop chlwin5 filwin5 $lagmort_correct treatsew trchlsew nosewout intake i.citynum i.year $demographic if year < 1937, cluster(citynum)
set seed 93843
boottest {filter_from_CM = 0}, reps(1000)
boottest {chlwater = 0}, reps(1000)
boottest {filtxchl = 0}, reps(1000)




