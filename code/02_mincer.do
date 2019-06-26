/* Prepare data for mincer-style regressions */
/* Prepated by Evan Totty */

global logprefix "02_mincer"
include "config.do"


set matsize 11000
use ${inputdata}/${SSBprefix}1.dta, clear

/*****************************************
First, prepare data for regressions
*****************************************/
**Reshape sample and variables of interest from wide to long
local longvars_admin_STUB total_der_fica_ total_der_nonfica_

keep if !missing(educ_5cat)
keep if !missing(birthdate)
drop if current_enroll_coll==1
drop if current_enroll_hs==1

egen exp_ser19511977=rowtotal(ser_posearn_1951-ser_posearn_1977)
sum exp_ser19511977

keep total_der_fica_* total_der_nonfica_* personid initwgt date_enter_sipp male race hispanic foreign_born educ_5cat birthdate state year_bach year_beg_posths year_end_hs year_end_posths exp_ser19511977 mh1 mh2 mh3 mh4 mh5 mh6 mh7 mh8 mh_date1 mh_date2 mh_date3 mh_date4 mh_date5 mh_date6 mh_date7 mh_date8

reshape long `longvars_admin_STUB', i(personid) j(year)


**Create total admin earnings variable
gen total_der=total_der_fica+total_der_nonfica
keep if !missing(total_der)
gen log_total_der=log(total_der)

**Keep sample year of interest - 1st full year in SIPP panel
format date_enter_sipp %td
gen year_enter=year(date_enter_sipp)
keep if year==year_enter

**create longitudinal schooling variables
gen educ_long=1
sort personid year
by personid: replace educ_long=2 if educ_5cat>=2 & year>=year_end_hs
by personid: replace educ_long=3 if educ_5cat==3 & year>=year_end_posths
by personid: replace educ_long=4 if educ_5cat>=4 & year>=year_bach
by personid: replace educ_long=5 if educ_5cat>=5 & year>=year_end_posths
replace educ_long=. if educ_5cat==.

gen educyears1=.
replace educyears1=10 if educ_long==1
replace educyears1=12 if educ_long==2
replace educyears1=14 if educ_long==3
replace educyears1=16 if educ_long==4
replace educyears1=18 if educ_long==5

**create age variable and keep ages 30-61
format birthdate %td
gen birthyear=year(birthdate)
gen age=year-birthyear
gen age_sq=age^2
keep if age>=16 & age<=65

**create potential experience
gen potexp=age-educyears1-6
gen potexp_sq=potexp^2

**gen quarter of birth variable
gen birthmonth=month(birthdate)
gen birthquarter=.
replace birthquarter=1 if birthmonth>=1 & birthmonth<=3
replace birthquarter=2 if birthmonth>=4 & birthmonth<=6
replace birthquarter=3 if birthmonth>=7 & birthmonth<=9
replace birthquarter=4 if birthmonth>=10 & birthmonth<=12

**longitudinal marriage variable
gen marriedyear=year(mh_date1)
gen marriedendyear=year(mh_date2)
gen married2year=year(mh_date3)
gen married2endyear=year(mh_date4)
gen married3year=year(mh_date5)
gen married3endyear=year(mh_date6)
gen married4year=year(mh_date7)
gen married4endyear=year(mh_date8)
gen married=0
replace married=1 if mh1==1 & year>=marriedyear
replace married=0 if mh2>1 & year>=marriedendyear
replace married=1 if mh3==1 & year>=married2year
replace married=0 if mh4>1 & year>=married2endyear
replace married=1 if mh5==1 & year>=married3year
replace married=0 if mh6>1 & year>=married3endyear
replace married=1 if mh7==1 & year>=married4year
replace married=0 if mh8>1 & year>=married4endyear

**Adjust earnings data for inflation
gen total_der_cpi=.
replace total_der_cpi=total_der*2.34 if year==1978
replace total_der_cpi=total_der*2.14 if year==1979
replace total_der_cpi=total_der*1.92 if year==1980
replace total_der_cpi=total_der*1.76 if year==1981
replace total_der_cpi=total_der*1.66 if year==1982
replace total_der_cpi=total_der*1.59 if year==1983
replace total_der_cpi=total_der*1.52 if year==1984
replace total_der_cpi=total_der*1.48 if year==1985
replace total_der_cpi=total_der*1.45 if year==1986
replace total_der_cpi=total_der*1.40 if year==1987
replace total_der_cpi=total_der*1.35 if year==1988
replace total_der_cpi=total_der*1.30 if year==1989
replace total_der_cpi=total_der*1.24 if year==1990
replace total_der_cpi=total_der*1.19 if year==1991
replace total_der_cpi=total_der*1.16 if year==1992
replace total_der_cpi=total_der*1.14 if year==1993
replace total_der_cpi=total_der*1.11 if year==1994
replace total_der_cpi=total_der*1.09 if year==1995
replace total_der_cpi=total_der*1.06 if year==1996
replace total_der_cpi=total_der*1.04 if year==1997
replace total_der_cpi=total_der*1.02 if year==1998
replace total_der_cpi=total_der*1 if year==1999
replace total_der_cpi=total_der*0.97 if year==2000
replace total_der_cpi=total_der*0.94 if year==2001
replace total_der_cpi=total_der*0.93 if year==2002
replace total_der_cpi=total_der*0.91 if year==2003
replace total_der_cpi=total_der*0.88 if year==2004
replace total_der_cpi=total_der*0.85 if year==2005
replace total_der_cpi=total_der*0.83 if year==2006
replace total_der_cpi=total_der*0.80 if year==2007
replace total_der_cpi=total_der*0.77 if year==2008
replace total_der_cpi=total_der*0.78 if year==2009
replace total_der_cpi=total_der*0.76 if year==2010
gen log_total_der_cpi=log(total_der_cpi)



/*****************************************
Second, estimate mincer regressions
*****************************************/
**Specify dependent variable, endogeneous education variable, and rest of the specification(s)
local depvar log_total_der_cpi
local educvar educyears1
local spec1 "age age_sq i.birthyear i.race foreign_born hispanic i.state married"
local spec2 "potexp potexp_sq i.birthyear i.race foreign_born hispanic i.state married"
local specs ""`spec1'" "`spec2'""

**Loop through regressions, by gender
eststo clear
fvset base 1958 birthyear
foreach g in 1 0 {
foreach spec of local specs {
    eststo: reg `depvar' `educvar' `spec' if male==`g'
    eststo: ivregress 2sls `depvar' `spec' (`educvar' = i.birthquarter#i.birthyear) if male==`g'
}
}

**Label variables for use in esttab output
label var educyears1 "School Years"
label var potexp "Potential Experience"
label var potexp_sq "Pot. Exp. Squared"
label var age "Age"
label var age_sq "Age Squared"

esttab using /results/mincer_results.csv, se r2 mtitles("OLS-Males" "2SLS-Males" "OLS-Males" "2SLS-Males" "OLS-Females" "2SLS-Females" "OLS-Females" "2SLS-Females") keep(educyears1 potexp potexp_sq age age_sq) label replace



