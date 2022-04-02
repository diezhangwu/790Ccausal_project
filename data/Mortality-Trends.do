
*********Set directory and load data set entitled "Regression and Event Study Analyses.dta"*********
/*
use "H:\oldTS1desktop\Clean Water and Pasteurized Milk\Replication Files for AEJ Applied\Regression and Event Study Analyses.dta", clear
*/


*Unweighted means
forvalues i = 1900/1940 {

	sum mortality_rate if  year == `i'
	gen mortality_mean_`i' = r(mean) 

	sum mortality_under1_rate if year == `i'
	gen mortality_under1_mean_`i' = r(mean)

	sum typhoid_rate if year == `i'
	gen typhoid_mean_`i' = r(mean)

	sum diarrhea_rate if year == `i'
	gen diarrhea_mean_`i' = r(mean)

	sum diarrhea_under2_rate if year == `i'
	gen diarrhea_under2_mean_`i' = r(mean)
	
	sum nonpul_TB_rate if year == `i'
	gen nonpul_TB_mean_`i' = r(mean)
	
	sum nonpul_TB_under2_rate if year == `i'
	gen nonpul_TB_under2_mean_`i' = r(mean)

}


keep mortality_mean_1900-nonpul_TB_under2_mean_1940

duplicates drop

gen i = 1
order i, before(mortality_mean_1900)

reshape long mortality_mean_ mortality_under1_mean_ typhoid_mean_ diarrhea_mean_ diarrhea_under2_mean_ nonpul_TB_mean_ nonpul_TB_under2_mean_, i(i) j(year)

drop i

rename mortality_mean_ mortality_mean
rename mortality_under1_mean_ mortality_under1_mean
rename typhoid_mean_ typhoid_mean
rename diarrhea_mean_ diarrhea_mean
rename diarrhea_under2_mean_ diarrhea_under2_mean
rename nonpul_TB_mean_ nonpul_TB_mean
rename nonpul_TB_under2_mean_ nonpul_TB_under2_mean


*Figure 2. Total and Infant Mortality Rates, 1900-1940
twoway (line mortality_mean year, sort lcolor(black) lpattern(solid) lwidth(thick)) ///
(line mortality_under1_mean year, sort lcolor(black) lpattern(dash) lwidth(thick) yaxis(2)), ///
title("{bf:Figure 2. Total and Infant Mortality Rates, 1900-1940}", size(vlarge) color(black)) ///
xtitle("") xscale(titlegap(2)) xlabel(1900(10)1940) ///
xsize(8) xlabel(, labsize(large)) ///
yline(1100 1300 1500 1700 1900, lwidth(vvvthin) lpattern(shortdash) lcolor(gs10)) /// 
ylabel(1100(200)1900, labsize(medsmall)) ///
ytitle("Mortality per 100,000 population", size(medlarge) color(black) margin(small)) ///
ytitle("Infant mortality per 100,000 population", size(medlarge) color(black) margin(med) axis(2)) ///
legend(order(1 "Total mortality rate" 2 "Infant mortality rate") size(large) cols(1)) ///
note("Notes: Based on annual data from {it:Mortality Statistics} and {it:Vital Statistics of the United States} for the period 1900-1940," ///
"published by the U.S. Census Bureau.", size(med))  /// 
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) aspect(.3)


*Figure 3. Typhoid Mortality Rates, 1900-1940
twoway (line typhoid_mean year, sort lcolor(black) lpattern(solid) lwidth(thick)), ///
title("{bf:Figure 3. Typhoid Mortality Rates, 1900-1940}", size(vlarge) color(black)) ///
xtitle("") xscale(titlegap(2)) xlabel(1900(10)1940) ///
xsize(8) xlabel(, labsize(large)) ///
yline(0 10 20 30 40, lwidth(vvvthin) lpattern(shortdash) lcolor(gs10)) /// 
ylabel(0(10)40, labsize(med)) ///
ytitle("Typhoid mortality per 100,000 population") ///
ytitle(, size(medlarge) color(black) margin(medsmall)) ///
note("Notes: Based on annual data from {it:Mortality Statistics} and {it:Vital Statistics of the United States} for the period 1900-1940," ///
"published by the U.S. Census Bureau.", size(med))  /// 
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) aspect(.3)


*Appendix Figure 3. Percent of Overall Mortality Due to Typhoid
gen per_typhoid = typhoid_mean/mortality_mean

