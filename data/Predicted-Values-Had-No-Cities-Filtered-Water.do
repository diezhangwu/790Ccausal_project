
*********Set directory and load data set entitled "Regression and Event Study Analyses.dta"*********
/*
use "H:\oldTS1desktop\Clean Water and Pasteurized Milk\Replication Files for AEJ Applied\Regression and Event Study Analyses.dta", clear
*/


*Create fixed effects
quietly tabulate year, generate(year_FE_)

quietly tabulate state_city_id, generate(city_FE_)


*Create city trends
foreach var of varlist city_FE* {
	gen `var'_trend = `var'*trend
}



*Unweighted means for comparison to predicted values
forvalues i = 1900/1940 {

	sum mortality_under1_rate if year == `i'
	gen mortality_under1_mean_`i' = r(mean) 

	sum typhoid_rate if year == `i'
	gen typhoid_mean_`i' = r(mean) 

	sum diarrhea_rate if year == `i'
	gen diarrhea_mean_`i' = r(mean) 

}

drop diarrhea_mean_1939 diarrhea_mean_1940

order mortality_under1_mean_1901 mortality_under1_mean_1902 mortality_under1_mean_1903 mortality_under1_mean_1904 mortality_under1_mean_1905 mortality_under1_mean_1906 mortality_under1_mean_1907 ///
mortality_under1_mean_1908 mortality_under1_mean_1909 mortality_under1_mean_1910 mortality_under1_mean_1911 mortality_under1_mean_1912 mortality_under1_mean_1913 mortality_under1_mean_1914 ///
mortality_under1_mean_1915 mortality_under1_mean_1916 mortality_under1_mean_1917 mortality_under1_mean_1918 mortality_under1_mean_1919 mortality_under1_mean_1920 mortality_under1_mean_1921 ///
mortality_under1_mean_1922 mortality_under1_mean_1923 mortality_under1_mean_1924 mortality_under1_mean_1925 mortality_under1_mean_1926 mortality_under1_mean_1927 mortality_under1_mean_1928 ///
mortality_under1_mean_1929 mortality_under1_mean_1930 mortality_under1_mean_1931 mortality_under1_mean_1932 mortality_under1_mean_1933 mortality_under1_mean_1934 mortality_under1_mean_1935 ///
mortality_under1_mean_1936 mortality_under1_mean_1937 mortality_under1_mean_1938 mortality_under1_mean_1939 mortality_under1_mean_1940, after(mortality_under1_mean_1900)

order typhoid_mean_1901 typhoid_mean_1902 typhoid_mean_1903 typhoid_mean_1904 typhoid_mean_1905 typhoid_mean_1906 typhoid_mean_1907 ///
typhoid_mean_1908 typhoid_mean_1909 typhoid_mean_1910 typhoid_mean_1911 typhoid_mean_1912 typhoid_mean_1913 typhoid_mean_1914 ///
typhoid_mean_1915 typhoid_mean_1916 typhoid_mean_1917 typhoid_mean_1918 typhoid_mean_1919 typhoid_mean_1920 typhoid_mean_1921 ///
typhoid_mean_1922 typhoid_mean_1923 typhoid_mean_1924 typhoid_mean_1925 typhoid_mean_1926 typhoid_mean_1927 typhoid_mean_1928 ///
typhoid_mean_1929 typhoid_mean_1930 typhoid_mean_1931 typhoid_mean_1932 typhoid_mean_1933 typhoid_mean_1934 typhoid_mean_1935 ///
typhoid_mean_1936 typhoid_mean_1937 typhoid_mean_1938 typhoid_mean_1939 typhoid_mean_1940, after(typhoid_mean_1900)

order diarrhea_mean_1901 diarrhea_mean_1902 diarrhea_mean_1903 diarrhea_mean_1904 diarrhea_mean_1905 diarrhea_mean_1906 diarrhea_mean_1907 ///
diarrhea_mean_1908 diarrhea_mean_1909 diarrhea_mean_1910 diarrhea_mean_1911 diarrhea_mean_1912 diarrhea_mean_1913 diarrhea_mean_1914 ///
diarrhea_mean_1915 diarrhea_mean_1916 diarrhea_mean_1917 diarrhea_mean_1918 diarrhea_mean_1919 diarrhea_mean_1920 diarrhea_mean_1921 ///
diarrhea_mean_1922 diarrhea_mean_1923 diarrhea_mean_1924 diarrhea_mean_1925 diarrhea_mean_1926 diarrhea_mean_1927 diarrhea_mean_1928 ///
diarrhea_mean_1929 diarrhea_mean_1930 diarrhea_mean_1931 diarrhea_mean_1932 diarrhea_mean_1933 diarrhea_mean_1934 diarrhea_mean_1935 ///
diarrhea_mean_1936 diarrhea_mean_1937 diarrhea_mean_1938, after(diarrhea_mean_1900)


*Declare globals (note: I'm intentionally leaving out variables from the list that would end up being omitted from the regression due to collinearity)
*run these regressions to observe which fixed effects are omitted
reg mortality_under1_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus year_FE* city_FE* [pweight = pop_ave], cluster(state_city_id)
reg typhoid_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus year_FE* city_FE* [pweight = pop_ave], cluster(state_city_id)
reg diarrhea_rate filter chlorination water_project sewage_treat_div bact_standard TB_test percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus year_FE* city_FE* [pweight = pop_ave], cluster(state_city_id)

global demographics "percent_female percent_nonwhite percent_foreign percent_age_less15 percent_age_15to44 percent_age_45plus"
global policy_vars "filter chlorination water_project sewage_treat_div bact_standard TB_test"
global year_FE "year_FE_2 year_FE_3 year_FE_4 year_FE_5 year_FE_6 year_FE_7 year_FE_8 year_FE_9 year_FE_10 year_FE_11 year_FE_12 year_FE_13 year_FE_14 year_FE_15 year_FE_16 year_FE_17 year_FE_18 year_FE_19 year_FE_20 year_FE_21 year_FE_22 year_FE_23 year_FE_24 year_FE_25 year_FE_26 year_FE_27 year_FE_28 year_FE_29 year_FE_30 year_FE_31 year_FE_32 year_FE_33 year_FE_34 year_FE_35 year_FE_36 year_FE_37 year_FE_38 year_FE_39 year_FE_40"
global year_FE_diarrhea "year_FE_2 year_FE_3 year_FE_4 year_FE_5 year_FE_6 year_FE_7 year_FE_8 year_FE_9 year_FE_10 year_FE_11 year_FE_12 year_FE_13 year_FE_14 year_FE_15 year_FE_16 year_FE_17 year_FE_18 year_FE_19 year_FE_20 year_FE_21 year_FE_22 year_FE_23 year_FE_24 year_FE_25 year_FE_26 year_FE_27 year_FE_28 year_FE_29 year_FE_30 year_FE_31 year_FE_32 year_FE_33 year_FE_34 year_FE_35 year_FE_36 year_FE_37 year_FE_38"
global city_FE "city_FE_1 city_FE_2 city_FE_3 city_FE_4 city_FE_5 city_FE_6 city_FE_7 city_FE_8 city_FE_9 city_FE_10 city_FE_11 city_FE_12 city_FE_13 city_FE_14 city_FE_15 city_FE_16 city_FE_17 city_FE_18 city_FE_19 city_FE_20 city_FE_21 city_FE_22 city_FE_24 city_FE_25"
global city_trends "city_FE_1_trend city_FE_2_trend city_FE_3_trend city_FE_4_trend city_FE_5_trend city_FE_6_trend city_FE_7_trend city_FE_8_trend city_FE_9_trend city_FE_10_trend city_FE_11_trend city_FE_12_trend city_FE_13_trend city_FE_14_trend city_FE_15_trend city_FE_16_trend city_FE_17_trend city_FE_18_trend city_FE_19_trend city_FE_20_trend city_FE_21_trend city_FE_22_trend city_FE_23_trend city_FE_24_trend city_FE_25_trend"

sort year state_city_id


*Placeholders for means
set obs 1940

*City demographics
foreach var of global demographics {

	quietly gen `var'_means = .

}

forvalues j = 1900/1940 {
	foreach var of global demographics {
	
	quietly sum `var' if year == `j'
	quietly replace `var'_means = r(mean) in `j'
	
	}

}

*policy vars
foreach var of global policy_vars {

	quietly gen `var'_means = .
	
}

forvalues j = 1900/1940 {
	foreach var of global policy_vars {
	
		quietly sum `var' if year == `j'
		quietly replace `var'_means = r(mean) in `j'
		
	}
}	

*city trends
forvalues i = 1900/1940 {

	quietly gen city_trends_means_`i' = .
	
}

forvalues j = 1900/1940 {
	forvalues i = 1/25 {
	
		quietly sum city_FE_`i'_trend if year == `j'
		quietly replace city_trends_means_`j' = r(mean) in `i'
		
	}
}




*Run regressions for each year separately (copying and pasting means calculated from above)


*************
*year = 1900
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.04 sewage_treat_div=0 TB_test=.04 bact_standard=0 percent_female=.5053051 percent_nonwhite=.0828622 percent_foreign=.2406604 ///
percent_age_less15=.2911488 percent_age_15to44=.5340786 percent_age_45plus=.1747726 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.04 city_FE_2_trend=.04 city_FE_3_trend=.04 city_FE_4_trend=.04 city_FE_5_trend=.04 city_FE_6_trend=.04 ///
city_FE_7_trend=.04 city_FE_8_trend=.04 city_FE_9_trend=.04 city_FE_10_trend=.04 city_FE_11_trend=.04 city_FE_12_trend=.04 city_FE_13_trend=.04 city_FE_14_trend=.04 ///
city_FE_15_trend=.04 city_FE_16_trend=.04 city_FE_17_trend=.04 city_FE_18_trend=.04 city_FE_19_trend=.04 city_FE_20_trend=.04 city_FE_21_trend=.04 city_FE_22_trend=.04 ///
city_FE_23_trend=.04 city_FE_24_trend=.04 city_FE_25_trend=.04) ///
level(90) post

gen mortality_under1_pred_1900 = _b[_cons]
gen mortality_under1_lb_1900 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1900 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1900 mortality_under1_lb_1900 mortality_under1_ub_1900, after(mortality_under1_mean_1900)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.04 sewage_treat_div=0 TB_test=.04 bact_standard=0 percent_female=.5053051 percent_nonwhite=.0828622 percent_foreign=.2406604 ///
percent_age_less15=.2911488 percent_age_15to44=.5340786 percent_age_45plus=.1747726 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.04 city_FE_2_trend=.04 city_FE_3_trend=.04 city_FE_4_trend=.04 city_FE_5_trend=.04 city_FE_6_trend=.04 ///
city_FE_7_trend=.04 city_FE_8_trend=.04 city_FE_9_trend=.04 city_FE_10_trend=.04 city_FE_11_trend=.04 city_FE_12_trend=.04 city_FE_13_trend=.04 city_FE_14_trend=.04 ///
city_FE_15_trend=.04 city_FE_16_trend=.04 city_FE_17_trend=.04 city_FE_18_trend=.04 city_FE_19_trend=.04 city_FE_20_trend=.04 city_FE_21_trend=.04 city_FE_22_trend=.04 ///
city_FE_23_trend=.04 city_FE_24_trend=.04 city_FE_25_trend=.04) ///
level(90) post

gen typhoid_pred_1900 = _b[_cons]
gen typhoid_lb_1900 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1900 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1900 typhoid_lb_1900 typhoid_ub_1900, after(typhoid_mean_1900)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.04 sewage_treat_div=0 TB_test=.04 bact_standard=0 percent_female=.5053051 percent_nonwhite=.0828622 percent_foreign=.2406604 ///
percent_age_less15=.2911488 percent_age_15to44=.5340786 percent_age_45plus=.1747726 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.04 city_FE_2_trend=.04 city_FE_3_trend=.04 city_FE_4_trend=.04 city_FE_5_trend=.04 city_FE_6_trend=.04 ///
city_FE_7_trend=.04 city_FE_8_trend=.04 city_FE_9_trend=.04 city_FE_10_trend=.04 city_FE_11_trend=.04 city_FE_12_trend=.04 city_FE_13_trend=.04 city_FE_14_trend=.04 ///
city_FE_15_trend=.04 city_FE_16_trend=.04 city_FE_17_trend=.04 city_FE_18_trend=.04 city_FE_19_trend=.04 city_FE_20_trend=.04 city_FE_21_trend=.04 city_FE_22_trend=.04 ///
city_FE_23_trend=.04 city_FE_24_trend=.04 city_FE_25_trend=.04) ///
level(90) post

gen diarrhea_pred_1900 = _b[_cons]
gen diarrhea_lb_1900 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1900 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1900 diarrhea_lb_1900 diarrhea_ub_1900, after(diarrhea_mean_1900)



*************
*year = 1901
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.04 sewage_treat_div=.04 TB_test=.04 bact_standard=0 percent_female=.5044106 percent_nonwhite=.0827339 percent_foreign=.2403841 ///
percent_age_less15=.2880048 percent_age_15to44=.5357047 percent_age_45plus=.1762905 year_FE_2=1 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.08 city_FE_2_trend=.08 city_FE_3_trend=.08 city_FE_4_trend=.08 city_FE_5_trend=.08 city_FE_6_trend=.08 ///
city_FE_7_trend=.08 city_FE_8_trend=.08 city_FE_9_trend=.08 city_FE_10_trend=.08 city_FE_11_trend=.08 city_FE_12_trend=.08 city_FE_13_trend=.08 city_FE_14_trend=.08 ///
city_FE_15_trend=.08 city_FE_16_trend=.08 city_FE_17_trend=.08 city_FE_18_trend=.08 city_FE_19_trend=.08 city_FE_20_trend=.08 city_FE_21_trend=.08 city_FE_22_trend=.08 ///
city_FE_23_trend=.08 city_FE_24_trend=.08 city_FE_25_trend=.08) ///
level(90) post

gen mortality_under1_pred_1901 = _b[_cons]
gen mortality_under1_lb_1901 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1901 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1901 mortality_under1_lb_1901 mortality_under1_ub_1901, after(mortality_under1_mean_1901)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.04 sewage_treat_div=.04 TB_test=.04 bact_standard=0 percent_female=.5044106 percent_nonwhite=.0827339 percent_foreign=.2403841 ///
percent_age_less15=.2880048 percent_age_15to44=.5357047 percent_age_45plus=.1762905 year_FE_2=1 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.08 city_FE_2_trend=.08 city_FE_3_trend=.08 city_FE_4_trend=.08 city_FE_5_trend=.08 city_FE_6_trend=.08 ///
city_FE_7_trend=.08 city_FE_8_trend=.08 city_FE_9_trend=.08 city_FE_10_trend=.08 city_FE_11_trend=.08 city_FE_12_trend=.08 city_FE_13_trend=.08 city_FE_14_trend=.08 ///
city_FE_15_trend=.08 city_FE_16_trend=.08 city_FE_17_trend=.08 city_FE_18_trend=.08 city_FE_19_trend=.08 city_FE_20_trend=.08 city_FE_21_trend=.08 city_FE_22_trend=.08 ///
city_FE_23_trend=.08 city_FE_24_trend=.08 city_FE_25_trend=.08) ///
level(90) post

gen typhoid_pred_1901 = _b[_cons]
gen typhoid_lb_1901 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1901 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1901 typhoid_lb_1901 typhoid_ub_1901, after(typhoid_mean_1901)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.04 sewage_treat_div=.04 TB_test=.04 bact_standard=0 percent_female=.5044106 percent_nonwhite=.0827339 percent_foreign=.2403841 ///
percent_age_less15=.2880048 percent_age_15to44=.5357047 percent_age_45plus=.1762905 year_FE_2=1 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.08 city_FE_2_trend=.08 city_FE_3_trend=.08 city_FE_4_trend=.08 city_FE_5_trend=.08 city_FE_6_trend=.08 ///
city_FE_7_trend=.08 city_FE_8_trend=.08 city_FE_9_trend=.08 city_FE_10_trend=.08 city_FE_11_trend=.08 city_FE_12_trend=.08 city_FE_13_trend=.08 city_FE_14_trend=.08 ///
city_FE_15_trend=.08 city_FE_16_trend=.08 city_FE_17_trend=.08 city_FE_18_trend=.08 city_FE_19_trend=.08 city_FE_20_trend=.08 city_FE_21_trend=.08 city_FE_22_trend=.08 ///
city_FE_23_trend=.08 city_FE_24_trend=.08 city_FE_25_trend=.08) ///
level(90) post

gen diarrhea_pred_1901 = _b[_cons]
gen diarrhea_lb_1901 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1901 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1901 diarrhea_lb_1901 diarrhea_ub_1901, after(diarrhea_mean_1901)


*************
*year = 1902
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.04 sewage_treat_div=.04 TB_test=.04 bact_standard=0 percent_female=.503516 percent_nonwhite=.0826057 percent_foreign=.2401079 ///
percent_age_less15=.2848608 percent_age_15to44=.5373309 percent_age_45plus=.1778084 year_FE_2=0 year_FE_3=1 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.12 city_FE_2_trend=.12 city_FE_3_trend=.12 city_FE_4_trend=.12 city_FE_5_trend=.12 city_FE_6_trend=.12 ///
city_FE_7_trend=.12 city_FE_8_trend=.12 city_FE_9_trend=.12 city_FE_10_trend=.12 city_FE_11_trend=.12 city_FE_12_trend=.12 city_FE_13_trend=.12 city_FE_14_trend=.12 ///
city_FE_15_trend=.12 city_FE_16_trend=.12 city_FE_17_trend=.12 city_FE_18_trend=.12 city_FE_19_trend=.12 city_FE_20_trend=.12 city_FE_21_trend=.12 city_FE_22_trend=.12 ///
city_FE_23_trend=.12 city_FE_24_trend=.12 city_FE_25_trend=.12) ///
level(90) post

gen mortality_under1_pred_1902 = _b[_cons]
gen mortality_under1_lb_1902 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1902 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1902 mortality_under1_lb_1902 mortality_under1_ub_1902, after(mortality_under1_mean_1902)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.04 sewage_treat_div=.04 TB_test=.04 bact_standard=0 percent_female=.503516 percent_nonwhite=.0826057 percent_foreign=.2401079 ///
percent_age_less15=.2848608 percent_age_15to44=.5373309 percent_age_45plus=.1778084 year_FE_2=0 year_FE_3=1 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.12 city_FE_2_trend=.12 city_FE_3_trend=.12 city_FE_4_trend=.12 city_FE_5_trend=.12 city_FE_6_trend=.12 ///
city_FE_7_trend=.12 city_FE_8_trend=.12 city_FE_9_trend=.12 city_FE_10_trend=.12 city_FE_11_trend=.12 city_FE_12_trend=.12 city_FE_13_trend=.12 city_FE_14_trend=.12 ///
city_FE_15_trend=.12 city_FE_16_trend=.12 city_FE_17_trend=.12 city_FE_18_trend=.12 city_FE_19_trend=.12 city_FE_20_trend=.12 city_FE_21_trend=.12 city_FE_22_trend=.12 ///
city_FE_23_trend=.12 city_FE_24_trend=.12 city_FE_25_trend=.12) ///
level(90) post

gen typhoid_pred_1902 = _b[_cons]
gen typhoid_lb_1902 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1902 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1902 typhoid_lb_1902 typhoid_ub_1902, after(typhoid_mean_1902)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.04 sewage_treat_div=.04 TB_test=.04 bact_standard=0 percent_female=.503516 percent_nonwhite=.0826057 percent_foreign=.2401079 ///
percent_age_less15=.2848608 percent_age_15to44=.5373309 percent_age_45plus=.1778084 year_FE_2=0 year_FE_3=1 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.12 city_FE_2_trend=.12 city_FE_3_trend=.12 city_FE_4_trend=.12 city_FE_5_trend=.12 city_FE_6_trend=.12 ///
city_FE_7_trend=.12 city_FE_8_trend=.12 city_FE_9_trend=.12 city_FE_10_trend=.12 city_FE_11_trend=.12 city_FE_12_trend=.12 city_FE_13_trend=.12 city_FE_14_trend=.12 ///
city_FE_15_trend=.12 city_FE_16_trend=.12 city_FE_17_trend=.12 city_FE_18_trend=.12 city_FE_19_trend=.12 city_FE_20_trend=.12 city_FE_21_trend=.12 city_FE_22_trend=.12 ///
city_FE_23_trend=.12 city_FE_24_trend=.12 city_FE_25_trend=.12) ///
level(90) post

gen diarrhea_pred_1902 = _b[_cons]
gen diarrhea_lb_1902 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1902 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1902 diarrhea_lb_1902 diarrhea_ub_1902, after(diarrhea_mean_1902)



*************
*year = 1903
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.04 sewage_treat_div=.04 TB_test=.04 bact_standard=0 percent_female=.5026214 percent_nonwhite=.0824774 percent_foreign=.2398316 ///
percent_age_less15=.2817168 percent_age_15to44=.5389569 percent_age_45plus=.1793263 year_FE_2=0 year_FE_3=0 year_FE_4=1 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.16 city_FE_2_trend=.16 city_FE_3_trend=.16 city_FE_4_trend=.16 city_FE_5_trend=.16 city_FE_6_trend=.16 ///
city_FE_7_trend=.16 city_FE_8_trend=.16 city_FE_9_trend=.16 city_FE_10_trend=.16 city_FE_11_trend=.16 city_FE_12_trend=.16 city_FE_13_trend=.16 city_FE_14_trend=.16 ///
city_FE_15_trend=.16 city_FE_16_trend=.16 city_FE_17_trend=.16 city_FE_18_trend=.16 city_FE_19_trend=.16 city_FE_20_trend=.16 city_FE_21_trend=.16 city_FE_22_trend=.16 ///
city_FE_23_trend=.16 city_FE_24_trend=.16 city_FE_25_trend=.16) ///
level(90) post

