/* 01_stats.do */
/* Author:  Lars Vilhuber */
/* quick stats on the input data */

global logprefix "01_stats"
include "config.do"

ls $inputdata
use in 1/100 using $inputdata/${SSBprefix}1
sum 