twoway (line per_typhoid year, sort lcolor(black) lpattern(solid) lwidth(thick)), ///
title("{bf:Appendix Figure 3. Percent of Total Mortality Due to Typhoid, 1900-1940}", size(vlarge) color(black)) ///
xtitle("") xscale(titlegap(2)) xlabel(1900(10)1940) ///
xsize(8) xlabel(, labsize(large)) ///
yline(0 .01 .02 .03, lwidth(vvvthin) lpattern(shortdash) lcolor(gs10)) /// 
ylabel(0(.01).03, labsize(medlarge)) ///
ytitle("") ///
note("Notes: Based on annual data from {it:Mortality Statistics} and {it:Vital Statistics of the United States} for the period 1900-1940, published" ///
"by the U.S. Census Bureau.", size(med))  /// 
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) aspect(.3)


*Appendix Figure 4. Ratio of Diarrhea/Enteritis to Typhoid Mortality
gen diarrhea_to_typhoid = diarrhea_mean/typhoid_mean

twoway (line diarrhea_to_typhoid year, sort lcolor(black) lpattern(solid) lwidth(thick)), ///
title("{bf:Appendix Figure 4. Ratio of Diarrhea/Enteritis to Typhoid Mortality, 1900-1938}", size(vlarge) color(black)) ///
xtitle("") xscale(titlegap(2)) xlabel(1900(10)1940) ///
xsize(8) xlabel(, labsize(large)) ///
yline(2 6 10 14 18, lwidth(vvvthin) lpattern(shortdash) lcolor(gs10)) /// 
ylabel(2(4)18, labsize(med)) ///
ytitle("") ///
note("Notes: Based on annual data from {it:Mortality Statistics} and {it:Vital Statistics of the United States} for the period 1900-1938, published" ///
"by the U.S. Census Bureau.", size(med))  /// 
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) aspect(.3)


*Appendix Figure 5. Diarrhea/Enteritis Mortality Rates, 1900-1940
twoway (line diarrhea_mean year, sort lcolor(black) lpattern(solid) lwidth(thick)) ///
(line diarrhea_under2_mean year, sort lcolor(black) lpattern(dash) lwidth(thick)), ///
title("{bf:Appendix Figure 5. Diarrhea/Enteritis Mortality Rates, 1900-1940}", size(vlarge) color(black)) ///
xtitle("") xscale(titlegap(2)) xlabel(1900(10)1940) ///
xsize(8) xlabel(, labsize(large)) ///
yline(0 50 100 150, lwidth(vvvthin) lpattern(shortdash) lcolor(gs10)) /// 
ylabel(0(50)150, labsize(med)) ///
ytitle("Diarrhea/enteritis mortality per" ///
"100,000 population") ///
ytitle(, size(medlarge) color(black) margin(medsmall)) ///
legend(order(1 "Diarrhea/enteritis mortality rate (all ages)" 2 "Diarrhea/enteritis mortality rate (under age 2)") size(large) cols(1)) ///
note("Notes: Based on annual data from {it:Mortality Statistics} and {it:Vital Statistics of the United States} for the period 1900-1940," ///
"published by the U.S. Census Bureau.", size(med))  /// 
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) aspect(.3)


*Appendix Figure 6. Non-Pulmonary TB Mortality Rates, 1900-1940
twoway (line nonpul_TB_mean year, sort lcolor(black) lpattern(solid) lwidth(thick)) ///
(line nonpul_TB_under2_mean year, sort lcolor(black) lpattern(dash) lwidth(thick)), ///
title("{bf:Appendix Figure 6. Non-Pulmonary TB Mortality Rates, 1900-1940}", size(vlarge) color(black)) ///
xtitle("") xscale(titlegap(2)) xlabel(1900(10)1940) ///
xsize(8) xlabel(, labsize(large)) ///
yline(0 10 20 30, lwidth(vvvthin) lpattern(shortdash) lcolor(gs10)) /// 
ylabel(0(10)30, labsize(med)) ///
ytitle("Non-pulmonary TB mortality per" ///
"100,000 population") ///
ytitle(, size(medlarge) color(black) margin(medsmall)) ///
legend(order(1 "Non-pulmonary TB mortality rate (all ages)" 2 "Non-pulmonary TB mortality rate (under age 2)") size(large) cols(1)) ///
note("Notes: Based on annual data from {it:Mortality Statistics} and {it:Vital Statistics of the United States} for the period 1900-1940," ///
"published by the U.S. Census Bureau.", size(med))  /// 
graphregion(fcolor(white) lcolor(white) lwidth(vvvthin) ifcolor(white) ilcolor(white) ilwidth(vvvthin)) aspect(.3)