gen mortality_under1_pred_1903 = _b[_cons]
gen mortality_under1_lb_1903 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1903 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1903 mortality_under1_lb_1903 mortality_under1_ub_1903, after(mortality_under1_mean_1903)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.04 sewage_treat_div=.04 TB_test=.04 bact_standard=0 percent_female=.5026214 percent_nonwhite=.0824774 percent_foreign=.2398316 ///
percent_age_less15=.2817168 percent_age_15to44=.5389569 percent_age_45plus=.1793263 year_FE_2=0 year_FE_3=0 year_FE_4=1 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.16 city_FE_2_trend=.16 city_FE_3_trend=.16 city_FE_4_trend=.16 city_FE_5_trend=.16 city_FE_6_trend=.16 ///
city_FE_7_trend=.16 city_FE_8_trend=.16 city_FE_9_trend=.16 city_FE_10_trend=.16 city_FE_11_trend=.16 city_FE_12_trend=.16 city_FE_13_trend=.16 city_FE_14_trend=.16 ///
city_FE_15_trend=.16 city_FE_16_trend=.16 city_FE_17_trend=.16 city_FE_18_trend=.16 city_FE_19_trend=.16 city_FE_20_trend=.16 city_FE_21_trend=.16 city_FE_22_trend=.16 ///
city_FE_23_trend=.16 city_FE_24_trend=.16 city_FE_25_trend=.16) ///
level(90) post

gen typhoid_pred_1903 = _b[_cons]
gen typhoid_lb_1903 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1903 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1903 typhoid_lb_1903 typhoid_ub_1903, after(typhoid_mean_1903)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.04 sewage_treat_div=.04 TB_test=.04 bact_standard=0 percent_female=.5026214 percent_nonwhite=.0824774 percent_foreign=.2398316 ///
percent_age_less15=.2817168 percent_age_15to44=.5389569 percent_age_45plus=.1793263 year_FE_2=0 year_FE_3=0 year_FE_4=1 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.16 city_FE_2_trend=.16 city_FE_3_trend=.16 city_FE_4_trend=.16 city_FE_5_trend=.16 city_FE_6_trend=.16 ///
city_FE_7_trend=.16 city_FE_8_trend=.16 city_FE_9_trend=.16 city_FE_10_trend=.16 city_FE_11_trend=.16 city_FE_12_trend=.16 city_FE_13_trend=.16 city_FE_14_trend=.16 ///
city_FE_15_trend=.16 city_FE_16_trend=.16 city_FE_17_trend=.16 city_FE_18_trend=.16 city_FE_19_trend=.16 city_FE_20_trend=.16 city_FE_21_trend=.16 city_FE_22_trend=.16 ///
city_FE_23_trend=.16 city_FE_24_trend=.16 city_FE_25_trend=.16) ///
level(90) post

gen diarrhea_pred_1903 = _b[_cons]
gen diarrhea_lb_1903 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1903 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1903 diarrhea_lb_1903 diarrhea_ub_1903, after(diarrhea_mean_1903)




*************
*year = 1904
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.09384 sewage_treat_div=.04 TB_test=.04 bact_standard=0 percent_female=.5017269 percent_nonwhite=.0823491 percent_foreign=.2395554 ///
percent_age_less15=.2785727 percent_age_15to44=.5405831 percent_age_45plus=.1808442 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=1 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.20 city_FE_2_trend=.20 city_FE_3_trend=.20 city_FE_4_trend=.20 city_FE_5_trend=.20 city_FE_6_trend=.20 ///
city_FE_7_trend=.20 city_FE_8_trend=.20 city_FE_9_trend=.20 city_FE_10_trend=.20 city_FE_11_trend=.20 city_FE_12_trend=.20 city_FE_13_trend=.20 city_FE_14_trend=.20 ///
city_FE_15_trend=.20 city_FE_16_trend=.20 city_FE_17_trend=.20 city_FE_18_trend=.20 city_FE_19_trend=.20 city_FE_20_trend=.20 city_FE_21_trend=.20 city_FE_22_trend=.20 ///
city_FE_23_trend=.20 city_FE_24_trend=.20 city_FE_25_trend=.20) ///
level(90) post

gen mortality_under1_pred_1904 = _b[_cons]
gen mortality_under1_lb_1904 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1904 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1904 mortality_under1_lb_1904 mortality_under1_ub_1904, after(mortality_under1_mean_1904)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.09384 sewage_treat_div=.04 TB_test=.04 bact_standard=0 percent_female=.5017269 percent_nonwhite=.0823491 percent_foreign=.2395554 ///
percent_age_less15=.2785727 percent_age_15to44=.5405831 percent_age_45plus=.1808442 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=1 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.20 city_FE_2_trend=.20 city_FE_3_trend=.20 city_FE_4_trend=.20 city_FE_5_trend=.20 city_FE_6_trend=.20 ///
city_FE_7_trend=.20 city_FE_8_trend=.20 city_FE_9_trend=.20 city_FE_10_trend=.20 city_FE_11_trend=.20 city_FE_12_trend=.20 city_FE_13_trend=.20 city_FE_14_trend=.20 ///
city_FE_15_trend=.20 city_FE_16_trend=.20 city_FE_17_trend=.20 city_FE_18_trend=.20 city_FE_19_trend=.20 city_FE_20_trend=.20 city_FE_21_trend=.20 city_FE_22_trend=.20 ///
city_FE_23_trend=.20 city_FE_24_trend=.20 city_FE_25_trend=.20) ///
level(90) post

gen typhoid_pred_1904 = _b[_cons]
gen typhoid_lb_1904 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1904 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1904 typhoid_lb_1904 typhoid_ub_1904, after(typhoid_mean_1904)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.09384 sewage_treat_div=.04 TB_test=.04 bact_standard=0 percent_female=.5017269 percent_nonwhite=.0823491 percent_foreign=.2395554 ///
percent_age_less15=.2785727 percent_age_15to44=.5405831 percent_age_45plus=.1808442 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=1 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.20 city_FE_2_trend=.20 city_FE_3_trend=.20 city_FE_4_trend=.20 city_FE_5_trend=.20 city_FE_6_trend=.20 ///
city_FE_7_trend=.20 city_FE_8_trend=.20 city_FE_9_trend=.20 city_FE_10_trend=.20 city_FE_11_trend=.20 city_FE_12_trend=.20 city_FE_13_trend=.20 city_FE_14_trend=.20 ///
city_FE_15_trend=.20 city_FE_16_trend=.20 city_FE_17_trend=.20 city_FE_18_trend=.20 city_FE_19_trend=.20 city_FE_20_trend=.20 city_FE_21_trend=.20 city_FE_22_trend=.20 ///
city_FE_23_trend=.20 city_FE_24_trend=.20 city_FE_25_trend=.20) ///
level(90) post

gen diarrhea_pred_1904 = _b[_cons]
gen diarrhea_lb_1904 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1904 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1904 diarrhea_lb_1904 diarrhea_ub_1904, after(diarrhea_mean_1904)



*************
*year = 1905
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.16 sewage_treat_div=.04 TB_test=.04 bact_standard=.03332 percent_female=.5008323 percent_nonwhite=.0822208 percent_foreign=.2392792 ///
percent_age_less15=.2754287 percent_age_15to44=.5422092 percent_age_45plus=.1823621 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=1 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.24 city_FE_2_trend=.24 city_FE_3_trend=.24 city_FE_4_trend=.24 city_FE_5_trend=.24 city_FE_6_trend=.24 ///
city_FE_7_trend=.24 city_FE_8_trend=.24 city_FE_9_trend=.24 city_FE_10_trend=.24 city_FE_11_trend=.24 city_FE_12_trend=.24 city_FE_13_trend=.24 city_FE_14_trend=.24 ///
city_FE_15_trend=.24 city_FE_16_trend=.24 city_FE_17_trend=.24 city_FE_18_trend=.24 city_FE_19_trend=.24 city_FE_20_trend=.24 city_FE_21_trend=.24 city_FE_22_trend=.24 ///
city_FE_23_trend=.24 city_FE_24_trend=.24 city_FE_25_trend=.24) ///
level(90) post

gen mortality_under1_pred_1905 = _b[_cons]
gen mortality_under1_lb_1905 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1905 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1905 mortality_under1_lb_1905 mortality_under1_ub_1905, after(mortality_under1_mean_1905)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.16 sewage_treat_div=.04 TB_test=.04 bact_standard=.03332 percent_female=.5008323 percent_nonwhite=.0822208 percent_foreign=.2392792 ///
percent_age_less15=.2754287 percent_age_15to44=.5422092 percent_age_45plus=.1823621 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=1 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.24 city_FE_2_trend=.24 city_FE_3_trend=.24 city_FE_4_trend=.24 city_FE_5_trend=.24 city_FE_6_trend=.24 ///
city_FE_7_trend=.24 city_FE_8_trend=.24 city_FE_9_trend=.24 city_FE_10_trend=.24 city_FE_11_trend=.24 city_FE_12_trend=.24 city_FE_13_trend=.24 city_FE_14_trend=.24 ///
city_FE_15_trend=.24 city_FE_16_trend=.24 city_FE_17_trend=.24 city_FE_18_trend=.24 city_FE_19_trend=.24 city_FE_20_trend=.24 city_FE_21_trend=.24 city_FE_22_trend=.24 ///
city_FE_23_trend=.24 city_FE_24_trend=.24 city_FE_25_trend=.24) ///
level(90) post

gen typhoid_pred_1905 = _b[_cons]
gen typhoid_lb_1905 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1905 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1905 typhoid_lb_1905 typhoid_ub_1905, after(typhoid_mean_1905)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.16 sewage_treat_div=.04 TB_test=.04 bact_standard=.03332 percent_female=.5008323 percent_nonwhite=.0822208 percent_foreign=.2392792 ///
percent_age_less15=.2754287 percent_age_15to44=.5422092 percent_age_45plus=.1823621 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=1 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.24 city_FE_2_trend=.24 city_FE_3_trend=.24 city_FE_4_trend=.24 city_FE_5_trend=.24 city_FE_6_trend=.24 ///
city_FE_7_trend=.24 city_FE_8_trend=.24 city_FE_9_trend=.24 city_FE_10_trend=.24 city_FE_11_trend=.24 city_FE_12_trend=.24 city_FE_13_trend=.24 city_FE_14_trend=.24 ///
city_FE_15_trend=.24 city_FE_16_trend=.24 city_FE_17_trend=.24 city_FE_18_trend=.24 city_FE_19_trend=.24 city_FE_20_trend=.24 city_FE_21_trend=.24 city_FE_22_trend=.24 ///
city_FE_23_trend=.24 city_FE_24_trend=.24 city_FE_25_trend=.24) ///
level(90) post

gen diarrhea_pred_1905 = _b[_cons]
gen diarrhea_lb_1905 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1905 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1905 diarrhea_lb_1905 diarrhea_ub_1905, after(diarrhea_mean_1905)



*************
*year = 1906
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.16 sewage_treat_div=.04 TB_test=.08 bact_standard=.08 percent_female=.4999377 percent_nonwhite=.0820926 percent_foreign=.2390029 ///
percent_age_less15=.2722847 percent_age_15to44=.543853 percent_age_45plus=.18388 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=1 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.28 city_FE_2_trend=.28 city_FE_3_trend=.28 city_FE_4_trend=.28 city_FE_5_trend=.28 city_FE_6_trend=.28 ///
city_FE_7_trend=.28 city_FE_8_trend=.28 city_FE_9_trend=.28 city_FE_10_trend=.28 city_FE_11_trend=.28 city_FE_12_trend=.28 city_FE_13_trend=.28 city_FE_14_trend=.28 ///
city_FE_15_trend=.28 city_FE_16_trend=.28 city_FE_17_trend=.28 city_FE_18_trend=.28 city_FE_19_trend=.28 city_FE_20_trend=.28 city_FE_21_trend=.28 city_FE_22_trend=.28 ///
city_FE_23_trend=.28 city_FE_24_trend=.28 city_FE_25_trend=.28) ///
level(90) post

gen mortality_under1_pred_1906 = _b[_cons]
gen mortality_under1_lb_1906 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1906 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1906 mortality_under1_lb_1906 mortality_under1_ub_1906, after(mortality_under1_mean_1906)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.16 sewage_treat_div=.04 TB_test=.08 bact_standard=.08 percent_female=.4999377 percent_nonwhite=.0820926 percent_foreign=.2390029 ///
percent_age_less15=.2722847 percent_age_15to44=.543853 percent_age_45plus=.18388 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=1 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.28 city_FE_2_trend=.28 city_FE_3_trend=.28 city_FE_4_trend=.28 city_FE_5_trend=.28 city_FE_6_trend=.28 ///
city_FE_7_trend=.28 city_FE_8_trend=.28 city_FE_9_trend=.28 city_FE_10_trend=.28 city_FE_11_trend=.28 city_FE_12_trend=.28 city_FE_13_trend=.28 city_FE_14_trend=.28 ///
city_FE_15_trend=.28 city_FE_16_trend=.28 city_FE_17_trend=.28 city_FE_18_trend=.28 city_FE_19_trend=.28 city_FE_20_trend=.28 city_FE_21_trend=.28 city_FE_22_trend=.28 ///
city_FE_23_trend=.28 city_FE_24_trend=.28 city_FE_25_trend=.28) ///
level(90) post

gen typhoid_pred_1906 = _b[_cons]
gen typhoid_lb_1906 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1906 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1906 typhoid_lb_1906 typhoid_ub_1906, after(typhoid_mean_1906)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.16 sewage_treat_div=.04 TB_test=.08 bact_standard=.08 percent_female=.4999377 percent_nonwhite=.0820926 percent_foreign=.2390029 ///
percent_age_less15=.2722847 percent_age_15to44=.543853 percent_age_45plus=.18388 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=1 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.28 city_FE_2_trend=.28 city_FE_3_trend=.28 city_FE_4_trend=.28 city_FE_5_trend=.28 city_FE_6_trend=.28 ///
city_FE_7_trend=.28 city_FE_8_trend=.28 city_FE_9_trend=.28 city_FE_10_trend=.28 city_FE_11_trend=.28 city_FE_12_trend=.28 city_FE_13_trend=.28 city_FE_14_trend=.28 ///
city_FE_15_trend=.28 city_FE_16_trend=.28 city_FE_17_trend=.28 city_FE_18_trend=.28 city_FE_19_trend=.28 city_FE_20_trend=.28 city_FE_21_trend=.28 city_FE_22_trend=.28 ///
city_FE_23_trend=.28 city_FE_24_trend=.28 city_FE_25_trend=.28) ///
level(90) post

gen diarrhea_pred_1906 = _b[_cons]
gen diarrhea_lb_1906 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1906 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1906 diarrhea_lb_1906 diarrhea_ub_1906, after(diarrhea_mean_1906)


*************
*year = 1907
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.16604 sewage_treat_div=.08 TB_test=.1576 bact_standard=.1688 percent_female=.4990431 percent_nonwhite=.0819643 percent_foreign=.2387267 ///
percent_age_less15=.2691407 percent_age_15to44=.5454614 percent_age_45plus=.1853979 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=1 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.32 city_FE_2_trend=.32 city_FE_3_trend=.32 city_FE_4_trend=.32 city_FE_5_trend=.32 city_FE_6_trend=.32 ///
city_FE_7_trend=.32 city_FE_8_trend=.32 city_FE_9_trend=.32 city_FE_10_trend=.32 city_FE_11_trend=.32 city_FE_12_trend=.32 city_FE_13_trend=.32 city_FE_14_trend=.32 ///
city_FE_15_trend=.32 city_FE_16_trend=.32 city_FE_17_trend=.32 city_FE_18_trend=.32 city_FE_19_trend=.32 city_FE_20_trend=.32 city_FE_21_trend=.32 city_FE_22_trend=.32 ///
city_FE_23_trend=.32 city_FE_24_trend=.32 city_FE_25_trend=.32) ///
level(90) post

gen mortality_under1_pred_1907 = _b[_cons]
gen mortality_under1_lb_1907 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1907 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1907 mortality_under1_lb_1907 mortality_under1_ub_1907, after(mortality_under1_mean_1907)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.16604 sewage_treat_div=.08 TB_test=.1576 bact_standard=.1688 percent_female=.4990431 percent_nonwhite=.0819643 percent_foreign=.2387267 ///
percent_age_less15=.2691407 percent_age_15to44=.5454614 percent_age_45plus=.1853979 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=1 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.32 city_FE_2_trend=.32 city_FE_3_trend=.32 city_FE_4_trend=.32 city_FE_5_trend=.32 city_FE_6_trend=.32 ///
city_FE_7_trend=.32 city_FE_8_trend=.32 city_FE_9_trend=.32 city_FE_10_trend=.32 city_FE_11_trend=.32 city_FE_12_trend=.32 city_FE_13_trend=.32 city_FE_14_trend=.32 ///
city_FE_15_trend=.32 city_FE_16_trend=.32 city_FE_17_trend=.32 city_FE_18_trend=.32 city_FE_19_trend=.32 city_FE_20_trend=.32 city_FE_21_trend=.32 city_FE_22_trend=.32 ///
city_FE_23_trend=.32 city_FE_24_trend=.32 city_FE_25_trend=.32) ///
level(90) post

gen typhoid_pred_1907 = _b[_cons]
gen typhoid_lb_1907 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1907 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1907 typhoid_lb_1907 typhoid_ub_1907, after(typhoid_mean_1907)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=0 water_project=.16604 sewage_treat_div=.08 TB_test=.1576 bact_standard=.1688 percent_female=.4990431 percent_nonwhite=.0819643 percent_foreign=.2387267 ///
percent_age_less15=.2691407 percent_age_15to44=.5454614 percent_age_45plus=.1853979 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=1 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.32 city_FE_2_trend=.32 city_FE_3_trend=.32 city_FE_4_trend=.32 city_FE_5_trend=.32 city_FE_6_trend=.32 ///
city_FE_7_trend=.32 city_FE_8_trend=.32 city_FE_9_trend=.32 city_FE_10_trend=.32 city_FE_11_trend=.32 city_FE_12_trend=.32 city_FE_13_trend=.32 city_FE_14_trend=.32 ///
city_FE_15_trend=.32 city_FE_16_trend=.32 city_FE_17_trend=.32 city_FE_18_trend=.32 city_FE_19_trend=.32 city_FE_20_trend=.32 city_FE_21_trend=.32 city_FE_22_trend=.32 ///
city_FE_23_trend=.32 city_FE_24_trend=.32 city_FE_25_trend=.32) ///
level(90) post

gen diarrhea_pred_1907 = _b[_cons]
gen diarrhea_lb_1907 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1907 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1907 diarrhea_lb_1907 diarrhea_ub_1907, after(diarrhea_mean_1907)



*************
*year = 1908
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.0132 water_project=.2 sewage_treat_div=.08 TB_test=.19 bact_standard=.23 percent_female=.4981486 percent_nonwhite=.081836 percent_foreign=.2384505 ///
percent_age_less15=.2659967 percent_age_15to44=.5470876 percent_age_45plus=.1869158 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=1 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.36 city_FE_2_trend=.36 city_FE_3_trend=.36 city_FE_4_trend=.36 city_FE_5_trend=.36 city_FE_6_trend=.36 ///
city_FE_7_trend=.36 city_FE_8_trend=.36 city_FE_9_trend=.36 city_FE_10_trend=.36 city_FE_11_trend=.36 city_FE_12_trend=.36 city_FE_13_trend=.36 city_FE_14_trend=.36 ///
city_FE_15_trend=.36 city_FE_16_trend=.36 city_FE_17_trend=.36 city_FE_18_trend=.36 city_FE_19_trend=.36 city_FE_20_trend=.36 city_FE_21_trend=.36 city_FE_22_trend=.36 ///
city_FE_23_trend=.36 city_FE_24_trend=.36 city_FE_25_trend=.36) ///
level(90) post

gen mortality_under1_pred_1908 = _b[_cons]
gen mortality_under1_lb_1908 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1908 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1908 mortality_under1_lb_1908 mortality_under1_ub_1908, after(mortality_under1_mean_1908)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.0132 water_project=.2 sewage_treat_div=.08 TB_test=.19 bact_standard=.23 percent_female=.4981486 percent_nonwhite=.081836 percent_foreign=.2384505 ///
percent_age_less15=.2659967 percent_age_15to44=.5470876 percent_age_45plus=.1869158 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=1 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.36 city_FE_2_trend=.36 city_FE_3_trend=.36 city_FE_4_trend=.36 city_FE_5_trend=.36 city_FE_6_trend=.36 ///
city_FE_7_trend=.36 city_FE_8_trend=.36 city_FE_9_trend=.36 city_FE_10_trend=.36 city_FE_11_trend=.36 city_FE_12_trend=.36 city_FE_13_trend=.36 city_FE_14_trend=.36 ///
city_FE_15_trend=.36 city_FE_16_trend=.36 city_FE_17_trend=.36 city_FE_18_trend=.36 city_FE_19_trend=.36 city_FE_20_trend=.36 city_FE_21_trend=.36 city_FE_22_trend=.36 ///
city_FE_23_trend=.36 city_FE_24_trend=.36 city_FE_25_trend=.36) ///
level(90) post

gen typhoid_pred_1908 = _b[_cons]
gen typhoid_lb_1908 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1908 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1908 typhoid_lb_1908 typhoid_ub_1908, after(typhoid_mean_1908)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.0132 water_project=.2 sewage_treat_div=.08 TB_test=.19 bact_standard=.23 percent_female=.4981486 percent_nonwhite=.081836 percent_foreign=.2384505 ///
percent_age_less15=.2659967 percent_age_15to44=.5470876 percent_age_45plus=.1869158 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=1 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.36 city_FE_2_trend=.36 city_FE_3_trend=.36 city_FE_4_trend=.36 city_FE_5_trend=.36 city_FE_6_trend=.36 ///
city_FE_7_trend=.36 city_FE_8_trend=.36 city_FE_9_trend=.36 city_FE_10_trend=.36 city_FE_11_trend=.36 city_FE_12_trend=.36 city_FE_13_trend=.36 city_FE_14_trend=.36 ///
city_FE_15_trend=.36 city_FE_16_trend=.36 city_FE_17_trend=.36 city_FE_18_trend=.36 city_FE_19_trend=.36 city_FE_20_trend=.36 city_FE_21_trend=.36 city_FE_22_trend=.36 ///
city_FE_23_trend=.36 city_FE_24_trend=.36 city_FE_25_trend=.36) ///
level(90) post

gen diarrhea_pred_1908 = _b[_cons]
gen diarrhea_lb_1908 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1908 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1908 diarrhea_lb_1908 diarrhea_ub_1908, after(diarrhea_mean_1908)



