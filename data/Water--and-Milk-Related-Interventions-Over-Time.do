
*********Set directory and load data set entitled "Water- and Milk-Related Interventions Over Time.dta"*********

/*
use "H:\oldTS1desktop\Clean Water and Pasteurized Milk\Replication Files for AEJ Applied\Water- and Milk-Related Interventions Over Time.dta", clear
*/


foreach var of varlist filter-TB_test {

	replace `var' = 1 if (`var' > 0 & `var' < 1)
	egen `var'_sum = sum(`var'), by(year)
	
}

duplicates drop year, force

keep year bact_standard_sum TB_test_sum filter_sum chlorination_sum water_project_sum sewage_treat_div_sum
 
rename bact_standard_sum bact_standard
label var bact_standard "cities setting bacteriological standard for milk"

rename TB_test_sum TB_test
label var TB_test "cities testing for bovine TB"

rename filter_sum filter
label var filter "cities filtering their water supply"

rename chlorination_sum chlorination
label var chlorination "cities chlorinating their water supply"

rename water_project_sum water_project
label var water_project "cities with clean water projects"

rename sewage_treat_div_sum sewage_treat_div
label var sewage_treat_div "cities treating or diverting their sewage"


*Clean Water Interventions
twoway (connected filter year, sort mcolor(black) msymbol(circle) lcolor(black)) ///
(connected chlorination year, sort mcolor(black) msymbol(triangle) lcolor(black)) ///
(connected water_project year, sort mcolor(black) msymbol(lgx) lcolor(black)) ///
(connected sewage_treat_div year, sort mcolor(black) msymbol(diamond) lcolor(black)), ///
yline(0 5 10 15 20 25, lwidth(vvvthin) lpattern(shortdash) lcolor(black)) ///
xtitle("") xlabel(1900(10)1940) ///
title("{bf:Appendix Figure 1. Municipal Water-Related Interventions Over Time}", size(med) color(black)) ///
legend(order(1 "Number of cities filtering their water supply" 2 "Number of cities adding chlorine to their water supply" 3 "Number of cities that built a clean water project" 4 "Number of cities treating/diverting their sewage") rows(4) nobox) ///
scheme(s1color)


*Milk Ordinances
twoway (connected bact_standard year, sort mcolor(black) msymbol(circle) lcolor(black)) ///
(connected TB_test year, sort mcolor(black) msymbol(triangle) lcolor(black)), ///
yline(0 5 10 15 20, lwidth(vvvthin) lpattern(shortdash) lcolor(black)) ///
xtitle("") xlabel(1900(10)1940) ///
title("{bf:Appendix Figure 2. Municipal Milk-Related Interventions Over Time}", size(med) color(black)) ///
legend(order(1 "Number of cities setting a bacteriological standard" 2 "Number of cities testing for bovine TB") rows(2) nobox) ///
scheme(s1color)