*************
*year = 1909
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.06 water_project=.2 sewage_treat_div=.08 TB_test=.2744 bact_standard=.3144 percent_female=.497254 percent_nonwhite=.0817077 percent_foreign=.2381742 ///
percent_age_less15=.2628527 percent_age_15to44=.5487137 percent_age_45plus=.1884337 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=1 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.4 city_FE_2_trend=.4 city_FE_3_trend=.4 city_FE_4_trend=.4 city_FE_5_trend=.4 city_FE_6_trend=.4 ///
city_FE_7_trend=.4 city_FE_8_trend=.4 city_FE_9_trend=.4 city_FE_10_trend=.4 city_FE_11_trend=.4 city_FE_12_trend=.4 city_FE_13_trend=.4 city_FE_14_trend=.4 ///
city_FE_15_trend=.4 city_FE_16_trend=.4 city_FE_17_trend=.4 city_FE_18_trend=.4 city_FE_19_trend=.4 city_FE_20_trend=.4 city_FE_21_trend=.4 city_FE_22_trend=.4 ///
city_FE_23_trend=.4 city_FE_24_trend=.4 city_FE_25_trend=.40) ///
level(90) post

gen mortality_under1_pred_1909 = _b[_cons]
gen mortality_under1_lb_1909 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1909 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1909 mortality_under1_lb_1909 mortality_under1_ub_1909, after(mortality_under1_mean_1909)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.06 water_project=.2 sewage_treat_div=.08 TB_test=.2744 bact_standard=.3144 percent_female=.497254 percent_nonwhite=.0817077 percent_foreign=.2381742 ///
percent_age_less15=.2628527 percent_age_15to44=.5487137 percent_age_45plus=.1884337 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=1 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.4 city_FE_2_trend=.4 city_FE_3_trend=.4 city_FE_4_trend=.4 city_FE_5_trend=.4 city_FE_6_trend=.4 ///
city_FE_7_trend=.4 city_FE_8_trend=.4 city_FE_9_trend=.4 city_FE_10_trend=.4 city_FE_11_trend=.4 city_FE_12_trend=.4 city_FE_13_trend=.4 city_FE_14_trend=.4 ///
city_FE_15_trend=.4 city_FE_16_trend=.4 city_FE_17_trend=.4 city_FE_18_trend=.4 city_FE_19_trend=.4 city_FE_20_trend=.4 city_FE_21_trend=.4 city_FE_22_trend=.4 ///
city_FE_23_trend=.4 city_FE_24_trend=.4 city_FE_25_trend=.40) ///
level(90) post

gen typhoid_pred_1909 = _b[_cons]
gen typhoid_lb_1909 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1909 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1909 typhoid_lb_1909 typhoid_ub_1909, after(typhoid_mean_1909)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.06 water_project=.2 sewage_treat_div=.08 TB_test=.2744 bact_standard=.3144 percent_female=.497254 percent_nonwhite=.0817077 percent_foreign=.2381742 ///
percent_age_less15=.2628527 percent_age_15to44=.5487137 percent_age_45plus=.1884337 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=1 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.4 city_FE_2_trend=.4 city_FE_3_trend=.4 city_FE_4_trend=.4 city_FE_5_trend=.4 city_FE_6_trend=.4 ///
city_FE_7_trend=.4 city_FE_8_trend=.4 city_FE_9_trend=.4 city_FE_10_trend=.4 city_FE_11_trend=.4 city_FE_12_trend=.4 city_FE_13_trend=.4 city_FE_14_trend=.4 ///
city_FE_15_trend=.4 city_FE_16_trend=.4 city_FE_17_trend=.4 city_FE_18_trend=.4 city_FE_19_trend=.4 city_FE_20_trend=.4 city_FE_21_trend=.4 city_FE_22_trend=.4 ///
city_FE_23_trend=.4 city_FE_24_trend=.4 city_FE_25_trend=.40) ///
level(90) post

gen diarrhea_pred_1909 = _b[_cons]
gen diarrhea_lb_1909 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1909 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1909 diarrhea_lb_1909 diarrhea_ub_1909, after(diarrhea_mean_1909)




*************
*year = 1910
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.1538 water_project=.2 sewage_treat_div=.08 TB_test=.29972 bact_standard=.328 percent_female=.4963594 percent_nonwhite=.0815795 percent_foreign=.237898 ///
percent_age_less15=.2597086 percent_age_15to44=.5503398 percent_age_45plus=.1899516 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=1 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.44 city_FE_2_trend=.44 city_FE_3_trend=.44 city_FE_4_trend=.44 city_FE_5_trend=.44 city_FE_6_trend=.44 ///
city_FE_7_trend=.44 city_FE_8_trend=.44 city_FE_9_trend=.44 city_FE_10_trend=.44 city_FE_11_trend=.44 city_FE_12_trend=.44 city_FE_13_trend=.44 city_FE_14_trend=.44 ///
city_FE_15_trend=.44 city_FE_16_trend=.44 city_FE_17_trend=.44 city_FE_18_trend=.44 city_FE_19_trend=.44 city_FE_20_trend=.44 city_FE_21_trend=.44 city_FE_22_trend=.44 ///
city_FE_23_trend=.44 city_FE_24_trend=.44 city_FE_25_trend=.44) ///
level(90) post

gen mortality_under1_pred_1910 = _b[_cons]
gen mortality_under1_lb_1910 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1910 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1910 mortality_under1_lb_1910 mortality_under1_ub_1910, after(mortality_under1_mean_1910)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.1538 water_project=.2 sewage_treat_div=.08 TB_test=.29972 bact_standard=.328 percent_female=.4963594 percent_nonwhite=.0815795 percent_foreign=.237898 ///
percent_age_less15=.2597086 percent_age_15to44=.5503398 percent_age_45plus=.1899516 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=1 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.44 city_FE_2_trend=.44 city_FE_3_trend=.44 city_FE_4_trend=.44 city_FE_5_trend=.44 city_FE_6_trend=.44 ///
city_FE_7_trend=.44 city_FE_8_trend=.44 city_FE_9_trend=.44 city_FE_10_trend=.44 city_FE_11_trend=.44 city_FE_12_trend=.44 city_FE_13_trend=.44 city_FE_14_trend=.44 ///
city_FE_15_trend=.44 city_FE_16_trend=.44 city_FE_17_trend=.44 city_FE_18_trend=.44 city_FE_19_trend=.44 city_FE_20_trend=.44 city_FE_21_trend=.44 city_FE_22_trend=.44 ///
city_FE_23_trend=.44 city_FE_24_trend=.44 city_FE_25_trend=.44) ///
level(90) post

gen typhoid_pred_1910 = _b[_cons]
gen typhoid_lb_1910 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1910 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1910 typhoid_lb_1910 typhoid_ub_1910, after(typhoid_mean_1910)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.1538 water_project=.2 sewage_treat_div=.08 TB_test=.29972 bact_standard=.328 percent_female=.4963594 percent_nonwhite=.0815795 percent_foreign=.237898 ///
percent_age_less15=.2597086 percent_age_15to44=.5503398 percent_age_45plus=.1899516 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=1 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.44 city_FE_2_trend=.44 city_FE_3_trend=.44 city_FE_4_trend=.44 city_FE_5_trend=.44 city_FE_6_trend=.44 ///
city_FE_7_trend=.44 city_FE_8_trend=.44 city_FE_9_trend=.44 city_FE_10_trend=.44 city_FE_11_trend=.44 city_FE_12_trend=.44 city_FE_13_trend=.44 city_FE_14_trend=.44 ///
city_FE_15_trend=.44 city_FE_16_trend=.44 city_FE_17_trend=.44 city_FE_18_trend=.44 city_FE_19_trend=.44 city_FE_20_trend=.44 city_FE_21_trend=.44 city_FE_22_trend=.44 ///
city_FE_23_trend=.44 city_FE_24_trend=.44 city_FE_25_trend=.44) ///
level(90) post

gen diarrhea_pred_1910 = _b[_cons]
gen diarrhea_lb_1910 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1910 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1910 diarrhea_lb_1910 diarrhea_ub_1910, after(diarrhea_mean_1910)




*************
*year = 1911
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.26408 water_project=.2 sewage_treat_div=.1 TB_test=.338 bact_standard=.378 percent_female=.49676 percent_nonwhite=.0815922 percent_foreign=.2346078 ///
percent_age_less15=.2598528 percent_age_15to44=.5478469 percent_age_45plus=.1923002 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=1 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.48 city_FE_2_trend=.48 city_FE_3_trend=.48 city_FE_4_trend=.48 city_FE_5_trend=.48 city_FE_6_trend=.48 ///
city_FE_7_trend=.48 city_FE_8_trend=.48 city_FE_9_trend=.48 city_FE_10_trend=.48 city_FE_11_trend=.48 city_FE_12_trend=.48 city_FE_13_trend=.48 city_FE_14_trend=.48 ///
city_FE_15_trend=.48 city_FE_16_trend=.48 city_FE_17_trend=.48 city_FE_18_trend=.48 city_FE_19_trend=.48 city_FE_20_trend=.48 city_FE_21_trend=.48 city_FE_22_trend=.48 ///
city_FE_23_trend=.48 city_FE_24_trend=.48 city_FE_25_trend=.48) ///
level(90) post

gen mortality_under1_pred_1911 = _b[_cons]
gen mortality_under1_lb_1911 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1911 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1911 mortality_under1_lb_1911 mortality_under1_ub_1911, after(mortality_under1_mean_1911)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.26408 water_project=.2 sewage_treat_div=.1 TB_test=.338 bact_standard=.378 percent_female=.49676 percent_nonwhite=.0815922 percent_foreign=.2346078 ///
percent_age_less15=.2598528 percent_age_15to44=.5478469 percent_age_45plus=.1923002 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=1 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.48 city_FE_2_trend=.48 city_FE_3_trend=.48 city_FE_4_trend=.48 city_FE_5_trend=.48 city_FE_6_trend=.48 ///
city_FE_7_trend=.48 city_FE_8_trend=.48 city_FE_9_trend=.48 city_FE_10_trend=.48 city_FE_11_trend=.48 city_FE_12_trend=.48 city_FE_13_trend=.48 city_FE_14_trend=.48 ///
city_FE_15_trend=.48 city_FE_16_trend=.48 city_FE_17_trend=.48 city_FE_18_trend=.48 city_FE_19_trend=.48 city_FE_20_trend=.48 city_FE_21_trend=.48 city_FE_22_trend=.48 ///
city_FE_23_trend=.48 city_FE_24_trend=.48 city_FE_25_trend=.48) ///
level(90) post

gen typhoid_pred_1911 = _b[_cons]
gen typhoid_lb_1911 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1911 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1911 typhoid_lb_1911 typhoid_ub_1911, after(typhoid_mean_1911)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.26408 water_project=.2 sewage_treat_div=.1 TB_test=.338 bact_standard=.378 percent_female=.49676 percent_nonwhite=.0815922 percent_foreign=.2346078 ///
percent_age_less15=.2598528 percent_age_15to44=.5478469 percent_age_45plus=.1923002 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=1 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.48 city_FE_2_trend=.48 city_FE_3_trend=.48 city_FE_4_trend=.48 city_FE_5_trend=.48 city_FE_6_trend=.48 ///
city_FE_7_trend=.48 city_FE_8_trend=.48 city_FE_9_trend=.48 city_FE_10_trend=.48 city_FE_11_trend=.48 city_FE_12_trend=.48 city_FE_13_trend=.48 city_FE_14_trend=.48 ///
city_FE_15_trend=.48 city_FE_16_trend=.48 city_FE_17_trend=.48 city_FE_18_trend=.48 city_FE_19_trend=.48 city_FE_20_trend=.48 city_FE_21_trend=.48 city_FE_22_trend=.48 ///
city_FE_23_trend=.48 city_FE_24_trend=.48 city_FE_25_trend=.48) ///
level(90) post

gen diarrhea_pred_1911 = _b[_cons]
gen diarrhea_lb_1911 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1911 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1911 diarrhea_lb_1911 diarrhea_ub_1911, after(diarrhea_mean_1911)



*************
*year = 1912
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.4336 water_project=.2 sewage_treat_div=.16 TB_test=.33516 bact_standard=.41436 percent_female=.4971605 percent_nonwhite=.0816049 percent_foreign=.2313177 ///
percent_age_less15=.259997 percent_age_15to44=.545354 percent_age_45plus=.1946489 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=1 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.52 city_FE_2_trend=.52 city_FE_3_trend=.52 city_FE_4_trend=.52 city_FE_5_trend=.52 city_FE_6_trend=.52 ///
city_FE_7_trend=.52 city_FE_8_trend=.52 city_FE_9_trend=.52 city_FE_10_trend=.52 city_FE_11_trend=.52 city_FE_12_trend=.52 city_FE_13_trend=.52 city_FE_14_trend=.52 ///
city_FE_15_trend=.52 city_FE_16_trend=.52 city_FE_17_trend=.52 city_FE_18_trend=.52 city_FE_19_trend=.52 city_FE_20_trend=.52 city_FE_21_trend=.52 city_FE_22_trend=.52 ///
city_FE_23_trend=.52 city_FE_24_trend=.52 city_FE_25_trend=.52) ///
level(90) post

gen mortality_under1_pred_1912 = _b[_cons]
gen mortality_under1_lb_1912 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1912 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1912 mortality_under1_lb_1912 mortality_under1_ub_1912, after(mortality_under1_mean_1912)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.4336 water_project=.2 sewage_treat_div=.16 TB_test=.33516 bact_standard=.41436 percent_female=.4971605 percent_nonwhite=.0816049 percent_foreign=.2313177 ///
percent_age_less15=.259997 percent_age_15to44=.545354 percent_age_45plus=.1946489 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=1 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.52 city_FE_2_trend=.52 city_FE_3_trend=.52 city_FE_4_trend=.52 city_FE_5_trend=.52 city_FE_6_trend=.52 ///
city_FE_7_trend=.52 city_FE_8_trend=.52 city_FE_9_trend=.52 city_FE_10_trend=.52 city_FE_11_trend=.52 city_FE_12_trend=.52 city_FE_13_trend=.52 city_FE_14_trend=.52 ///
city_FE_15_trend=.52 city_FE_16_trend=.52 city_FE_17_trend=.52 city_FE_18_trend=.52 city_FE_19_trend=.52 city_FE_20_trend=.52 city_FE_21_trend=.52 city_FE_22_trend=.52 ///
city_FE_23_trend=.52 city_FE_24_trend=.52 city_FE_25_trend=.52) ///
level(90) post

gen typhoid_pred_1912 = _b[_cons]
gen typhoid_lb_1912 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1912 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1912 typhoid_lb_1912 typhoid_ub_1912, after(typhoid_mean_1912)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.4336 water_project=.2 sewage_treat_div=.16 TB_test=.33516 bact_standard=.41436 percent_female=.4971605 percent_nonwhite=.0816049 percent_foreign=.2313177 ///
percent_age_less15=.259997 percent_age_15to44=.545354 percent_age_45plus=.1946489 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=1 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.52 city_FE_2_trend=.52 city_FE_3_trend=.52 city_FE_4_trend=.52 city_FE_5_trend=.52 city_FE_6_trend=.52 ///
city_FE_7_trend=.52 city_FE_8_trend=.52 city_FE_9_trend=.52 city_FE_10_trend=.52 city_FE_11_trend=.52 city_FE_12_trend=.52 city_FE_13_trend=.52 city_FE_14_trend=.52 ///
city_FE_15_trend=.52 city_FE_16_trend=.52 city_FE_17_trend=.52 city_FE_18_trend=.52 city_FE_19_trend=.52 city_FE_20_trend=.52 city_FE_21_trend=.52 city_FE_22_trend=.52 ///
city_FE_23_trend=.52 city_FE_24_trend=.52 city_FE_25_trend=.52) ///
level(90) post

gen diarrhea_pred_1912 = _b[_cons]
gen diarrhea_lb_1912 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1912 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1912 diarrhea_lb_1912 diarrhea_ub_1912, after(diarrhea_mean_1912)




*************
*year = 1913
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.5032 water_project=.22536 sewage_treat_div=.16 TB_test=.3632 bact_standard=.4832 percent_female=.497561 percent_nonwhite=.0816176 percent_foreign=.2280275 ///
percent_age_less15=.2601412 percent_age_15to44=.5428612 percent_age_45plus=.1969976 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=1 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.56 city_FE_2_trend=.56 city_FE_3_trend=.56 city_FE_4_trend=.56 city_FE_5_trend=.56 city_FE_6_trend=.56 ///
city_FE_7_trend=.56 city_FE_8_trend=.56 city_FE_9_trend=.56 city_FE_10_trend=.56 city_FE_11_trend=.56 city_FE_12_trend=.56 city_FE_13_trend=.56 city_FE_14_trend=.56 ///
city_FE_15_trend=.56 city_FE_16_trend=.56 city_FE_17_trend=.56 city_FE_18_trend=.56 city_FE_19_trend=.56 city_FE_20_trend=.56 city_FE_21_trend=.56 city_FE_22_trend=.56 ///
city_FE_23_trend=.56 city_FE_24_trend=.56 city_FE_25_trend=.56) ///
level(90) post

gen mortality_under1_pred_1913 = _b[_cons]
gen mortality_under1_lb_1913 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1913 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1913 mortality_under1_lb_1913 mortality_under1_ub_1913, after(mortality_under1_mean_1913)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.5032 water_project=.22536 sewage_treat_div=.16 TB_test=.3632 bact_standard=.4832 percent_female=.497561 percent_nonwhite=.0816176 percent_foreign=.2280275 ///
percent_age_less15=.2601412 percent_age_15to44=.5428612 percent_age_45plus=.1969976 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=1 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.56 city_FE_2_trend=.56 city_FE_3_trend=.56 city_FE_4_trend=.56 city_FE_5_trend=.56 city_FE_6_trend=.56 ///
city_FE_7_trend=.56 city_FE_8_trend=.56 city_FE_9_trend=.56 city_FE_10_trend=.56 city_FE_11_trend=.56 city_FE_12_trend=.56 city_FE_13_trend=.56 city_FE_14_trend=.56 ///
city_FE_15_trend=.56 city_FE_16_trend=.56 city_FE_17_trend=.56 city_FE_18_trend=.56 city_FE_19_trend=.56 city_FE_20_trend=.56 city_FE_21_trend=.56 city_FE_22_trend=.56 ///
city_FE_23_trend=.56 city_FE_24_trend=.56 city_FE_25_trend=.56) ///
level(90) post

gen typhoid_pred_1913 = _b[_cons]
gen typhoid_lb_1913 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1913 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1913 typhoid_lb_1913 typhoid_ub_1913, after(typhoid_mean_1913)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.5032 water_project=.22536 sewage_treat_div=.16 TB_test=.3632 bact_standard=.4832 percent_female=.497561 percent_nonwhite=.0816176 percent_foreign=.2280275 ///
percent_age_less15=.2601412 percent_age_15to44=.5428612 percent_age_45plus=.1969976 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=1 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.56 city_FE_2_trend=.56 city_FE_3_trend=.56 city_FE_4_trend=.56 city_FE_5_trend=.56 city_FE_6_trend=.56 ///
city_FE_7_trend=.56 city_FE_8_trend=.56 city_FE_9_trend=.56 city_FE_10_trend=.56 city_FE_11_trend=.56 city_FE_12_trend=.56 city_FE_13_trend=.56 city_FE_14_trend=.56 ///
city_FE_15_trend=.56 city_FE_16_trend=.56 city_FE_17_trend=.56 city_FE_18_trend=.56 city_FE_19_trend=.56 city_FE_20_trend=.56 city_FE_21_trend=.56 city_FE_22_trend=.56 ///
city_FE_23_trend=.56 city_FE_24_trend=.56 city_FE_25_trend=.56) ///
level(90) post

gen diarrhea_pred_1913 = _b[_cons]
gen diarrhea_lb_1913 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1913 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1913 diarrhea_lb_1913 diarrhea_ub_1913, after(diarrhea_mean_1913)



*************
*year = 1914
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.57412 water_project=.24 sewage_treat_div=.16 TB_test=.43668 bact_standard=.54 percent_female=.4979615 percent_nonwhite=.0816303 percent_foreign=.2247374 ///
percent_age_less15=.2602854 percent_age_15to44=.5403683 percent_age_45plus=.1993463 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=1 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.6 city_FE_2_trend=.6 city_FE_3_trend=.6 city_FE_4_trend=.6 city_FE_5_trend=.6 city_FE_6_trend=.6 ///
city_FE_7_trend=.6 city_FE_8_trend=.6 city_FE_9_trend=.6 city_FE_10_trend=.6 city_FE_11_trend=.6 city_FE_12_trend=.6 city_FE_13_trend=.6 city_FE_14_trend=.6 ///
city_FE_15_trend=.6 city_FE_16_trend=.6 city_FE_17_trend=.6 city_FE_18_trend=.6 city_FE_19_trend=.6 city_FE_20_trend=.6 city_FE_21_trend=.6 city_FE_22_trend=.6 ///
city_FE_23_trend=.6 city_FE_24_trend=.6 city_FE_25_trend=.6) ///
level(90) post

gen mortality_under1_pred_1914 = _b[_cons]
gen mortality_under1_lb_1914 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1914 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1914 mortality_under1_lb_1914 mortality_under1_ub_1914, after(mortality_under1_mean_1914)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.57412 water_project=.24 sewage_treat_div=.16 TB_test=.43668 bact_standard=.54 percent_female=.4979615 percent_nonwhite=.0816303 percent_foreign=.2247374 ///
percent_age_less15=.2602854 percent_age_15to44=.5403683 percent_age_45plus=.1993463 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=1 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.6 city_FE_2_trend=.6 city_FE_3_trend=.6 city_FE_4_trend=.6 city_FE_5_trend=.6 city_FE_6_trend=.6 ///
city_FE_7_trend=.6 city_FE_8_trend=.6 city_FE_9_trend=.6 city_FE_10_trend=.6 city_FE_11_trend=.6 city_FE_12_trend=.6 city_FE_13_trend=.6 city_FE_14_trend=.6 ///
city_FE_15_trend=.6 city_FE_16_trend=.6 city_FE_17_trend=.6 city_FE_18_trend=.6 city_FE_19_trend=.6 city_FE_20_trend=.6 city_FE_21_trend=.6 city_FE_22_trend=.6 ///
city_FE_23_trend=.6 city_FE_24_trend=.6 city_FE_25_trend=.6) ///
level(90) post

gen typhoid_pred_1914 = _b[_cons]
gen typhoid_lb_1914 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1914 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1914 typhoid_lb_1914 typhoid_ub_1914, after(typhoid_mean_1914)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.57412 water_project=.24 sewage_treat_div=.16 TB_test=.43668 bact_standard=.54 percent_female=.4979615 percent_nonwhite=.0816303 percent_foreign=.2247374 ///
percent_age_less15=.2602854 percent_age_15to44=.5403683 percent_age_45plus=.1993463 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=1 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.6 city_FE_2_trend=.6 city_FE_3_trend=.6 city_FE_4_trend=.6 city_FE_5_trend=.6 city_FE_6_trend=.6 ///
city_FE_7_trend=.6 city_FE_8_trend=.6 city_FE_9_trend=.6 city_FE_10_trend=.6 city_FE_11_trend=.6 city_FE_12_trend=.6 city_FE_13_trend=.6 city_FE_14_trend=.6 ///
city_FE_15_trend=.6 city_FE_16_trend=.6 city_FE_17_trend=.6 city_FE_18_trend=.6 city_FE_19_trend=.6 city_FE_20_trend=.6 city_FE_21_trend=.6 city_FE_22_trend=.6 ///
city_FE_23_trend=.6 city_FE_24_trend=.6 city_FE_25_trend=.6) ///
level(90) post

gen diarrhea_pred_1914 = _b[_cons]
gen diarrhea_lb_1914 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1914 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1914 diarrhea_lb_1914 diarrhea_ub_1914, after(diarrhea_mean_1914)




*************
*year = 1915
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.64 water_project=.24 sewage_treat_div=.16 TB_test=.4968 bact_standard=.6768 percent_female=.498362 percent_nonwhite=.081643 percent_foreign=.2214472 ///
percent_age_less15=.2604296 percent_age_15to44=.5378754 percent_age_45plus=.201695 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=1 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.64 city_FE_2_trend=.64 city_FE_3_trend=.64 city_FE_4_trend=.64 city_FE_5_trend=.64 city_FE_6_trend=.64 ///
city_FE_7_trend=.64 city_FE_8_trend=.64 city_FE_9_trend=.64 city_FE_10_trend=.64 city_FE_11_trend=.64 city_FE_12_trend=.64 city_FE_13_trend=.64 city_FE_14_trend=.64 ///
city_FE_15_trend=.64 city_FE_16_trend=.64 city_FE_17_trend=.64 city_FE_18_trend=.64 city_FE_19_trend=.64 city_FE_20_trend=.64 city_FE_21_trend=.64 city_FE_22_trend=.64 ///
city_FE_23_trend=.64 city_FE_24_trend=.64 city_FE_25_trend=.64) ///
level(90) post

gen mortality_under1_pred_1915 = _b[_cons]
gen mortality_under1_lb_1915 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1915 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1915 mortality_under1_lb_1915 mortality_under1_ub_1915, after(mortality_under1_mean_1915)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.64 water_project=.24 sewage_treat_div=.16 TB_test=.4968 bact_standard=.6768 percent_female=.498362 percent_nonwhite=.081643 percent_foreign=.2214472 ///
percent_age_less15=.2604296 percent_age_15to44=.5378754 percent_age_45plus=.201695 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=1 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.64 city_FE_2_trend=.64 city_FE_3_trend=.64 city_FE_4_trend=.64 city_FE_5_trend=.64 city_FE_6_trend=.64 ///
city_FE_7_trend=.64 city_FE_8_trend=.64 city_FE_9_trend=.64 city_FE_10_trend=.64 city_FE_11_trend=.64 city_FE_12_trend=.64 city_FE_13_trend=.64 city_FE_14_trend=.64 ///
city_FE_15_trend=.64 city_FE_16_trend=.64 city_FE_17_trend=.64 city_FE_18_trend=.64 city_FE_19_trend=.64 city_FE_20_trend=.64 city_FE_21_trend=.64 city_FE_22_trend=.64 ///
city_FE_23_trend=.64 city_FE_24_trend=.64 city_FE_25_trend=.64) ///
level(90) post

gen typhoid_pred_1915 = _b[_cons]
gen typhoid_lb_1915 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1915 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1915 typhoid_lb_1915 typhoid_ub_1915, after(typhoid_mean_1915)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.64 water_project=.24 sewage_treat_div=.16 TB_test=.4968 bact_standard=.6768 percent_female=.498362 percent_nonwhite=.081643 percent_foreign=.2214472 ///
percent_age_less15=.2604296 percent_age_15to44=.5378754 percent_age_45plus=.201695 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=1 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.64 city_FE_2_trend=.64 city_FE_3_trend=.64 city_FE_4_trend=.64 city_FE_5_trend=.64 city_FE_6_trend=.64 ///
city_FE_7_trend=.64 city_FE_8_trend=.64 city_FE_9_trend=.64 city_FE_10_trend=.64 city_FE_11_trend=.64 city_FE_12_trend=.64 city_FE_13_trend=.64 city_FE_14_trend=.64 ///
city_FE_15_trend=.64 city_FE_16_trend=.64 city_FE_17_trend=.64 city_FE_18_trend=.64 city_FE_19_trend=.64 city_FE_20_trend=.64 city_FE_21_trend=.64 city_FE_22_trend=.64 ///
city_FE_23_trend=.64 city_FE_24_trend=.64 city_FE_25_trend=.64) ///
level(90) post

gen diarrhea_pred_1915 = _b[_cons]
gen diarrhea_lb_1915 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1915 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1915 diarrhea_lb_1915 diarrhea_ub_1915, after(diarrhea_mean_1915)




*************
*year = 1916
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.64 water_project=.24 sewage_treat_div=.16 TB_test=.5444 bact_standard=.7444 percent_female=.4987625 percent_nonwhite=.0816557 percent_foreign=.2181571 ///
percent_age_less15=.2605738 percent_age_15to44=.5353825 percent_age_45plus=.2040437 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=1 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.68 city_FE_2_trend=.68 city_FE_3_trend=.68 city_FE_4_trend=.68 city_FE_5_trend=.68 city_FE_6_trend=.68 ///
city_FE_7_trend=.68 city_FE_8_trend=.68 city_FE_9_trend=.68 city_FE_10_trend=.68 city_FE_11_trend=.68 city_FE_12_trend=.68 city_FE_13_trend=.68 city_FE_14_trend=.68 ///
city_FE_15_trend=.68 city_FE_16_trend=.68 city_FE_17_trend=.68 city_FE_18_trend=.68 city_FE_19_trend=.68 city_FE_20_trend=.68 city_FE_21_trend=.68 city_FE_22_trend=.68 ///
city_FE_23_trend=.68 city_FE_24_trend=.68 city_FE_25_trend=.68) ///
level(90) post

gen mortality_under1_pred_1916 = _b[_cons]
gen mortality_under1_lb_1916 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1916 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1916 mortality_under1_lb_1916 mortality_under1_ub_1916, after(mortality_under1_mean_1916)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.64 water_project=.24 sewage_treat_div=.16 TB_test=.5444 bact_standard=.7444 percent_female=.4987625 percent_nonwhite=.0816557 percent_foreign=.2181571 ///
percent_age_less15=.2605738 percent_age_15to44=.5353825 percent_age_45plus=.2040437 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=1 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.68 city_FE_2_trend=.68 city_FE_3_trend=.68 city_FE_4_trend=.68 city_FE_5_trend=.68 city_FE_6_trend=.68 ///
city_FE_7_trend=.68 city_FE_8_trend=.68 city_FE_9_trend=.68 city_FE_10_trend=.68 city_FE_11_trend=.68 city_FE_12_trend=.68 city_FE_13_trend=.68 city_FE_14_trend=.68 ///
city_FE_15_trend=.68 city_FE_16_trend=.68 city_FE_17_trend=.68 city_FE_18_trend=.68 city_FE_19_trend=.68 city_FE_20_trend=.68 city_FE_21_trend=.68 city_FE_22_trend=.68 ///
city_FE_23_trend=.68 city_FE_24_trend=.68 city_FE_25_trend=.68) ///
level(90) post

gen typhoid_pred_1916 = _b[_cons]
gen typhoid_lb_1916 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1916 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1916 typhoid_lb_1916 typhoid_ub_1916, after(typhoid_mean_1916)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.64 water_project=.24 sewage_treat_div=.16 TB_test=.5444 bact_standard=.7444 percent_female=.4987625 percent_nonwhite=.0816557 percent_foreign=.2181571 ///
percent_age_less15=.2605738 percent_age_15to44=.5353825 percent_age_45plus=.2040437 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=1 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.68 city_FE_2_trend=.68 city_FE_3_trend=.68 city_FE_4_trend=.68 city_FE_5_trend=.68 city_FE_6_trend=.68 ///
city_FE_7_trend=.68 city_FE_8_trend=.68 city_FE_9_trend=.68 city_FE_10_trend=.68 city_FE_11_trend=.68 city_FE_12_trend=.68 city_FE_13_trend=.68 city_FE_14_trend=.68 ///
city_FE_15_trend=.68 city_FE_16_trend=.68 city_FE_17_trend=.68 city_FE_18_trend=.68 city_FE_19_trend=.68 city_FE_20_trend=.68 city_FE_21_trend=.68 city_FE_22_trend=.68 ///
city_FE_23_trend=.68 city_FE_24_trend=.68 city_FE_25_trend=.68) ///
level(90) post

gen diarrhea_pred_1916 = _b[_cons]
gen diarrhea_lb_1916 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1916 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1916 diarrhea_lb_1916 diarrhea_ub_1916, after(diarrhea_mean_1916)




*************
*year = 1917
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.6668 water_project=.24 sewage_treat_div=.19152 TB_test=.56668 bact_standard=.7788 percent_female=.499163 percent_nonwhite=.0816684 percent_foreign=.2148669 ///
percent_age_less15=.260718 percent_age_15to44=.5328897 percent_age_45plus=.2063923 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=1 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.72 city_FE_2_trend=.72 city_FE_3_trend=.72 city_FE_4_trend=.72 city_FE_5_trend=.72 city_FE_6_trend=.72 ///
city_FE_7_trend=.72 city_FE_8_trend=.72 city_FE_9_trend=.72 city_FE_10_trend=.72 city_FE_11_trend=.72 city_FE_12_trend=.72 city_FE_13_trend=.72 city_FE_14_trend=.72 ///
city_FE_15_trend=.72 city_FE_16_trend=.72 city_FE_17_trend=.72 city_FE_18_trend=.72 city_FE_19_trend=.72 city_FE_20_trend=.72 city_FE_21_trend=.72 city_FE_22_trend=.72 ///
city_FE_23_trend=.72 city_FE_24_trend=.72 city_FE_25_trend=.72) ///
level(90) post

gen mortality_under1_pred_1917 = _b[_cons]
gen mortality_under1_lb_1917 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1917 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1917 mortality_under1_lb_1917 mortality_under1_ub_1917, after(mortality_under1_mean_1917)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.6668 water_project=.24 sewage_treat_div=.19152 TB_test=.56668 bact_standard=.7788 percent_female=.499163 percent_nonwhite=.0816684 percent_foreign=.2148669 ///
percent_age_less15=.260718 percent_age_15to44=.5328897 percent_age_45plus=.2063923 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=1 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.72 city_FE_2_trend=.72 city_FE_3_trend=.72 city_FE_4_trend=.72 city_FE_5_trend=.72 city_FE_6_trend=.72 ///
city_FE_7_trend=.72 city_FE_8_trend=.72 city_FE_9_trend=.72 city_FE_10_trend=.72 city_FE_11_trend=.72 city_FE_12_trend=.72 city_FE_13_trend=.72 city_FE_14_trend=.72 ///
city_FE_15_trend=.72 city_FE_16_trend=.72 city_FE_17_trend=.72 city_FE_18_trend=.72 city_FE_19_trend=.72 city_FE_20_trend=.72 city_FE_21_trend=.72 city_FE_22_trend=.72 ///
city_FE_23_trend=.72 city_FE_24_trend=.72 city_FE_25_trend=.72) ///
level(90) post

gen typhoid_pred_1917 = _b[_cons]
gen typhoid_lb_1917 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1917 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1917 typhoid_lb_1917 typhoid_ub_1917, after(typhoid_mean_1917)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.6668 water_project=.24 sewage_treat_div=.19152 TB_test=.56668 bact_standard=.7788 percent_female=.499163 percent_nonwhite=.0816684 percent_foreign=.2148669 ///
percent_age_less15=.260718 percent_age_15to44=.5328897 percent_age_45plus=.2063923 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=1 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.72 city_FE_2_trend=.72 city_FE_3_trend=.72 city_FE_4_trend=.72 city_FE_5_trend=.72 city_FE_6_trend=.72 ///
city_FE_7_trend=.72 city_FE_8_trend=.72 city_FE_9_trend=.72 city_FE_10_trend=.72 city_FE_11_trend=.72 city_FE_12_trend=.72 city_FE_13_trend=.72 city_FE_14_trend=.72 ///
city_FE_15_trend=.72 city_FE_16_trend=.72 city_FE_17_trend=.72 city_FE_18_trend=.72 city_FE_19_trend=.72 city_FE_20_trend=.72 city_FE_21_trend=.72 city_FE_22_trend=.72 ///
city_FE_23_trend=.72 city_FE_24_trend=.72 city_FE_25_trend=.72) ///
level(90) post

gen diarrhea_pred_1917 = _b[_cons]
gen diarrhea_lb_1917 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1917 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1917 diarrhea_lb_1917 diarrhea_ub_1917, after(diarrhea_mean_1917)



*************
*year = 1918
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.72 water_project=.24 sewage_treat_div=.2 TB_test=.6 bact_standard=.8092 percent_female=.4995635 percent_nonwhite=.0816811 percent_foreign=.2115768 ///
percent_age_less15=.2608622 percent_age_15to44=.5303968 percent_age_45plus=.208741 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=1 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.76 city_FE_2_trend=.76 city_FE_3_trend=.76 city_FE_4_trend=.76 city_FE_5_trend=.76 city_FE_6_trend=.76 ///
city_FE_7_trend=.76 city_FE_8_trend=.76 city_FE_9_trend=.76 city_FE_10_trend=.76 city_FE_11_trend=.76 city_FE_12_trend=.76 city_FE_13_trend=.76 city_FE_14_trend=.76 ///
city_FE_15_trend=.76 city_FE_16_trend=.76 city_FE_17_trend=.76 city_FE_18_trend=.76 city_FE_19_trend=.76 city_FE_20_trend=.76 city_FE_21_trend=.76 city_FE_22_trend=.76 ///
city_FE_23_trend=.76 city_FE_24_trend=.76 city_FE_25_trend=.76) ///
level(90) post

gen mortality_under1_pred_1918 = _b[_cons]
gen mortality_under1_lb_1918 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1918 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1918 mortality_under1_lb_1918 mortality_under1_ub_1918, after(mortality_under1_mean_1918)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.72 water_project=.24 sewage_treat_div=.2 TB_test=.6 bact_standard=.8092 percent_female=.4995635 percent_nonwhite=.0816811 percent_foreign=.2115768 ///
percent_age_less15=.2608622 percent_age_15to44=.5303968 percent_age_45plus=.208741 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=1 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.76 city_FE_2_trend=.76 city_FE_3_trend=.76 city_FE_4_trend=.76 city_FE_5_trend=.76 city_FE_6_trend=.76 ///
city_FE_7_trend=.76 city_FE_8_trend=.76 city_FE_9_trend=.76 city_FE_10_trend=.76 city_FE_11_trend=.76 city_FE_12_trend=.76 city_FE_13_trend=.76 city_FE_14_trend=.76 ///
city_FE_15_trend=.76 city_FE_16_trend=.76 city_FE_17_trend=.76 city_FE_18_trend=.76 city_FE_19_trend=.76 city_FE_20_trend=.76 city_FE_21_trend=.76 city_FE_22_trend=.76 ///
city_FE_23_trend=.76 city_FE_24_trend=.76 city_FE_25_trend=.76) ///
level(90) post

gen typhoid_pred_1918 = _b[_cons]
gen typhoid_lb_1918 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1918 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1918 typhoid_lb_1918 typhoid_ub_1918, after(typhoid_mean_1918)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.72 water_project=.24 sewage_treat_div=.2 TB_test=.6 bact_standard=.8092 percent_female=.4995635 percent_nonwhite=.0816811 percent_foreign=.2115768 ///
percent_age_less15=.2608622 percent_age_15to44=.5303968 percent_age_45plus=.208741 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=1 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.76 city_FE_2_trend=.76 city_FE_3_trend=.76 city_FE_4_trend=.76 city_FE_5_trend=.76 city_FE_6_trend=.76 ///
city_FE_7_trend=.76 city_FE_8_trend=.76 city_FE_9_trend=.76 city_FE_10_trend=.76 city_FE_11_trend=.76 city_FE_12_trend=.76 city_FE_13_trend=.76 city_FE_14_trend=.76 ///
city_FE_15_trend=.76 city_FE_16_trend=.76 city_FE_17_trend=.76 city_FE_18_trend=.76 city_FE_19_trend=.76 city_FE_20_trend=.76 city_FE_21_trend=.76 city_FE_22_trend=.76 ///
city_FE_23_trend=.76 city_FE_24_trend=.76 city_FE_25_trend=.76) ///
level(90) post

gen diarrhea_pred_1918 = _b[_cons]
gen diarrhea_lb_1918 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1918 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1918 diarrhea_lb_1918 diarrhea_ub_1918, after(diarrhea_mean_1918)




*************
*year = 1919
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.72 water_project=.24 sewage_treat_div=.2 TB_test=.6 bact_standard=.84 percent_female=.4995641 percent_nonwhite=.0816938 percent_foreign=.2082866 ///
percent_age_less15=.2610064 percent_age_15to44=.5279039 percent_age_45plus=.2110897 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=1 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.8 city_FE_2_trend=.8 city_FE_3_trend=.8 city_FE_4_trend=.8 city_FE_5_trend=.8 city_FE_6_trend=.8 ///
city_FE_7_trend=.8 city_FE_8_trend=.8 city_FE_9_trend=.8 city_FE_10_trend=.8 city_FE_11_trend=.8 city_FE_12_trend=.8 city_FE_13_trend=.8 city_FE_14_trend=.8 ///
city_FE_15_trend=.8 city_FE_16_trend=.8 city_FE_17_trend=.8 city_FE_18_trend=.8 city_FE_19_trend=.8 city_FE_20_trend=.8 city_FE_21_trend=.8 city_FE_22_trend=.8 ///
city_FE_23_trend=.8 city_FE_24_trend=.8 city_FE_25_trend=.80) ///
level(90) post

gen mortality_under1_pred_1919 = _b[_cons]
gen mortality_under1_lb_1919 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1919 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1919 mortality_under1_lb_1919 mortality_under1_ub_1919, after(mortality_under1_mean_1919)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.72 water_project=.24 sewage_treat_div=.2 TB_test=.6 bact_standard=.84 percent_female=.4995641 percent_nonwhite=.0816938 percent_foreign=.2082866 ///
percent_age_less15=.2610064 percent_age_15to44=.5279039 percent_age_45plus=.2110897 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=1 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.8 city_FE_2_trend=.8 city_FE_3_trend=.8 city_FE_4_trend=.8 city_FE_5_trend=.8 city_FE_6_trend=.8 ///
city_FE_7_trend=.8 city_FE_8_trend=.8 city_FE_9_trend=.8 city_FE_10_trend=.8 city_FE_11_trend=.8 city_FE_12_trend=.8 city_FE_13_trend=.8 city_FE_14_trend=.8 ///
city_FE_15_trend=.8 city_FE_16_trend=.8 city_FE_17_trend=.8 city_FE_18_trend=.8 city_FE_19_trend=.8 city_FE_20_trend=.8 city_FE_21_trend=.8 city_FE_22_trend=.8 ///
city_FE_23_trend=.8 city_FE_24_trend=.8 city_FE_25_trend=.80) ///
level(90) post

gen typhoid_pred_1919 = _b[_cons]
gen typhoid_lb_1919 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1919 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1919 typhoid_lb_1919 typhoid_ub_1919, after(typhoid_mean_1919)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.72 water_project=.24 sewage_treat_div=.2 TB_test=.6 bact_standard=.84 percent_female=.4995641 percent_nonwhite=.0816938 percent_foreign=.2082866 ///
percent_age_less15=.2610064 percent_age_15to44=.5279039 percent_age_45plus=.2110897 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=1 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.8 city_FE_2_trend=.8 city_FE_3_trend=.8 city_FE_4_trend=.8 city_FE_5_trend=.8 city_FE_6_trend=.8 ///
city_FE_7_trend=.8 city_FE_8_trend=.8 city_FE_9_trend=.8 city_FE_10_trend=.8 city_FE_11_trend=.8 city_FE_12_trend=.8 city_FE_13_trend=.8 city_FE_14_trend=.8 ///
city_FE_15_trend=.8 city_FE_16_trend=.8 city_FE_17_trend=.8 city_FE_18_trend=.8 city_FE_19_trend=.8 city_FE_20_trend=.8 city_FE_21_trend=.8 city_FE_22_trend=.8 ///
city_FE_23_trend=.8 city_FE_24_trend=.8 city_FE_25_trend=.80) ///
level(90) post

gen diarrhea_pred_1919 = _b[_cons]
gen diarrhea_lb_1919 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1919 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1919 diarrhea_lb_1919 diarrhea_ub_1919, after(diarrhea_mean_1919)




*************
*year = 1920
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.8 water_project=.24 sewage_treat_div=.2 TB_test=.6 bact_standard=.84 percent_female=.5003646 percent_nonwhite=.0817065 percent_foreign=.2049965 ///
percent_age_less15=.2611506 percent_age_15to44=.525411 percent_age_45plus=.2134384 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=1 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.84 city_FE_2_trend=.84 city_FE_3_trend=.84 city_FE_4_trend=.84 city_FE_5_trend=.84 city_FE_6_trend=.84 ///
city_FE_7_trend=.84 city_FE_8_trend=.84 city_FE_9_trend=.84 city_FE_10_trend=.84 city_FE_11_trend=.84 city_FE_12_trend=.84 city_FE_13_trend=.84 city_FE_14_trend=.84 ///
city_FE_15_trend=.84 city_FE_16_trend=.84 city_FE_17_trend=.84 city_FE_18_trend=.84 city_FE_19_trend=.84 city_FE_20_trend=.84 city_FE_21_trend=.84 city_FE_22_trend=.84 ///
city_FE_23_trend=.84 city_FE_24_trend=.84 city_FE_25_trend=.84) ///
level(90) post

gen mortality_under1_pred_1920 = _b[_cons]
gen mortality_under1_lb_1920 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1920 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1920 mortality_under1_lb_1920 mortality_under1_ub_1920, after(mortality_under1_mean_1920)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.8 water_project=.24 sewage_treat_div=.2 TB_test=.6 bact_standard=.84 percent_female=.5003646 percent_nonwhite=.0817065 percent_foreign=.2049965 ///
percent_age_less15=.2611506 percent_age_15to44=.525411 percent_age_45plus=.2134384 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=1 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.84 city_FE_2_trend=.84 city_FE_3_trend=.84 city_FE_4_trend=.84 city_FE_5_trend=.84 city_FE_6_trend=.84 ///
city_FE_7_trend=.84 city_FE_8_trend=.84 city_FE_9_trend=.84 city_FE_10_trend=.84 city_FE_11_trend=.84 city_FE_12_trend=.84 city_FE_13_trend=.84 city_FE_14_trend=.84 ///
city_FE_15_trend=.84 city_FE_16_trend=.84 city_FE_17_trend=.84 city_FE_18_trend=.84 city_FE_19_trend=.84 city_FE_20_trend=.84 city_FE_21_trend=.84 city_FE_22_trend=.84 ///
city_FE_23_trend=.84 city_FE_24_trend=.84 city_FE_25_trend=.84) ///
level(90) post

gen typhoid_pred_1920 = _b[_cons]
gen typhoid_lb_1920 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1920 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1920 typhoid_lb_1920 typhoid_ub_1920, after(typhoid_mean_1920)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.8 water_project=.24 sewage_treat_div=.2 TB_test=.6 bact_standard=.84 percent_female=.5003646 percent_nonwhite=.0817065 percent_foreign=.2049965 ///
percent_age_less15=.2611506 percent_age_15to44=.525411 percent_age_45plus=.2134384 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=1 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.84 city_FE_2_trend=.84 city_FE_3_trend=.84 city_FE_4_trend=.84 city_FE_5_trend=.84 city_FE_6_trend=.84 ///
city_FE_7_trend=.84 city_FE_8_trend=.84 city_FE_9_trend=.84 city_FE_10_trend=.84 city_FE_11_trend=.84 city_FE_12_trend=.84 city_FE_13_trend=.84 city_FE_14_trend=.84 ///
city_FE_15_trend=.84 city_FE_16_trend=.84 city_FE_17_trend=.84 city_FE_18_trend=.84 city_FE_19_trend=.84 city_FE_20_trend=.84 city_FE_21_trend=.84 city_FE_22_trend=.84 ///
city_FE_23_trend=.84 city_FE_24_trend=.84 city_FE_25_trend=.84) ///
level(90) post

gen diarrhea_pred_1920 = _b[_cons]
gen diarrhea_lb_1920 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1920 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1920 diarrhea_lb_1920 diarrhea_ub_1920, after(diarrhea_mean_1920)





*************
*year = 1921
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.82 water_project=.24 sewage_treat_div=.2 TB_test=.6 bact_standard=.84 percent_female=.5010433 percent_nonwhite=.0836092 percent_foreign=.2017873 ///
percent_age_less15=.2594074 percent_age_15to44=.52489 percent_age_45plus=.2157026 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=1 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.88 city_FE_2_trend=.88 city_FE_3_trend=.88 city_FE_4_trend=.88 city_FE_5_trend=.88 city_FE_6_trend=.88 ///
city_FE_7_trend=.88 city_FE_8_trend=.88 city_FE_9_trend=.88 city_FE_10_trend=.88 city_FE_11_trend=.88 city_FE_12_trend=.88 city_FE_13_trend=.88 city_FE_14_trend=.88 ///
city_FE_15_trend=.88 city_FE_16_trend=.88 city_FE_17_trend=.88 city_FE_18_trend=.88 city_FE_19_trend=.88 city_FE_20_trend=.88 city_FE_21_trend=.88 city_FE_22_trend=.88 ///
city_FE_23_trend=.88 city_FE_24_trend=.88 city_FE_25_trend=.88) ///
level(90) post

gen mortality_under1_pred_1921 = _b[_cons]
gen mortality_under1_lb_1921 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1921 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1921 mortality_under1_lb_1921 mortality_under1_ub_1921, after(mortality_under1_mean_1921)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.82 water_project=.24 sewage_treat_div=.2 TB_test=.6 bact_standard=.84 percent_female=.5010433 percent_nonwhite=.0836092 percent_foreign=.2017873 ///
percent_age_less15=.2594074 percent_age_15to44=.52489 percent_age_45plus=.2157026 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=1 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.88 city_FE_2_trend=.88 city_FE_3_trend=.88 city_FE_4_trend=.88 city_FE_5_trend=.88 city_FE_6_trend=.88 ///
city_FE_7_trend=.88 city_FE_8_trend=.88 city_FE_9_trend=.88 city_FE_10_trend=.88 city_FE_11_trend=.88 city_FE_12_trend=.88 city_FE_13_trend=.88 city_FE_14_trend=.88 ///
city_FE_15_trend=.88 city_FE_16_trend=.88 city_FE_17_trend=.88 city_FE_18_trend=.88 city_FE_19_trend=.88 city_FE_20_trend=.88 city_FE_21_trend=.88 city_FE_22_trend=.88 ///
city_FE_23_trend=.88 city_FE_24_trend=.88 city_FE_25_trend=.88) ///
level(90) post

gen typhoid_pred_1921 = _b[_cons]
gen typhoid_lb_1921 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1921 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1921 typhoid_lb_1921 typhoid_ub_1921, after(typhoid_mean_1921)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.82 water_project=.24 sewage_treat_div=.2 TB_test=.6 bact_standard=.84 percent_female=.5010433 percent_nonwhite=.0836092 percent_foreign=.2017873 ///
percent_age_less15=.2594074 percent_age_15to44=.52489 percent_age_45plus=.2157026 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=1 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.88 city_FE_2_trend=.88 city_FE_3_trend=.88 city_FE_4_trend=.88 city_FE_5_trend=.88 city_FE_6_trend=.88 ///
city_FE_7_trend=.88 city_FE_8_trend=.88 city_FE_9_trend=.88 city_FE_10_trend=.88 city_FE_11_trend=.88 city_FE_12_trend=.88 city_FE_13_trend=.88 city_FE_14_trend=.88 ///
city_FE_15_trend=.88 city_FE_16_trend=.88 city_FE_17_trend=.88 city_FE_18_trend=.88 city_FE_19_trend=.88 city_FE_20_trend=.88 city_FE_21_trend=.88 city_FE_22_trend=.88 ///
city_FE_23_trend=.88 city_FE_24_trend=.88 city_FE_25_trend=.88) ///
level(90) post

gen diarrhea_pred_1921 = _b[_cons]
gen diarrhea_lb_1921 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1921 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1921 diarrhea_lb_1921 diarrhea_ub_1921, after(diarrhea_mean_1921)




*************
*year = 1922
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.88 water_project=.24 sewage_treat_div=.24 TB_test=.64 bact_standard=.84 percent_female=.501722 percent_nonwhite=.0855119 percent_foreign=.1985782 ///
percent_age_less15=.2576642 percent_age_15to44=.524369 percent_age_45plus=.2179668 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=1 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.92 city_FE_2_trend=.92 city_FE_3_trend=.92 city_FE_4_trend=.92 city_FE_5_trend=.92 city_FE_6_trend=.92 ///
city_FE_7_trend=.92 city_FE_8_trend=.92 city_FE_9_trend=.92 city_FE_10_trend=.92 city_FE_11_trend=.92 city_FE_12_trend=.92 city_FE_13_trend=.92 city_FE_14_trend=.92 ///
city_FE_15_trend=.92 city_FE_16_trend=.92 city_FE_17_trend=.92 city_FE_18_trend=.92 city_FE_19_trend=.92 city_FE_20_trend=.92 city_FE_21_trend=.92 city_FE_22_trend=.92 ///
city_FE_23_trend=.92 city_FE_24_trend=.92 city_FE_25_trend=.92) ///
level(90) post

gen mortality_under1_pred_1922 = _b[_cons]
gen mortality_under1_lb_1922 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1922 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1922 mortality_under1_lb_1922 mortality_under1_ub_1922, after(mortality_under1_mean_1922)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.88 water_project=.24 sewage_treat_div=.24 TB_test=.64 bact_standard=.84 percent_female=.501722 percent_nonwhite=.0855119 percent_foreign=.1985782 ///
percent_age_less15=.2576642 percent_age_15to44=.524369 percent_age_45plus=.2179668 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=1 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.92 city_FE_2_trend=.92 city_FE_3_trend=.92 city_FE_4_trend=.92 city_FE_5_trend=.92 city_FE_6_trend=.92 ///
city_FE_7_trend=.92 city_FE_8_trend=.92 city_FE_9_trend=.92 city_FE_10_trend=.92 city_FE_11_trend=.92 city_FE_12_trend=.92 city_FE_13_trend=.92 city_FE_14_trend=.92 ///
city_FE_15_trend=.92 city_FE_16_trend=.92 city_FE_17_trend=.92 city_FE_18_trend=.92 city_FE_19_trend=.92 city_FE_20_trend=.92 city_FE_21_trend=.92 city_FE_22_trend=.92 ///
city_FE_23_trend=.92 city_FE_24_trend=.92 city_FE_25_trend=.92) ///
level(90) post

gen typhoid_pred_1922 = _b[_cons]
gen typhoid_lb_1922 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1922 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1922 typhoid_lb_1922 typhoid_ub_1922, after(typhoid_mean_1922)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.88 water_project=.24 sewage_treat_div=.24 TB_test=.64 bact_standard=.84 percent_female=.501722 percent_nonwhite=.0855119 percent_foreign=.1985782 ///
percent_age_less15=.2576642 percent_age_15to44=.524369 percent_age_45plus=.2179668 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=1 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.92 city_FE_2_trend=.92 city_FE_3_trend=.92 city_FE_4_trend=.92 city_FE_5_trend=.92 city_FE_6_trend=.92 ///
city_FE_7_trend=.92 city_FE_8_trend=.92 city_FE_9_trend=.92 city_FE_10_trend=.92 city_FE_11_trend=.92 city_FE_12_trend=.92 city_FE_13_trend=.92 city_FE_14_trend=.92 ///
city_FE_15_trend=.92 city_FE_16_trend=.92 city_FE_17_trend=.92 city_FE_18_trend=.92 city_FE_19_trend=.92 city_FE_20_trend=.92 city_FE_21_trend=.92 city_FE_22_trend=.92 ///
city_FE_23_trend=.92 city_FE_24_trend=.92 city_FE_25_trend=.92) ///
level(90) post

gen diarrhea_pred_1922 = _b[_cons]
gen diarrhea_lb_1922 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1922 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1922 diarrhea_lb_1922 diarrhea_ub_1922, after(diarrhea_mean_1922)




*************
*year = 1923
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.92 water_project=.24 sewage_treat_div=.24 TB_test=.68 bact_standard=.92 percent_female=.5024008 percent_nonwhite=.0874147 percent_foreign=.195369 ///
percent_age_less15=.255921 percent_age_15to44=.5238481 percent_age_45plus=.220231 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=1 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.96 city_FE_2_trend=.96 city_FE_3_trend=.96 city_FE_4_trend=.96 city_FE_5_trend=.96 city_FE_6_trend=.96 ///
city_FE_7_trend=.96 city_FE_8_trend=.96 city_FE_9_trend=.96 city_FE_10_trend=.96 city_FE_11_trend=.96 city_FE_12_trend=.96 city_FE_13_trend=.96 city_FE_14_trend=.96 ///
city_FE_15_trend=.96 city_FE_16_trend=.96 city_FE_17_trend=.96 city_FE_18_trend=.96 city_FE_19_trend=.96 city_FE_20_trend=.96 city_FE_21_trend=.96 city_FE_22_trend=.96 ///
city_FE_23_trend=.96 city_FE_24_trend=.96 city_FE_25_trend=.96) ///
level(90) post

gen mortality_under1_pred_1923 = _b[_cons]
gen mortality_under1_lb_1923 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1923 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1923 mortality_under1_lb_1923 mortality_under1_ub_1923, after(mortality_under1_mean_1923)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.92 water_project=.24 sewage_treat_div=.24 TB_test=.68 bact_standard=.92 percent_female=.5024008 percent_nonwhite=.0874147 percent_foreign=.195369 ///
percent_age_less15=.255921 percent_age_15to44=.5238481 percent_age_45plus=.220231 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=1 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.96 city_FE_2_trend=.96 city_FE_3_trend=.96 city_FE_4_trend=.96 city_FE_5_trend=.96 city_FE_6_trend=.96 ///
city_FE_7_trend=.96 city_FE_8_trend=.96 city_FE_9_trend=.96 city_FE_10_trend=.96 city_FE_11_trend=.96 city_FE_12_trend=.96 city_FE_13_trend=.96 city_FE_14_trend=.96 ///
city_FE_15_trend=.96 city_FE_16_trend=.96 city_FE_17_trend=.96 city_FE_18_trend=.96 city_FE_19_trend=.96 city_FE_20_trend=.96 city_FE_21_trend=.96 city_FE_22_trend=.96 ///
city_FE_23_trend=.96 city_FE_24_trend=.96 city_FE_25_trend=.96) ///
level(90) post

gen typhoid_pred_1923 = _b[_cons]
gen typhoid_lb_1923 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1923 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1923 typhoid_lb_1923 typhoid_ub_1923, after(typhoid_mean_1923)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.92 water_project=.24 sewage_treat_div=.24 TB_test=.68 bact_standard=.92 percent_female=.5024008 percent_nonwhite=.0874147 percent_foreign=.195369 ///
percent_age_less15=.255921 percent_age_15to44=.5238481 percent_age_45plus=.220231 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=1 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=.96 city_FE_2_trend=.96 city_FE_3_trend=.96 city_FE_4_trend=.96 city_FE_5_trend=.96 city_FE_6_trend=.96 ///
city_FE_7_trend=.96 city_FE_8_trend=.96 city_FE_9_trend=.96 city_FE_10_trend=.96 city_FE_11_trend=.96 city_FE_12_trend=.96 city_FE_13_trend=.96 city_FE_14_trend=.96 ///
city_FE_15_trend=.96 city_FE_16_trend=.96 city_FE_17_trend=.96 city_FE_18_trend=.96 city_FE_19_trend=.96 city_FE_20_trend=.96 city_FE_21_trend=.96 city_FE_22_trend=.96 ///
city_FE_23_trend=.96 city_FE_24_trend=.96 city_FE_25_trend=.96) ///
level(90) post

gen diarrhea_pred_1923 = _b[_cons]
gen diarrhea_lb_1923 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1923 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1923 diarrhea_lb_1923 diarrhea_ub_1923, after(diarrhea_mean_1923)




*************
*year = 1924
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.92 water_project=.24 sewage_treat_div=.32 TB_test=.7036 bact_standard=.92 percent_female=.5030795 percent_nonwhite=.0893174 percent_foreign=.1921599 ///
percent_age_less15=.2541778 percent_age_15to44=.5233271 percent_age_45plus=.2224952 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=1 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1 city_FE_2_trend=1 city_FE_3_trend=1 city_FE_4_trend=1 city_FE_5_trend=1 city_FE_6_trend=1 ///
city_FE_7_trend=1 city_FE_8_trend=1 city_FE_9_trend=1 city_FE_10_trend=1 city_FE_11_trend=1 city_FE_12_trend=1 city_FE_13_trend=1 city_FE_14_trend=1 ///
city_FE_15_trend=1 city_FE_16_trend=1 city_FE_17_trend=1 city_FE_18_trend=1 city_FE_19_trend=1 city_FE_20_trend=1 city_FE_21_trend=1 city_FE_22_trend=1 ///
city_FE_23_trend=1 city_FE_24_trend=1 city_FE_25_trend=1) ///
level(90) post

gen mortality_under1_pred_1924 = _b[_cons]
gen mortality_under1_lb_1924 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1924 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1924 mortality_under1_lb_1924 mortality_under1_ub_1924, after(mortality_under1_mean_1924)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.92 water_project=.24 sewage_treat_div=.32 TB_test=.7036 bact_standard=.92 percent_female=.5030795 percent_nonwhite=.0893174 percent_foreign=.1921599 ///
percent_age_less15=.2541778 percent_age_15to44=.5233271 percent_age_45plus=.2224952 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=1 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1 city_FE_2_trend=1 city_FE_3_trend=1 city_FE_4_trend=1 city_FE_5_trend=1 city_FE_6_trend=1 ///
city_FE_7_trend=1 city_FE_8_trend=1 city_FE_9_trend=1 city_FE_10_trend=1 city_FE_11_trend=1 city_FE_12_trend=1 city_FE_13_trend=1 city_FE_14_trend=1 ///
city_FE_15_trend=1 city_FE_16_trend=1 city_FE_17_trend=1 city_FE_18_trend=1 city_FE_19_trend=1 city_FE_20_trend=1 city_FE_21_trend=1 city_FE_22_trend=1 ///
city_FE_23_trend=1 city_FE_24_trend=1 city_FE_25_trend=1) ///
level(90) post

gen typhoid_pred_1924 = _b[_cons]
gen typhoid_lb_1924 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1924 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1924 typhoid_lb_1924 typhoid_ub_1924, after(typhoid_mean_1924)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.92 water_project=.24 sewage_treat_div=.32 TB_test=.7036 bact_standard=.92 percent_female=.5030795 percent_nonwhite=.0893174 percent_foreign=.1921599 ///
percent_age_less15=.2541778 percent_age_15to44=.5233271 percent_age_45plus=.2224952 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=1 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1 city_FE_2_trend=1 city_FE_3_trend=1 city_FE_4_trend=1 city_FE_5_trend=1 city_FE_6_trend=1 ///
city_FE_7_trend=1 city_FE_8_trend=1 city_FE_9_trend=1 city_FE_10_trend=1 city_FE_11_trend=1 city_FE_12_trend=1 city_FE_13_trend=1 city_FE_14_trend=1 ///
city_FE_15_trend=1 city_FE_16_trend=1 city_FE_17_trend=1 city_FE_18_trend=1 city_FE_19_trend=1 city_FE_20_trend=1 city_FE_21_trend=1 city_FE_22_trend=1 ///
city_FE_23_trend=1 city_FE_24_trend=1 city_FE_25_trend=1) ///
level(90) post

gen diarrhea_pred_1924 = _b[_cons]
gen diarrhea_lb_1924 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1924 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1924 diarrhea_lb_1924 diarrhea_ub_1924, after(diarrhea_mean_1924)




*************
*year = 1925
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.9456 water_project=.24 sewage_treat_div=.36732 TB_test=.7252 bact_standard=.92 percent_female=.5037583 percent_nonwhite=.0912201 percent_foreign=.1889508 ///
percent_age_less15=.2524346 percent_age_15to44=.522806 percent_age_45plus=.2247594 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=1 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.04 city_FE_2_trend=1.04 city_FE_3_trend=1.04 city_FE_4_trend=1.04 city_FE_5_trend=1.04 city_FE_6_trend=1.04 ///
city_FE_7_trend=1.04 city_FE_8_trend=1.04 city_FE_9_trend=1.04 city_FE_10_trend=1.04 city_FE_11_trend=1.04 city_FE_12_trend=1.04 city_FE_13_trend=1.04 city_FE_14_trend=1.04 ///
city_FE_15_trend=1.04 city_FE_16_trend=1.04 city_FE_17_trend=1.04 city_FE_18_trend=1.04 city_FE_19_trend=1.04 city_FE_20_trend=1.04 city_FE_21_trend=1.04 city_FE_22_trend=1.04 ///
city_FE_23_trend=1.04 city_FE_24_trend=1.04 city_FE_25_trend=1.04) ///
level(90) post

gen mortality_under1_pred_1925 = _b[_cons]
gen mortality_under1_lb_1925 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1925 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1925 mortality_under1_lb_1925 mortality_under1_ub_1925, after(mortality_under1_mean_1925)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.9456 water_project=.24 sewage_treat_div=.36732 TB_test=.7252 bact_standard=.92 percent_female=.5037583 percent_nonwhite=.0912201 percent_foreign=.1889508 ///
percent_age_less15=.2524346 percent_age_15to44=.522806 percent_age_45plus=.2247594 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=1 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.04 city_FE_2_trend=1.04 city_FE_3_trend=1.04 city_FE_4_trend=1.04 city_FE_5_trend=1.04 city_FE_6_trend=1.04 ///
city_FE_7_trend=1.04 city_FE_8_trend=1.04 city_FE_9_trend=1.04 city_FE_10_trend=1.04 city_FE_11_trend=1.04 city_FE_12_trend=1.04 city_FE_13_trend=1.04 city_FE_14_trend=1.04 ///
city_FE_15_trend=1.04 city_FE_16_trend=1.04 city_FE_17_trend=1.04 city_FE_18_trend=1.04 city_FE_19_trend=1.04 city_FE_20_trend=1.04 city_FE_21_trend=1.04 city_FE_22_trend=1.04 ///
city_FE_23_trend=1.04 city_FE_24_trend=1.04 city_FE_25_trend=1.04) ///
level(90) post

gen typhoid_pred_1925 = _b[_cons]
gen typhoid_lb_1925 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1925 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1925 typhoid_lb_1925 typhoid_ub_1925, after(typhoid_mean_1925)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.9456 water_project=.24 sewage_treat_div=.36732 TB_test=.7252 bact_standard=.92 percent_female=.5037583 percent_nonwhite=.0912201 percent_foreign=.1889508 ///
percent_age_less15=.2524346 percent_age_15to44=.522806 percent_age_45plus=.2247594 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=1 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.04 city_FE_2_trend=1.04 city_FE_3_trend=1.04 city_FE_4_trend=1.04 city_FE_5_trend=1.04 city_FE_6_trend=1.04 ///
city_FE_7_trend=1.04 city_FE_8_trend=1.04 city_FE_9_trend=1.04 city_FE_10_trend=1.04 city_FE_11_trend=1.04 city_FE_12_trend=1.04 city_FE_13_trend=1.04 city_FE_14_trend=1.04 ///
city_FE_15_trend=1.04 city_FE_16_trend=1.04 city_FE_17_trend=1.04 city_FE_18_trend=1.04 city_FE_19_trend=1.04 city_FE_20_trend=1.04 city_FE_21_trend=1.04 city_FE_22_trend=1.04 ///
city_FE_23_trend=1.04 city_FE_24_trend=1.04 city_FE_25_trend=1.04) ///
level(90) post

gen diarrhea_pred_1925 = _b[_cons]
gen diarrhea_lb_1925 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1925 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1925 diarrhea_lb_1925 diarrhea_ub_1925, after(diarrhea_mean_1925)




*************
*year = 1926
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.96 water_project=.25 sewage_treat_div=.4 TB_test=.76 bact_standard=.92 percent_female=.504437 percent_nonwhite=.0931228 percent_foreign=.1857416 ///
percent_age_less15=.2506914 percent_age_15to44=.522285 percent_age_45plus=.2270236 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=1 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.08 city_FE_2_trend=1.08 city_FE_3_trend=1.08 city_FE_4_trend=1.08 city_FE_5_trend=1.08 city_FE_6_trend=1.08 ///
city_FE_7_trend=1.08 city_FE_8_trend=1.08 city_FE_9_trend=1.08 city_FE_10_trend=1.08 city_FE_11_trend=1.08 city_FE_12_trend=1.08 city_FE_13_trend=1.08 city_FE_14_trend=1.08 ///
city_FE_15_trend=1.08 city_FE_16_trend=1.08 city_FE_17_trend=1.08 city_FE_18_trend=1.08 city_FE_19_trend=1.08 city_FE_20_trend=1.08 city_FE_21_trend=1.08 city_FE_22_trend=1.08 ///
city_FE_23_trend=1.08 city_FE_24_trend=1.08 city_FE_25_trend=1.08) ///
level(90) post

gen mortality_under1_pred_1926 = _b[_cons]
gen mortality_under1_lb_1926 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1926 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1926 mortality_under1_lb_1926 mortality_under1_ub_1926, after(mortality_under1_mean_1926)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.96 water_project=.25 sewage_treat_div=.4 TB_test=.76 bact_standard=.92 percent_female=.504437 percent_nonwhite=.0931228 percent_foreign=.1857416 ///
percent_age_less15=.2506914 percent_age_15to44=.522285 percent_age_45plus=.2270236 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=1 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.08 city_FE_2_trend=1.08 city_FE_3_trend=1.08 city_FE_4_trend=1.08 city_FE_5_trend=1.08 city_FE_6_trend=1.08 ///
city_FE_7_trend=1.08 city_FE_8_trend=1.08 city_FE_9_trend=1.08 city_FE_10_trend=1.08 city_FE_11_trend=1.08 city_FE_12_trend=1.08 city_FE_13_trend=1.08 city_FE_14_trend=1.08 ///
city_FE_15_trend=1.08 city_FE_16_trend=1.08 city_FE_17_trend=1.08 city_FE_18_trend=1.08 city_FE_19_trend=1.08 city_FE_20_trend=1.08 city_FE_21_trend=1.08 city_FE_22_trend=1.08 ///
city_FE_23_trend=1.08 city_FE_24_trend=1.08 city_FE_25_trend=1.08) ///
level(90) post

gen typhoid_pred_1926 = _b[_cons]
gen typhoid_lb_1926 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1926 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1926 typhoid_lb_1926 typhoid_ub_1926, after(typhoid_mean_1926)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.96 water_project=.25 sewage_treat_div=.4 TB_test=.76 bact_standard=.92 percent_female=.504437 percent_nonwhite=.0931228 percent_foreign=.1857416 ///
percent_age_less15=.2506914 percent_age_15to44=.522285 percent_age_45plus=.2270236 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=1 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.08 city_FE_2_trend=1.08 city_FE_3_trend=1.08 city_FE_4_trend=1.08 city_FE_5_trend=1.08 city_FE_6_trend=1.08 ///
city_FE_7_trend=1.08 city_FE_8_trend=1.08 city_FE_9_trend=1.08 city_FE_10_trend=1.08 city_FE_11_trend=1.08 city_FE_12_trend=1.08 city_FE_13_trend=1.08 city_FE_14_trend=1.08 ///
city_FE_15_trend=1.08 city_FE_16_trend=1.08 city_FE_17_trend=1.08 city_FE_18_trend=1.08 city_FE_19_trend=1.08 city_FE_20_trend=1.08 city_FE_21_trend=1.08 city_FE_22_trend=1.08 ///
city_FE_23_trend=1.08 city_FE_24_trend=1.08 city_FE_25_trend=1.08) ///
level(90) post

gen diarrhea_pred_1926 = _b[_cons]
gen diarrhea_lb_1926 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1926 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1926 diarrhea_lb_1926 diarrhea_ub_1926, after(diarrhea_mean_1926)




*************
*year = 1927
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.96 water_project=.28 sewage_treat_div=.4 TB_test=.76 bact_standard=.92 percent_female=.5051157 percent_nonwhite=.0950255 percent_foreign=.1825325 ///
percent_age_less15=.2489481 percent_age_15to44=.521764 percent_age_45plus=.2292878 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=1 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.12 city_FE_2_trend=1.12 city_FE_3_trend=1.12 city_FE_4_trend=1.12 city_FE_5_trend=1.12 city_FE_6_trend=1.12 ///
city_FE_7_trend=1.12 city_FE_8_trend=1.12 city_FE_9_trend=1.12 city_FE_10_trend=1.12 city_FE_11_trend=1.12 city_FE_12_trend=1.12 city_FE_13_trend=1.12 city_FE_14_trend=1.12 ///
city_FE_15_trend=1.12 city_FE_16_trend=1.12 city_FE_17_trend=1.12 city_FE_18_trend=1.12 city_FE_19_trend=1.12 city_FE_20_trend=1.12 city_FE_21_trend=1.12 city_FE_22_trend=1.12 ///
city_FE_23_trend=1.12 city_FE_24_trend=1.12 city_FE_25_trend=1.12) ///
level(90) post

gen mortality_under1_pred_1927 = _b[_cons]
gen mortality_under1_lb_1927 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1927 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1927 mortality_under1_lb_1927 mortality_under1_ub_1927, after(mortality_under1_mean_1927)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.96 water_project=.28 sewage_treat_div=.4 TB_test=.76 bact_standard=.92 percent_female=.5051157 percent_nonwhite=.0950255 percent_foreign=.1825325 ///
percent_age_less15=.2489481 percent_age_15to44=.521764 percent_age_45plus=.2292878 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=1 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.12 city_FE_2_trend=1.12 city_FE_3_trend=1.12 city_FE_4_trend=1.12 city_FE_5_trend=1.12 city_FE_6_trend=1.12 ///
city_FE_7_trend=1.12 city_FE_8_trend=1.12 city_FE_9_trend=1.12 city_FE_10_trend=1.12 city_FE_11_trend=1.12 city_FE_12_trend=1.12 city_FE_13_trend=1.12 city_FE_14_trend=1.12 ///
city_FE_15_trend=1.12 city_FE_16_trend=1.12 city_FE_17_trend=1.12 city_FE_18_trend=1.12 city_FE_19_trend=1.12 city_FE_20_trend=1.12 city_FE_21_trend=1.12 city_FE_22_trend=1.12 ///
city_FE_23_trend=1.12 city_FE_24_trend=1.12 city_FE_25_trend=1.12) ///
level(90) post

gen typhoid_pred_1927 = _b[_cons]
gen typhoid_lb_1927 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1927 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1927 typhoid_lb_1927 typhoid_ub_1927, after(typhoid_mean_1927)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=.96 water_project=.28 sewage_treat_div=.4 TB_test=.76 bact_standard=.92 percent_female=.5051157 percent_nonwhite=.0950255 percent_foreign=.1825325 ///
percent_age_less15=.2489481 percent_age_15to44=.521764 percent_age_45plus=.2292878 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=1 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.12 city_FE_2_trend=1.12 city_FE_3_trend=1.12 city_FE_4_trend=1.12 city_FE_5_trend=1.12 city_FE_6_trend=1.12 ///
city_FE_7_trend=1.12 city_FE_8_trend=1.12 city_FE_9_trend=1.12 city_FE_10_trend=1.12 city_FE_11_trend=1.12 city_FE_12_trend=1.12 city_FE_13_trend=1.12 city_FE_14_trend=1.12 ///
city_FE_15_trend=1.12 city_FE_16_trend=1.12 city_FE_17_trend=1.12 city_FE_18_trend=1.12 city_FE_19_trend=1.12 city_FE_20_trend=1.12 city_FE_21_trend=1.12 city_FE_22_trend=1.12 ///
city_FE_23_trend=1.12 city_FE_24_trend=1.12 city_FE_25_trend=1.12) ///
level(90) post

gen diarrhea_pred_1927 = _b[_cons]
gen diarrhea_lb_1927 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1927 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1927 diarrhea_lb_1927 diarrhea_ub_1927, after(diarrhea_mean_1927)




*************
*year = 1928
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.28 sewage_treat_div=.4 TB_test=.7912 bact_standard=.92 percent_female=.5057944 percent_nonwhite=.0969282 percent_foreign=.1793233 ///
percent_age_less15=.2472049 percent_age_15to44=.521243 percent_age_45plus=.231552 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=1 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.16 city_FE_2_trend=1.16 city_FE_3_trend=1.16 city_FE_4_trend=1.16 city_FE_5_trend=1.16 city_FE_6_trend=1.16 ///
city_FE_7_trend=1.16 city_FE_8_trend=1.16 city_FE_9_trend=1.16 city_FE_10_trend=1.16 city_FE_11_trend=1.16 city_FE_12_trend=1.16 city_FE_13_trend=1.16 city_FE_14_trend=1.16 ///
city_FE_15_trend=1.16 city_FE_16_trend=1.16 city_FE_17_trend=1.16 city_FE_18_trend=1.16 city_FE_19_trend=1.16 city_FE_20_trend=1.16 city_FE_21_trend=1.16 city_FE_22_trend=1.16 ///
city_FE_23_trend=1.16 city_FE_24_trend=1.16 city_FE_25_trend=1.16) ///
level(90) post

gen mortality_under1_pred_1928 = _b[_cons]
gen mortality_under1_lb_1928 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1928 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1928 mortality_under1_lb_1928 mortality_under1_ub_1928, after(mortality_under1_mean_1928)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.28 sewage_treat_div=.4 TB_test=.7912 bact_standard=.92 percent_female=.5057944 percent_nonwhite=.0969282 percent_foreign=.1793233 ///
percent_age_less15=.2472049 percent_age_15to44=.521243 percent_age_45plus=.231552 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=1 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.16 city_FE_2_trend=1.16 city_FE_3_trend=1.16 city_FE_4_trend=1.16 city_FE_5_trend=1.16 city_FE_6_trend=1.16 ///
city_FE_7_trend=1.16 city_FE_8_trend=1.16 city_FE_9_trend=1.16 city_FE_10_trend=1.16 city_FE_11_trend=1.16 city_FE_12_trend=1.16 city_FE_13_trend=1.16 city_FE_14_trend=1.16 ///
city_FE_15_trend=1.16 city_FE_16_trend=1.16 city_FE_17_trend=1.16 city_FE_18_trend=1.16 city_FE_19_trend=1.16 city_FE_20_trend=1.16 city_FE_21_trend=1.16 city_FE_22_trend=1.16 ///
city_FE_23_trend=1.16 city_FE_24_trend=1.16 city_FE_25_trend=1.16) ///
level(90) post

gen typhoid_pred_1928 = _b[_cons]
gen typhoid_lb_1928 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1928 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1928 typhoid_lb_1928 typhoid_ub_1928, after(typhoid_mean_1928)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.28 sewage_treat_div=.4 TB_test=.7912 bact_standard=.92 percent_female=.5057944 percent_nonwhite=.0969282 percent_foreign=.1793233 ///
percent_age_less15=.2472049 percent_age_15to44=.521243 percent_age_45plus=.231552 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=1 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.16 city_FE_2_trend=1.16 city_FE_3_trend=1.16 city_FE_4_trend=1.16 city_FE_5_trend=1.16 city_FE_6_trend=1.16 ///
city_FE_7_trend=1.16 city_FE_8_trend=1.16 city_FE_9_trend=1.16 city_FE_10_trend=1.16 city_FE_11_trend=1.16 city_FE_12_trend=1.16 city_FE_13_trend=1.16 city_FE_14_trend=1.16 ///
city_FE_15_trend=1.16 city_FE_16_trend=1.16 city_FE_17_trend=1.16 city_FE_18_trend=1.16 city_FE_19_trend=1.16 city_FE_20_trend=1.16 city_FE_21_trend=1.16 city_FE_22_trend=1.16 ///
city_FE_23_trend=1.16 city_FE_24_trend=1.16 city_FE_25_trend=1.16) ///
level(90) post

gen diarrhea_pred_1928 = _b[_cons]
gen diarrhea_lb_1928 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1928 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1928 diarrhea_lb_1928 diarrhea_ub_1928, after(diarrhea_mean_1928)




*************
*year = 1929
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.28 sewage_treat_div=.4 TB_test=.8 bact_standard=.92 percent_female=.5064731 percent_nonwhite=.098831 percent_foreign=.1761142 ///
percent_age_less15=.2454617 percent_age_15to44=.520722 percent_age_45plus=.2338162 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=1 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.20 city_FE_2_trend=1.20 city_FE_3_trend=1.20 city_FE_4_trend=1.20 city_FE_5_trend=1.20 city_FE_6_trend=1.20 ///
city_FE_7_trend=1.20 city_FE_8_trend=1.20 city_FE_9_trend=1.20 city_FE_10_trend=1.20 city_FE_11_trend=1.20 city_FE_12_trend=1.20 city_FE_13_trend=1.20 city_FE_14_trend=1.20 ///
city_FE_15_trend=1.20 city_FE_16_trend=1.20 city_FE_17_trend=1.20 city_FE_18_trend=1.20 city_FE_19_trend=1.20 city_FE_20_trend=1.20 city_FE_21_trend=1.20 city_FE_22_trend=1.20 ///
city_FE_23_trend=1.20 city_FE_24_trend=1.20 city_FE_25_trend=1.20) ///
level(90) post

gen mortality_under1_pred_1929 = _b[_cons]
gen mortality_under1_lb_1929 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1929 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1929 mortality_under1_lb_1929 mortality_under1_ub_1929, after(mortality_under1_mean_1929)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.28 sewage_treat_div=.4 TB_test=.8 bact_standard=.92 percent_female=.5064731 percent_nonwhite=.098831 percent_foreign=.1761142 ///
percent_age_less15=.2454617 percent_age_15to44=.520722 percent_age_45plus=.2338162 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=1 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.20 city_FE_2_trend=1.20 city_FE_3_trend=1.20 city_FE_4_trend=1.20 city_FE_5_trend=1.20 city_FE_6_trend=1.20 ///
city_FE_7_trend=1.20 city_FE_8_trend=1.20 city_FE_9_trend=1.20 city_FE_10_trend=1.20 city_FE_11_trend=1.20 city_FE_12_trend=1.20 city_FE_13_trend=1.20 city_FE_14_trend=1.20 ///
city_FE_15_trend=1.20 city_FE_16_trend=1.20 city_FE_17_trend=1.20 city_FE_18_trend=1.20 city_FE_19_trend=1.20 city_FE_20_trend=1.20 city_FE_21_trend=1.20 city_FE_22_trend=1.20 ///
city_FE_23_trend=1.20 city_FE_24_trend=1.20 city_FE_25_trend=1.20) ///
level(90) post

gen typhoid_pred_1929 = _b[_cons]
gen typhoid_lb_1929 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1929 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1929 typhoid_lb_1929 typhoid_ub_1929, after(typhoid_mean_1929)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.28 sewage_treat_div=.4 TB_test=.8 bact_standard=.92 percent_female=.5064731 percent_nonwhite=.098831 percent_foreign=.1761142 ///
percent_age_less15=.2454617 percent_age_15to44=.520722 percent_age_45plus=.2338162 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=1 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.20 city_FE_2_trend=1.20 city_FE_3_trend=1.20 city_FE_4_trend=1.20 city_FE_5_trend=1.20 city_FE_6_trend=1.20 ///
city_FE_7_trend=1.20 city_FE_8_trend=1.20 city_FE_9_trend=1.20 city_FE_10_trend=1.20 city_FE_11_trend=1.20 city_FE_12_trend=1.20 city_FE_13_trend=1.20 city_FE_14_trend=1.20 ///
city_FE_15_trend=1.20 city_FE_16_trend=1.20 city_FE_17_trend=1.20 city_FE_18_trend=1.20 city_FE_19_trend=1.20 city_FE_20_trend=1.20 city_FE_21_trend=1.20 city_FE_22_trend=1.20 ///
city_FE_23_trend=1.20 city_FE_24_trend=1.20 city_FE_25_trend=1.20) ///
level(90) post

gen diarrhea_pred_1929 = _b[_cons]
gen diarrhea_lb_1929 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1929 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1929 diarrhea_lb_1929 diarrhea_ub_1929, after(diarrhea_mean_1929)





*************
*year = 1930
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.31112 sewage_treat_div=.4 TB_test=.8268 bact_standard=.92 percent_female=.5071518 percent_nonwhite=.1007337 percent_foreign=.1729051 ///
percent_age_less15=.2437185 percent_age_15to44=.5202011 percent_age_45plus=.2360804 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=1 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.24 city_FE_2_trend=1.24 city_FE_3_trend=1.24 city_FE_4_trend=1.24 city_FE_5_trend=1.24 city_FE_6_trend=1.24 ///
city_FE_7_trend=1.24 city_FE_8_trend=1.24 city_FE_9_trend=1.24 city_FE_10_trend=1.24 city_FE_11_trend=1.24 city_FE_12_trend=1.24 city_FE_13_trend=1.24 city_FE_14_trend=1.24 ///
city_FE_15_trend=1.24 city_FE_16_trend=1.24 city_FE_17_trend=1.24 city_FE_18_trend=1.24 city_FE_19_trend=1.24 city_FE_20_trend=1.24 city_FE_21_trend=1.24 city_FE_22_trend=1.24 ///
city_FE_23_trend=1.24 city_FE_24_trend=1.24 city_FE_25_trend=1.24) ///
level(90) post

gen mortality_under1_pred_1930 = _b[_cons]
gen mortality_under1_lb_1930 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1930 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1930 mortality_under1_lb_1930 mortality_under1_ub_1930, after(mortality_under1_mean_1930)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.31112 sewage_treat_div=.4 TB_test=.8268 bact_standard=.92 percent_female=.5071518 percent_nonwhite=.1007337 percent_foreign=.1729051 ///
percent_age_less15=.2437185 percent_age_15to44=.5202011 percent_age_45plus=.2360804 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=1 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.24 city_FE_2_trend=1.24 city_FE_3_trend=1.24 city_FE_4_trend=1.24 city_FE_5_trend=1.24 city_FE_6_trend=1.24 ///
city_FE_7_trend=1.24 city_FE_8_trend=1.24 city_FE_9_trend=1.24 city_FE_10_trend=1.24 city_FE_11_trend=1.24 city_FE_12_trend=1.24 city_FE_13_trend=1.24 city_FE_14_trend=1.24 ///
city_FE_15_trend=1.24 city_FE_16_trend=1.24 city_FE_17_trend=1.24 city_FE_18_trend=1.24 city_FE_19_trend=1.24 city_FE_20_trend=1.24 city_FE_21_trend=1.24 city_FE_22_trend=1.24 ///
city_FE_23_trend=1.24 city_FE_24_trend=1.24 city_FE_25_trend=1.24) ///
level(90) post

gen typhoid_pred_1930 = _b[_cons]
gen typhoid_lb_1930 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1930 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1930 typhoid_lb_1930 typhoid_ub_1930, after(typhoid_mean_1930)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.31112 sewage_treat_div=.4 TB_test=.8268 bact_standard=.92 percent_female=.5071518 percent_nonwhite=.1007337 percent_foreign=.1729051 ///
percent_age_less15=.2437185 percent_age_15to44=.5202011 percent_age_45plus=.2360804 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=1 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.24 city_FE_2_trend=1.24 city_FE_3_trend=1.24 city_FE_4_trend=1.24 city_FE_5_trend=1.24 city_FE_6_trend=1.24 ///
city_FE_7_trend=1.24 city_FE_8_trend=1.24 city_FE_9_trend=1.24 city_FE_10_trend=1.24 city_FE_11_trend=1.24 city_FE_12_trend=1.24 city_FE_13_trend=1.24 city_FE_14_trend=1.24 ///
city_FE_15_trend=1.24 city_FE_16_trend=1.24 city_FE_17_trend=1.24 city_FE_18_trend=1.24 city_FE_19_trend=1.24 city_FE_20_trend=1.24 city_FE_21_trend=1.24 city_FE_22_trend=1.24 ///
city_FE_23_trend=1.24 city_FE_24_trend=1.24 city_FE_25_trend=1.24) ///
level(90) post


gen diarrhea_pred_1930 = _b[_cons]
gen diarrhea_lb_1930 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1930 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1930 diarrhea_lb_1930 diarrhea_ub_1930, after(diarrhea_mean_1930)



*************
*year = 1931
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.32 sewage_treat_div=.4 TB_test=.84 bact_standard=.92 percent_female=.5076317 percent_nonwhite=.1015305 percent_foreign=.1631675 ///
percent_age_less15=.2409364 percent_age_15to44=.5189793 percent_age_45plus=.2400891 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=1 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.28 city_FE_2_trend=1.28 city_FE_3_trend=1.28 city_FE_4_trend=1.28 city_FE_5_trend=1.28 city_FE_6_trend=1.28 ///
city_FE_7_trend=1.28 city_FE_8_trend=1.28 city_FE_9_trend=1.28 city_FE_10_trend=1.28 city_FE_11_trend=1.28 city_FE_12_trend=1.28 city_FE_13_trend=1.28 city_FE_14_trend=1.28 ///
city_FE_15_trend=1.28 city_FE_16_trend=1.28 city_FE_17_trend=1.28 city_FE_18_trend=1.28 city_FE_19_trend=1.28 city_FE_20_trend=1.28 city_FE_21_trend=1.28 city_FE_22_trend=1.28 ///
city_FE_23_trend=1.28 city_FE_24_trend=1.28 city_FE_25_trend=1.28) ///
level(90) post

gen mortality_under1_pred_1931 = _b[_cons]
gen mortality_under1_lb_1931 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1931 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1931 mortality_under1_lb_1931 mortality_under1_ub_1931, after(mortality_under1_mean_1931)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.32 sewage_treat_div=.4 TB_test=.84 bact_standard=.92 percent_female=.5076317 percent_nonwhite=.1015305 percent_foreign=.1631675 ///
percent_age_less15=.2409364 percent_age_15to44=.5189793 percent_age_45plus=.2400891 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=1 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.28 city_FE_2_trend=1.28 city_FE_3_trend=1.28 city_FE_4_trend=1.28 city_FE_5_trend=1.28 city_FE_6_trend=1.28 ///
city_FE_7_trend=1.28 city_FE_8_trend=1.28 city_FE_9_trend=1.28 city_FE_10_trend=1.28 city_FE_11_trend=1.28 city_FE_12_trend=1.28 city_FE_13_trend=1.28 city_FE_14_trend=1.28 ///
city_FE_15_trend=1.28 city_FE_16_trend=1.28 city_FE_17_trend=1.28 city_FE_18_trend=1.28 city_FE_19_trend=1.28 city_FE_20_trend=1.28 city_FE_21_trend=1.28 city_FE_22_trend=1.28 ///
city_FE_23_trend=1.28 city_FE_24_trend=1.28 city_FE_25_trend=1.28) ///
level(90) post

gen typhoid_pred_1931 = _b[_cons]
gen typhoid_lb_1931 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1931 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1931 typhoid_lb_1931 typhoid_ub_1931, after(typhoid_mean_1931)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.32 sewage_treat_div=.4 TB_test=.84 bact_standard=.92 percent_female=.5076317 percent_nonwhite=.1015305 percent_foreign=.1631675 ///
percent_age_less15=.2409364 percent_age_15to44=.5189793 percent_age_45plus=.2400891 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=1 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.28 city_FE_2_trend=1.28 city_FE_3_trend=1.28 city_FE_4_trend=1.28 city_FE_5_trend=1.28 city_FE_6_trend=1.28 ///
city_FE_7_trend=1.28 city_FE_8_trend=1.28 city_FE_9_trend=1.28 city_FE_10_trend=1.28 city_FE_11_trend=1.28 city_FE_12_trend=1.28 city_FE_13_trend=1.28 city_FE_14_trend=1.28 ///
city_FE_15_trend=1.28 city_FE_16_trend=1.28 city_FE_17_trend=1.28 city_FE_18_trend=1.28 city_FE_19_trend=1.28 city_FE_20_trend=1.28 city_FE_21_trend=1.28 city_FE_22_trend=1.28 ///
city_FE_23_trend=1.28 city_FE_24_trend=1.28 city_FE_25_trend=1.28) ///
level(90) post


gen diarrhea_pred_1931 = _b[_cons]
gen diarrhea_lb_1931 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1931 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1931 diarrhea_lb_1931 diarrhea_ub_1931, after(diarrhea_mean_1931)




*************
*year = 1932
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.32 sewage_treat_div=.4 TB_test=.8668 bact_standard=.9468 percent_female=.5081117 percent_nonwhite=.1023273 percent_foreign=.1534301 ///
percent_age_less15=.2381543 percent_age_15to44=.5177575 percent_age_45plus=.2440979 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=1 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.32 city_FE_2_trend=1.32 city_FE_3_trend=1.32 city_FE_4_trend=1.32 city_FE_5_trend=1.32 city_FE_6_trend=1.32 ///
city_FE_7_trend=1.32 city_FE_8_trend=1.32 city_FE_9_trend=1.32 city_FE_10_trend=1.32 city_FE_11_trend=1.32 city_FE_12_trend=1.32 city_FE_13_trend=1.32 city_FE_14_trend=1.32 ///
city_FE_15_trend=1.32 city_FE_16_trend=1.32 city_FE_17_trend=1.32 city_FE_18_trend=1.32 city_FE_19_trend=1.32 city_FE_20_trend=1.32 city_FE_21_trend=1.32 city_FE_22_trend=1.32 ///
city_FE_23_trend=1.32 city_FE_24_trend=1.32 city_FE_25_trend=1.32) ///
level(90) post

gen mortality_under1_pred_1932 = _b[_cons]
gen mortality_under1_lb_1932 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1932 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1932 mortality_under1_lb_1932 mortality_under1_ub_1932, after(mortality_under1_mean_1932)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.32 sewage_treat_div=.4 TB_test=.8668 bact_standard=.9468 percent_female=.5081117 percent_nonwhite=.1023273 percent_foreign=.1534301 ///
percent_age_less15=.2381543 percent_age_15to44=.5177575 percent_age_45plus=.2440979 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=1 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.32 city_FE_2_trend=1.32 city_FE_3_trend=1.32 city_FE_4_trend=1.32 city_FE_5_trend=1.32 city_FE_6_trend=1.32 ///
city_FE_7_trend=1.32 city_FE_8_trend=1.32 city_FE_9_trend=1.32 city_FE_10_trend=1.32 city_FE_11_trend=1.32 city_FE_12_trend=1.32 city_FE_13_trend=1.32 city_FE_14_trend=1.32 ///
city_FE_15_trend=1.32 city_FE_16_trend=1.32 city_FE_17_trend=1.32 city_FE_18_trend=1.32 city_FE_19_trend=1.32 city_FE_20_trend=1.32 city_FE_21_trend=1.32 city_FE_22_trend=1.32 ///
city_FE_23_trend=1.32 city_FE_24_trend=1.32 city_FE_25_trend=1.32) ///
level(90) post

gen typhoid_pred_1932 = _b[_cons]
gen typhoid_lb_1932 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1932 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1932 typhoid_lb_1932 typhoid_ub_1932, after(typhoid_mean_1932)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.32 sewage_treat_div=.4 TB_test=.8668 bact_standard=.9468 percent_female=.5081117 percent_nonwhite=.1023273 percent_foreign=.1534301 ///
percent_age_less15=.2381543 percent_age_15to44=.5177575 percent_age_45plus=.2440979 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=1 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.32 city_FE_2_trend=1.32 city_FE_3_trend=1.32 city_FE_4_trend=1.32 city_FE_5_trend=1.32 city_FE_6_trend=1.32 ///
city_FE_7_trend=1.32 city_FE_8_trend=1.32 city_FE_9_trend=1.32 city_FE_10_trend=1.32 city_FE_11_trend=1.32 city_FE_12_trend=1.32 city_FE_13_trend=1.32 city_FE_14_trend=1.32 ///
city_FE_15_trend=1.32 city_FE_16_trend=1.32 city_FE_17_trend=1.32 city_FE_18_trend=1.32 city_FE_19_trend=1.32 city_FE_20_trend=1.32 city_FE_21_trend=1.32 city_FE_22_trend=1.32 ///
city_FE_23_trend=1.32 city_FE_24_trend=1.32 city_FE_25_trend=1.32) ///
level(90) post


gen diarrhea_pred_1932 = _b[_cons]
gen diarrhea_lb_1932 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1932 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1932 diarrhea_lb_1932 diarrhea_ub_1932, after(diarrhea_mean_1932)




*************
*year = 1933
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.32 sewage_treat_div=.4 TB_test=.88 bact_standard=.96 percent_female=.5085915 percent_nonwhite=.1031242 percent_foreign=.1436929 ///
percent_age_less15=.2353722 percent_age_15to44=.5165357 percent_age_45plus=.2481068 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=1 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.36 city_FE_2_trend=1.36 city_FE_3_trend=1.36 city_FE_4_trend=1.36 city_FE_5_trend=1.36 city_FE_6_trend=1.36 ///
city_FE_7_trend=1.36 city_FE_8_trend=1.36 city_FE_9_trend=1.36 city_FE_10_trend=1.36 city_FE_11_trend=1.36 city_FE_12_trend=1.36 city_FE_13_trend=1.36 city_FE_14_trend=1.36 ///
city_FE_15_trend=1.36 city_FE_16_trend=1.36 city_FE_17_trend=1.36 city_FE_18_trend=1.36 city_FE_19_trend=1.36 city_FE_20_trend=1.36 city_FE_21_trend=1.36 city_FE_22_trend=1.36 ///
city_FE_23_trend=1.36 city_FE_24_trend=1.36 city_FE_25_trend=1.36) ///
level(90) post

gen mortality_under1_pred_1933 = _b[_cons]
gen mortality_under1_lb_1933 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1933 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1933 mortality_under1_lb_1933 mortality_under1_ub_1933, after(mortality_under1_mean_1933)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.32 sewage_treat_div=.4 TB_test=.88 bact_standard=.96 percent_female=.5085915 percent_nonwhite=.1031242 percent_foreign=.1436929 ///
percent_age_less15=.2353722 percent_age_15to44=.5165357 percent_age_45plus=.2481068 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=1 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.36 city_FE_2_trend=1.36 city_FE_3_trend=1.36 city_FE_4_trend=1.36 city_FE_5_trend=1.36 city_FE_6_trend=1.36 ///
city_FE_7_trend=1.36 city_FE_8_trend=1.36 city_FE_9_trend=1.36 city_FE_10_trend=1.36 city_FE_11_trend=1.36 city_FE_12_trend=1.36 city_FE_13_trend=1.36 city_FE_14_trend=1.36 ///
city_FE_15_trend=1.36 city_FE_16_trend=1.36 city_FE_17_trend=1.36 city_FE_18_trend=1.36 city_FE_19_trend=1.36 city_FE_20_trend=1.36 city_FE_21_trend=1.36 city_FE_22_trend=1.36 ///
city_FE_23_trend=1.36 city_FE_24_trend=1.36 city_FE_25_trend=1.36) ///
level(90) post

gen typhoid_pred_1933 = _b[_cons]
gen typhoid_lb_1933 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1933 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1933 typhoid_lb_1933 typhoid_ub_1933, after(typhoid_mean_1933)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.32 sewage_treat_div=.4 TB_test=.88 bact_standard=.96 percent_female=.5085915 percent_nonwhite=.1031242 percent_foreign=.1436929 ///
percent_age_less15=.2353722 percent_age_15to44=.5165357 percent_age_45plus=.2481068 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=1 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.36 city_FE_2_trend=1.36 city_FE_3_trend=1.36 city_FE_4_trend=1.36 city_FE_5_trend=1.36 city_FE_6_trend=1.36 ///
city_FE_7_trend=1.36 city_FE_8_trend=1.36 city_FE_9_trend=1.36 city_FE_10_trend=1.36 city_FE_11_trend=1.36 city_FE_12_trend=1.36 city_FE_13_trend=1.36 city_FE_14_trend=1.36 ///
city_FE_15_trend=1.36 city_FE_16_trend=1.36 city_FE_17_trend=1.36 city_FE_18_trend=1.36 city_FE_19_trend=1.36 city_FE_20_trend=1.36 city_FE_21_trend=1.36 city_FE_22_trend=1.36 ///
city_FE_23_trend=1.36 city_FE_24_trend=1.36 city_FE_25_trend=1.36) ///
level(90) post

gen diarrhea_pred_1933 = _b[_cons]
gen diarrhea_lb_1933 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1933 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1933 diarrhea_lb_1933 diarrhea_ub_1933, after(diarrhea_mean_1933)




*************
*year = 1934
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.327 sewage_treat_div=.4 TB_test=.88 bact_standard=.96 percent_female=.5090715 percent_nonwhite=.103921 percent_foreign=.1339559 ///
percent_age_less15=.2325901 percent_age_15to44=.515314 percent_age_45plus=.2521158 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=1 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.40 city_FE_2_trend=1.40 city_FE_3_trend=1.40 city_FE_4_trend=1.40 city_FE_5_trend=1.40 city_FE_6_trend=1.40 ///
city_FE_7_trend=1.40 city_FE_8_trend=1.40 city_FE_9_trend=1.40 city_FE_10_trend=1.40 city_FE_11_trend=1.40 city_FE_12_trend=1.40 city_FE_13_trend=1.40 city_FE_14_trend=1.40 ///
city_FE_15_trend=1.40 city_FE_16_trend=1.40 city_FE_17_trend=1.40 city_FE_18_trend=1.40 city_FE_19_trend=1.40 city_FE_20_trend=1.40 city_FE_21_trend=1.40 city_FE_22_trend=1.40 ///
city_FE_23_trend=1.40 city_FE_24_trend=1.40 city_FE_25_trend=1.40) ///
level(90) post

gen mortality_under1_pred_1934 = _b[_cons]
gen mortality_under1_lb_1934 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1934 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1934 mortality_under1_lb_1934 mortality_under1_ub_1934, after(mortality_under1_mean_1934)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.327 sewage_treat_div=.4 TB_test=.88 bact_standard=.96 percent_female=.5090715 percent_nonwhite=.103921 percent_foreign=.1339559 ///
percent_age_less15=.2325901 percent_age_15to44=.515314 percent_age_45plus=.2521158 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=1 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.40 city_FE_2_trend=1.40 city_FE_3_trend=1.40 city_FE_4_trend=1.40 city_FE_5_trend=1.40 city_FE_6_trend=1.40 ///
city_FE_7_trend=1.40 city_FE_8_trend=1.40 city_FE_9_trend=1.40 city_FE_10_trend=1.40 city_FE_11_trend=1.40 city_FE_12_trend=1.40 city_FE_13_trend=1.40 city_FE_14_trend=1.40 ///
city_FE_15_trend=1.40 city_FE_16_trend=1.40 city_FE_17_trend=1.40 city_FE_18_trend=1.40 city_FE_19_trend=1.40 city_FE_20_trend=1.40 city_FE_21_trend=1.40 city_FE_22_trend=1.40 ///
city_FE_23_trend=1.40 city_FE_24_trend=1.40 city_FE_25_trend=1.40) ///
level(90) post

gen typhoid_pred_1934 = _b[_cons]
gen typhoid_lb_1934 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1934 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1934 typhoid_lb_1934 typhoid_ub_1934, after(typhoid_mean_1934)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.327 sewage_treat_div=.4 TB_test=.88 bact_standard=.96 percent_female=.5090715 percent_nonwhite=.103921 percent_foreign=.1339559 ///
percent_age_less15=.2325901 percent_age_15to44=.515314 percent_age_45plus=.2521158 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=1 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.40 city_FE_2_trend=1.40 city_FE_3_trend=1.40 city_FE_4_trend=1.40 city_FE_5_trend=1.40 city_FE_6_trend=1.40 ///
city_FE_7_trend=1.40 city_FE_8_trend=1.40 city_FE_9_trend=1.40 city_FE_10_trend=1.40 city_FE_11_trend=1.40 city_FE_12_trend=1.40 city_FE_13_trend=1.40 city_FE_14_trend=1.40 ///
city_FE_15_trend=1.40 city_FE_16_trend=1.40 city_FE_17_trend=1.40 city_FE_18_trend=1.40 city_FE_19_trend=1.40 city_FE_20_trend=1.40 city_FE_21_trend=1.40 city_FE_22_trend=1.40 ///
city_FE_23_trend=1.40 city_FE_24_trend=1.40 city_FE_25_trend=1.40) ///
level(90) post

gen diarrhea_pred_1934 = _b[_cons]
gen diarrhea_lb_1934 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1934 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1934 diarrhea_lb_1934 diarrhea_ub_1934, after(diarrhea_mean_1934)





*************
*year = 1935
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.36 sewage_treat_div=.4 TB_test=.88 bact_standard=.96 percent_female=.5095515 percent_nonwhite=.1047179 percent_foreign=.1242192 ///
percent_age_less15=.2298081 percent_age_15to44=.5140923 percent_age_45plus=.2561249 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=1 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.44 city_FE_2_trend=1.44 city_FE_3_trend=1.44 city_FE_4_trend=1.44 city_FE_5_trend=1.44 city_FE_6_trend=1.44 ///
city_FE_7_trend=1.44 city_FE_8_trend=1.44 city_FE_9_trend=1.44 city_FE_10_trend=1.44 city_FE_11_trend=1.44 city_FE_12_trend=1.44 city_FE_13_trend=1.44 city_FE_14_trend=1.44 ///
city_FE_15_trend=1.44 city_FE_16_trend=1.44 city_FE_17_trend=1.44 city_FE_18_trend=1.44 city_FE_19_trend=1.44 city_FE_20_trend=1.44 city_FE_21_trend=1.44 city_FE_22_trend=1.44 ///
city_FE_23_trend=1.44 city_FE_24_trend=1.44 city_FE_25_trend=1.44) ///
level(90) post

gen mortality_under1_pred_1935 = _b[_cons]
gen mortality_under1_lb_1935 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1935 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1935 mortality_under1_lb_1935 mortality_under1_ub_1935, after(mortality_under1_mean_1935)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.36 sewage_treat_div=.4 TB_test=.88 bact_standard=.96 percent_female=.5095515 percent_nonwhite=.1047179 percent_foreign=.1242192 ///
percent_age_less15=.2298081 percent_age_15to44=.5140923 percent_age_45plus=.2561249 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=1 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.44 city_FE_2_trend=1.44 city_FE_3_trend=1.44 city_FE_4_trend=1.44 city_FE_5_trend=1.44 city_FE_6_trend=1.44 ///
city_FE_7_trend=1.44 city_FE_8_trend=1.44 city_FE_9_trend=1.44 city_FE_10_trend=1.44 city_FE_11_trend=1.44 city_FE_12_trend=1.44 city_FE_13_trend=1.44 city_FE_14_trend=1.44 ///
city_FE_15_trend=1.44 city_FE_16_trend=1.44 city_FE_17_trend=1.44 city_FE_18_trend=1.44 city_FE_19_trend=1.44 city_FE_20_trend=1.44 city_FE_21_trend=1.44 city_FE_22_trend=1.44 ///
city_FE_23_trend=1.44 city_FE_24_trend=1.44 city_FE_25_trend=1.44) ///
level(90) post

gen typhoid_pred_1935 = _b[_cons]
gen typhoid_lb_1935 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1935 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1935 typhoid_lb_1935 typhoid_ub_1935, after(typhoid_mean_1935)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.36 sewage_treat_div=.4 TB_test=.88 bact_standard=.96 percent_female=.5095515 percent_nonwhite=.1047179 percent_foreign=.1242192 ///
percent_age_less15=.2298081 percent_age_15to44=.5140923 percent_age_45plus=.2561249 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=1 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.44 city_FE_2_trend=1.44 city_FE_3_trend=1.44 city_FE_4_trend=1.44 city_FE_5_trend=1.44 city_FE_6_trend=1.44 ///
city_FE_7_trend=1.44 city_FE_8_trend=1.44 city_FE_9_trend=1.44 city_FE_10_trend=1.44 city_FE_11_trend=1.44 city_FE_12_trend=1.44 city_FE_13_trend=1.44 city_FE_14_trend=1.44 ///
city_FE_15_trend=1.44 city_FE_16_trend=1.44 city_FE_17_trend=1.44 city_FE_18_trend=1.44 city_FE_19_trend=1.44 city_FE_20_trend=1.44 city_FE_21_trend=1.44 city_FE_22_trend=1.44 ///
city_FE_23_trend=1.44 city_FE_24_trend=1.44 city_FE_25_trend=1.44) ///
level(90) post

gen diarrhea_pred_1935 = _b[_cons]
gen diarrhea_lb_1935 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1935 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1935 diarrhea_lb_1935 diarrhea_ub_1935, after(diarrhea_mean_1935)





*************
*year = 1936
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.36 sewage_treat_div=.4 TB_test=.88 bact_standard=.96 percent_female=.5100314 percent_nonwhite=.1055149 percent_foreign=.1144826 ///
percent_age_less15=.2270261 percent_age_15to44=.5128707 percent_age_45plus=.260134 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=1 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.48 city_FE_2_trend=1.48 city_FE_3_trend=1.48 city_FE_4_trend=1.48 city_FE_5_trend=1.48 city_FE_6_trend=1.48 ///
city_FE_7_trend=1.48 city_FE_8_trend=1.48 city_FE_9_trend=1.48 city_FE_10_trend=1.48 city_FE_11_trend=1.48 city_FE_12_trend=1.48 city_FE_13_trend=1.48 city_FE_14_trend=1.48 ///
city_FE_15_trend=1.48 city_FE_16_trend=1.48 city_FE_17_trend=1.48 city_FE_18_trend=1.48 city_FE_19_trend=1.48 city_FE_20_trend=1.48 city_FE_21_trend=1.48 city_FE_22_trend=1.48 ///
city_FE_23_trend=1.48 city_FE_24_trend=1.48 city_FE_25_trend=1.48) ///
level(90) post

gen mortality_under1_pred_1936 = _b[_cons]
gen mortality_under1_lb_1936 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1936 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1936 mortality_under1_lb_1936 mortality_under1_ub_1936, after(mortality_under1_mean_1936)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.36 sewage_treat_div=.4 TB_test=.88 bact_standard=.96 percent_female=.5100314 percent_nonwhite=.1055149 percent_foreign=.1144826 ///
percent_age_less15=.2270261 percent_age_15to44=.5128707 percent_age_45plus=.260134 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=1 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.48 city_FE_2_trend=1.48 city_FE_3_trend=1.48 city_FE_4_trend=1.48 city_FE_5_trend=1.48 city_FE_6_trend=1.48 ///
city_FE_7_trend=1.48 city_FE_8_trend=1.48 city_FE_9_trend=1.48 city_FE_10_trend=1.48 city_FE_11_trend=1.48 city_FE_12_trend=1.48 city_FE_13_trend=1.48 city_FE_14_trend=1.48 ///
city_FE_15_trend=1.48 city_FE_16_trend=1.48 city_FE_17_trend=1.48 city_FE_18_trend=1.48 city_FE_19_trend=1.48 city_FE_20_trend=1.48 city_FE_21_trend=1.48 city_FE_22_trend=1.48 ///
city_FE_23_trend=1.48 city_FE_24_trend=1.48 city_FE_25_trend=1.48) ///
level(90) post

gen typhoid_pred_1936 = _b[_cons]
gen typhoid_lb_1936 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1936 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1936 typhoid_lb_1936 typhoid_ub_1936, after(typhoid_mean_1936)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.36 sewage_treat_div=.4 TB_test=.88 bact_standard=.96 percent_female=.5100314 percent_nonwhite=.1055149 percent_foreign=.1144826 ///
percent_age_less15=.2270261 percent_age_15to44=.5128707 percent_age_45plus=.260134 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=1 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.48 city_FE_2_trend=1.48 city_FE_3_trend=1.48 city_FE_4_trend=1.48 city_FE_5_trend=1.48 city_FE_6_trend=1.48 ///
city_FE_7_trend=1.48 city_FE_8_trend=1.48 city_FE_9_trend=1.48 city_FE_10_trend=1.48 city_FE_11_trend=1.48 city_FE_12_trend=1.48 city_FE_13_trend=1.48 city_FE_14_trend=1.48 ///
city_FE_15_trend=1.48 city_FE_16_trend=1.48 city_FE_17_trend=1.48 city_FE_18_trend=1.48 city_FE_19_trend=1.48 city_FE_20_trend=1.48 city_FE_21_trend=1.48 city_FE_22_trend=1.48 ///
city_FE_23_trend=1.48 city_FE_24_trend=1.48 city_FE_25_trend=1.48) ///
level(90) post


gen diarrhea_pred_1936 = _b[_cons]
gen diarrhea_lb_1936 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1936 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1936 diarrhea_lb_1936 diarrhea_ub_1936, after(diarrhea_mean_1936)




*************
*year = 1937
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.36 sewage_treat_div=.408 TB_test=.88 bact_standard=.96 percent_female=.5105114 percent_nonwhite=.1063118 percent_foreign=.1047462 ///
percent_age_less15=.224244 percent_age_15to44=.5116491 percent_age_45plus=.2641432 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=1 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.52 city_FE_2_trend=1.52 city_FE_3_trend=1.52 city_FE_4_trend=1.52 city_FE_5_trend=1.52 city_FE_6_trend=1.52 ///
city_FE_7_trend=1.52 city_FE_8_trend=1.52 city_FE_9_trend=1.52 city_FE_10_trend=1.52 city_FE_11_trend=1.52 city_FE_12_trend=1.52 city_FE_13_trend=1.52 city_FE_14_trend=1.52 ///
city_FE_15_trend=1.52 city_FE_16_trend=1.52 city_FE_17_trend=1.52 city_FE_18_trend=1.52 city_FE_19_trend=1.52 city_FE_20_trend=1.52 city_FE_21_trend=1.52 city_FE_22_trend=1.52 ///
city_FE_23_trend=1.52 city_FE_24_trend=1.52 city_FE_25_trend=1.52) ///
level(90) post

gen mortality_under1_pred_1937 = _b[_cons]
gen mortality_under1_lb_1937 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1937 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1937 mortality_under1_lb_1937 mortality_under1_ub_1937, after(mortality_under1_mean_1937)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.36 sewage_treat_div=.408 TB_test=.88 bact_standard=.96 percent_female=.5105114 percent_nonwhite=.1063118 percent_foreign=.1047462 ///
percent_age_less15=.224244 percent_age_15to44=.5116491 percent_age_45plus=.2641432 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=1 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.52 city_FE_2_trend=1.52 city_FE_3_trend=1.52 city_FE_4_trend=1.52 city_FE_5_trend=1.52 city_FE_6_trend=1.52 ///
city_FE_7_trend=1.52 city_FE_8_trend=1.52 city_FE_9_trend=1.52 city_FE_10_trend=1.52 city_FE_11_trend=1.52 city_FE_12_trend=1.52 city_FE_13_trend=1.52 city_FE_14_trend=1.52 ///
city_FE_15_trend=1.52 city_FE_16_trend=1.52 city_FE_17_trend=1.52 city_FE_18_trend=1.52 city_FE_19_trend=1.52 city_FE_20_trend=1.52 city_FE_21_trend=1.52 city_FE_22_trend=1.52 ///
city_FE_23_trend=1.52 city_FE_24_trend=1.52 city_FE_25_trend=1.52) ///
level(90) post

gen typhoid_pred_1937 = _b[_cons]
gen typhoid_lb_1937 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1937 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1937 typhoid_lb_1937 typhoid_ub_1937, after(typhoid_mean_1937)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.36 sewage_treat_div=.408 TB_test=.88 bact_standard=.96 percent_female=.5105114 percent_nonwhite=.1063118 percent_foreign=.1047462 ///
percent_age_less15=.224244 percent_age_15to44=.5116491 percent_age_45plus=.2641432 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=1 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.52 city_FE_2_trend=1.52 city_FE_3_trend=1.52 city_FE_4_trend=1.52 city_FE_5_trend=1.52 city_FE_6_trend=1.52 ///
city_FE_7_trend=1.52 city_FE_8_trend=1.52 city_FE_9_trend=1.52 city_FE_10_trend=1.52 city_FE_11_trend=1.52 city_FE_12_trend=1.52 city_FE_13_trend=1.52 city_FE_14_trend=1.52 ///
city_FE_15_trend=1.52 city_FE_16_trend=1.52 city_FE_17_trend=1.52 city_FE_18_trend=1.52 city_FE_19_trend=1.52 city_FE_20_trend=1.52 city_FE_21_trend=1.52 city_FE_22_trend=1.52 ///
city_FE_23_trend=1.52 city_FE_24_trend=1.52 city_FE_25_trend=1.52) ///
level(90) post


gen diarrhea_pred_1937 = _b[_cons]
gen diarrhea_lb_1937 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1937 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1937 diarrhea_lb_1937 diarrhea_ub_1937, after(diarrhea_mean_1937)





*************
*year = 1938
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.36 sewage_treat_div=.54104 TB_test=.88 bact_standard=.96 percent_female=.5109914 percent_nonwhite=.1071088 percent_foreign=.09501 ///
percent_age_less15=.2214621 percent_age_15to44=.5104276 percent_age_45plus=.2681526 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=1 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.56 city_FE_2_trend=1.56 city_FE_3_trend=1.56 city_FE_4_trend=1.56 city_FE_5_trend=1.56 city_FE_6_trend=1.56 ///
city_FE_7_trend=1.56 city_FE_8_trend=1.56 city_FE_9_trend=1.56 city_FE_10_trend=1.56 city_FE_11_trend=1.56 city_FE_12_trend=1.56 city_FE_13_trend=1.56 city_FE_14_trend=1.56 ///
city_FE_15_trend=1.56 city_FE_16_trend=1.56 city_FE_17_trend=1.56 city_FE_18_trend=1.56 city_FE_19_trend=1.56 city_FE_20_trend=1.56 city_FE_21_trend=1.56 city_FE_22_trend=1.56 ///
city_FE_23_trend=1.56 city_FE_24_trend=1.56 city_FE_25_trend=1.56) ///
level(90) post

gen mortality_under1_pred_1938 = _b[_cons]
gen mortality_under1_lb_1938 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1938 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1938 mortality_under1_lb_1938 mortality_under1_ub_1938, after(mortality_under1_mean_1938)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.36 sewage_treat_div=.54104 TB_test=.88 bact_standard=.96 percent_female=.5109914 percent_nonwhite=.1071088 percent_foreign=.09501 ///
percent_age_less15=.2214621 percent_age_15to44=.5104276 percent_age_45plus=.2681526 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=1 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.56 city_FE_2_trend=1.56 city_FE_3_trend=1.56 city_FE_4_trend=1.56 city_FE_5_trend=1.56 city_FE_6_trend=1.56 ///
city_FE_7_trend=1.56 city_FE_8_trend=1.56 city_FE_9_trend=1.56 city_FE_10_trend=1.56 city_FE_11_trend=1.56 city_FE_12_trend=1.56 city_FE_13_trend=1.56 city_FE_14_trend=1.56 ///
city_FE_15_trend=1.56 city_FE_16_trend=1.56 city_FE_17_trend=1.56 city_FE_18_trend=1.56 city_FE_19_trend=1.56 city_FE_20_trend=1.56 city_FE_21_trend=1.56 city_FE_22_trend=1.56 ///
city_FE_23_trend=1.56 city_FE_24_trend=1.56 city_FE_25_trend=1.56) ///
level(90) post

gen typhoid_pred_1938 = _b[_cons]
gen typhoid_lb_1938 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1938 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1938 typhoid_lb_1938 typhoid_ub_1938, after(typhoid_mean_1938)


quietly reg diarrhea_rate $policy_vars $demographics $year_FE_diarrhea $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.36 sewage_treat_div=.54104 TB_test=.88 bact_standard=.96 percent_female=.5109914 percent_nonwhite=.1071088 percent_foreign=.09501 ///
percent_age_less15=.2214621 percent_age_15to44=.5104276 percent_age_45plus=.2681526 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.56 city_FE_2_trend=1.56 city_FE_3_trend=1.56 city_FE_4_trend=1.56 city_FE_5_trend=1.56 city_FE_6_trend=1.56 ///
city_FE_7_trend=1.56 city_FE_8_trend=1.56 city_FE_9_trend=1.56 city_FE_10_trend=1.56 city_FE_11_trend=1.56 city_FE_12_trend=1.56 city_FE_13_trend=1.56 city_FE_14_trend=1.56 ///
city_FE_15_trend=1.56 city_FE_16_trend=1.56 city_FE_17_trend=1.56 city_FE_18_trend=1.56 city_FE_19_trend=1.56 city_FE_20_trend=1.56 city_FE_21_trend=1.56 city_FE_22_trend=1.56 ///
city_FE_23_trend=1.56 city_FE_24_trend=1.56 city_FE_25_trend=1.56) ///
level(90) post

gen diarrhea_pred_1938 = _b[_cons]
gen diarrhea_lb_1938 = _b[_cons] - 1.66*_se[_cons]
gen diarrhea_ub_1938 = _b[_cons] + 1.66*_se[_cons]

order diarrhea_pred_1938 diarrhea_lb_1938 diarrhea_ub_1938, after(diarrhea_mean_1938)




*************
*year = 1939
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.36 sewage_treat_div=.6 TB_test=.88 bact_standard=.96 percent_female=.5114715 percent_nonwhite=.1079058 percent_foreign=.085274 ///
percent_age_less15=.2186801 percent_age_15to44=.5092061 percent_age_45plus=.272162 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=1 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.60 city_FE_2_trend=1.60 city_FE_3_trend=1.60 city_FE_4_trend=1.60 city_FE_5_trend=1.60 city_FE_6_trend=1.60 ///
city_FE_7_trend=1.60 city_FE_8_trend=1.60 city_FE_9_trend=1.60 city_FE_10_trend=1.60 city_FE_11_trend=1.60 city_FE_12_trend=1.60 city_FE_13_trend=1.60 city_FE_14_trend=1.60 ///
city_FE_15_trend=1.60 city_FE_16_trend=1.60 city_FE_17_trend=1.60 city_FE_18_trend=1.60 city_FE_19_trend=1.60 city_FE_20_trend=1.60 city_FE_21_trend=1.60 city_FE_22_trend=1.60 ///
city_FE_23_trend=1.60 city_FE_24_trend=1.60 city_FE_25_trend=1.60) ///
level(90) post

gen mortality_under1_pred_1939 = _b[_cons]
gen mortality_under1_lb_1939 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1939 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1939 mortality_under1_lb_1939 mortality_under1_ub_1939, after(mortality_under1_mean_1939)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.36 sewage_treat_div=.6 TB_test=.88 bact_standard=.96 percent_female=.5114715 percent_nonwhite=.1079058 percent_foreign=.085274 ///
percent_age_less15=.2186801 percent_age_15to44=.5092061 percent_age_45plus=.272162 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=1 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.60 city_FE_2_trend=1.60 city_FE_3_trend=1.60 city_FE_4_trend=1.60 city_FE_5_trend=1.60 city_FE_6_trend=1.60 ///
city_FE_7_trend=1.60 city_FE_8_trend=1.60 city_FE_9_trend=1.60 city_FE_10_trend=1.60 city_FE_11_trend=1.60 city_FE_12_trend=1.60 city_FE_13_trend=1.60 city_FE_14_trend=1.60 ///
city_FE_15_trend=1.60 city_FE_16_trend=1.60 city_FE_17_trend=1.60 city_FE_18_trend=1.60 city_FE_19_trend=1.60 city_FE_20_trend=1.60 city_FE_21_trend=1.60 city_FE_22_trend=1.60 ///
city_FE_23_trend=1.60 city_FE_24_trend=1.60 city_FE_25_trend=1.60) ///
level(90) post

gen typhoid_pred_1939 = _b[_cons]
gen typhoid_lb_1939 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1939 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1939 typhoid_lb_1939 typhoid_ub_1939, after(typhoid_mean_1939)




*************
*year = 1940
*************
quietly reg mortality_under1_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.36 sewage_treat_div=.6 TB_test=.88 bact_standard=.96 percent_female=.5119515 percent_nonwhite=.1087028 percent_foreign=.0755382 ///
percent_age_less15=.2158981 percent_age_15to44=.5079846 percent_age_45plus=.2761715 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.64 city_FE_2_trend=1.64 city_FE_3_trend=1.64 city_FE_4_trend=1.64 city_FE_5_trend=1.64 city_FE_6_trend=1.64 ///
city_FE_7_trend=1.64 city_FE_8_trend=1.64 city_FE_9_trend=1.64 city_FE_10_trend=1.64 city_FE_11_trend=1.64 city_FE_12_trend=1.64 city_FE_13_trend=1.64 city_FE_14_trend=1.64 ///
city_FE_15_trend=1.64 city_FE_16_trend=1.64 city_FE_17_trend=1.64 city_FE_18_trend=1.64 city_FE_19_trend=1.64 city_FE_20_trend=1.64 city_FE_21_trend=1.64 city_FE_22_trend=1.64 ///
city_FE_23_trend=1.64 city_FE_24_trend=1.64 city_FE_25_trend=1.64) ///
level(90) post

gen mortality_under1_pred_1940 = _b[_cons]
gen mortality_under1_lb_1940 = _b[_cons] - 1.66*_se[_cons]
gen mortality_under1_ub_1940 = _b[_cons] + 1.66*_se[_cons]

order mortality_under1_pred_1940 mortality_under1_lb_1940 mortality_under1_ub_1940, after(mortality_under1_mean_1940)


quietly reg typhoid_rate $policy_vars $demographics $year_FE $city_FE $city_trends [pweight = pop_ave], cluster(state_city_id)

margins, at(filter=0 chlorination=1 water_project=.36 sewage_treat_div=.6 TB_test=.88 bact_standard=.96 percent_female=.5119515 percent_nonwhite=.1087028 percent_foreign=.0755382 ///
percent_age_less15=.2158981 percent_age_15to44=.5079846 percent_age_45plus=.2761715 year_FE_2=0 year_FE_3=0 year_FE_4=0 year_FE_5=0 year_FE_6=0 year_FE_7=0 year_FE_8=0 year_FE_9=0 year_FE_10=0 ///
year_FE_11=0 year_FE_12=0 year_FE_13=0 year_FE_14=0 year_FE_15=0 year_FE_16=0 year_FE_17=0 year_FE_18=0 year_FE_19=0 year_FE_20=0 year_FE_21=0 year_FE_22=0 year_FE_23=0 year_FE_24=0 year_FE_25=0 ///
year_FE_26=0 year_FE_27=0 year_FE_28=0 year_FE_29=0 year_FE_30=0 year_FE_31=0 year_FE_32=0 year_FE_33=0 year_FE_34=0 year_FE_35=0 year_FE_36=0 year_FE_37=0 year_FE_38=0 year_FE_39=0 year_FE_40=0 ///
city_FE_1=.04 city_FE_2=.04 city_FE_3=.04 city_FE_4=.04 city_FE_5=.04 city_FE_6=.04 city_FE_7=.04 city_FE_8=.04 city_FE_9=.04 city_FE_10=.04 ///
city_FE_11=.04 city_FE_12=.04 city_FE_13=.04 city_FE_14=.04 city_FE_15=.04 city_FE_16=.04 city_FE_17=.04 city_FE_18=.04 city_FE_19=.04 city_FE_20=.04 ///
city_FE_21=.04 city_FE_22=.04 city_FE_24=.04 city_FE_1_trend=1.64 city_FE_2_trend=1.64 city_FE_3_trend=1.64 city_FE_4_trend=1.64 city_FE_5_trend=1.64 city_FE_6_trend=1.64 ///
city_FE_7_trend=1.64 city_FE_8_trend=1.64 city_FE_9_trend=1.64 city_FE_10_trend=1.64 city_FE_11_trend=1.64 city_FE_12_trend=1.64 city_FE_13_trend=1.64 city_FE_14_trend=1.64 ///
city_FE_15_trend=1.64 city_FE_16_trend=1.64 city_FE_17_trend=1.64 city_FE_18_trend=1.64 city_FE_19_trend=1.64 city_FE_20_trend=1.64 city_FE_21_trend=1.64 city_FE_22_trend=1.64 ///
city_FE_23_trend=1.64 city_FE_24_trend=1.64 city_FE_25_trend=1.64) ///
level(90) post

gen typhoid_pred_1940 = _b[_cons]
gen typhoid_lb_1940 = _b[_cons] - 1.66*_se[_cons]
gen typhoid_ub_1940 = _b[_cons] + 1.66*_se[_cons]

order typhoid_pred_1940 typhoid_lb_1940 typhoid_ub_1940, after(typhoid_mean_1940)



*Creating Figures
keep mortality_under1_mean* mortality_under1_pred* mortality_under1_lb* mortality_under1_ub* typhoid_mean_* typhoid_pred* typhoid_lb* typhoid_ub* ///
diarrhea_mean* diarrhea_pred* diarrhea_lb* diarrhea_ub* 

duplicates drop
drop in 2

gen i = 1
order i, before(mortality_under1_mean_1900)

reshape long mortality_under1_mean_ mortality_under1_pred_ mortality_under1_lb_ mortality_under1_ub_ typhoid_mean_ typhoid_pred_ typhoid_lb_ typhoid_ub_ ///
diarrhea_mean_ diarrhea_pred_ diarrhea_lb_ diarrhea_ub_, i(i) j(year)
drop i

rename mortality_under1_mean_ mortality_under1_mean
rename mortality_under1_pred_ mortality_under1_pred
rename mortality_under1_lb_ mortality_under1_lb
rename mortality_under1_ub_ mortality_under1_ub
rename typhoid_mean_ typhoid_mean
rename typhoid_pred_ typhoid_pred
rename typhoid_lb_ typhoid_lb
rename typhoid_ub_ typhoid_ub
rename diarrhea_mean_ diarrhea_mean
rename diarrhea_pred_ diarrhea_pred
rename diarrhea_lb_ diarrhea_lb
rename diarrhea_ub_ diarrhea_ub


*Infant Mortality
twoway (rarea mortality_under1_ub mortality_under1_lb year, sort fcolor(gray) fintensity(20) lcolor(gs16) lwidth(vvvthin) lpattern(longdash)) ///
(line mortality_under1_mean year, sort lcolor(black) lpattern(solid)) ///
(line mortality_under1_pred year, sort lcolor(black) lpattern(dash)), ///
title("{bf:Figure 4. Actual vs. Predicted Infant Mortality Rates}" ///
"The Effect of Municipal Water Filtration", size(medlarge) color(black)) ///
xtitle("") xscale(titlegap(2)) xlabel(1900(5)1940) ///
legend(order(2 "Infant mortality rate" 3 "Predicted infant mortality rate") cols(1)) ///
yline(100 200 300 400, lwidth(vvvthin) lpattern(shortdash) lcolor(gs10)) /// 
ytitle("Infant mortality per 100,000 population") ytitle(, size(medsmall) color(black) margin(medsmall)) ylabel(100(100)400) ///
note("Notes: Based on annual data from {it:Mortality Statistics} and {it:Vital Statistics of the United States} for the period" /// 
"1900-1940, published by the U.S. Census Bureau. Predicted infant mortality rates are calculated under the" ///
"assumption that municipalities did not filter their water supply. Shaded area represents 90% confidence" ///
"region around infant mortality rates.") /// 
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) 


*Typhoid
twoway (rarea typhoid_ub typhoid_lb year, sort fcolor(gray) fintensity(20) lcolor(gs16) lwidth(vvvthin) lpattern(longdash)) ///
(line typhoid_mean year, sort lcolor(black) lpattern(solid)) ///
(line typhoid_pred year, sort lcolor(black) lpattern(dash)), ///
title("{bf:Appendix Figure 12. Actual vs. Predicted Typhoid Mortality Rates}" ///
"The Effect of Municipal Water Filtration", size(medlarge) color(black)) ///
xtitle("") xscale(titlegap(2)) xlabel(1900(5)1940) ///
legend(order(2 "Typhoid mortality rate" 3 "Predicted typhoid mortality rate") cols(1)) ///
yline(0 10 20 30 40 50, lwidth(vvvthin) lpattern(shortdash) lcolor(gs10)) /// 
ytitle("Typhoid mortality per 100,000 population") ytitle(, size(medsmall) color(black) margin(medsmall)) ylabel(0(10)50) ///
note("Notes: Based on annual data from {it:Mortality Statistics} and {it:Vital Statistics of the United States} for the period" /// 
"1900-1940, published by the U.S. Census Bureau. Predicted typhoid mortality rates are calculated under" ///
"the assumption that municipalities did not filter their water supply. Shaded area represents 90% confidence" ///
"region around typhoid mortality rates.") /// 
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) 


*Diarrhea/Enteritis 
twoway (rarea diarrhea_ub diarrhea_lb year, sort fcolor(gray) fintensity(20) lcolor(gs16) lwidth(vvvthin) lpattern(longdash)) ///
(line diarrhea_mean year, sort lcolor(black) lpattern(solid)) ///
(line diarrhea_pred year, sort lcolor(black) lpattern(dash)), ///
title("{bf:Appendix Figure 13. Actual vs. Predicted Diarrhea/Enteritis Mortality Rates}" ///
"The Effect of Municipal Water Filtration", size(medsmall) color(black)) ///
xtitle("") xscale(titlegap(2)) xlabel(1900(5)1940) ///
legend(order(2 "Diarrhea/enteritis mortality rate" 3 "Predicted diarrhea/enteritis mortality rate") cols(1)) ///
yline(0 30 60 90 120, lwidth(vvvthin) lpattern(shortdash) lcolor(gs10)) /// 
ytitle("Diarrhea/enteritis mortality per" ///
"100,000 population") ytitle(, size(medsmall) color(black) margin(medsmall)) ylabel(0(30)120) ///
note("Notes: Based on annual data from {it:Mortality Statistics} and {it:Vital Statistics of the United States} for the period" /// 
"1900-1938, published by the U.S. Census Bureau. Predicted diarrhea/enteritis mortality rates are" ///
"calculated under the assumption that municipalities did not filter their water supply. Shaded area" ///
"represents 90% confidence region around diarrhea/enteritis mortality rates.") /// 
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) 



