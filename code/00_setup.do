/* 00_setup.do */
/* Suggested by Lars Vilhuber */
/* Create a reproducible Stata sequence by running this file as the first part of the program sequence */
/* Get it at https://gist.github.com/larsvilhuber/8ead0ba85119e4085e71ab3062760190 */

global logprefix "00_setup"
include "config.do"

/* Now install them */
/*--- SSC packages ---*/

local ssc_packages ///
            outreg estout 
                
if !missing("`ssc_packages'") {
    foreach pkg in `ssc_packages' {
        capture which `pkg'
        if _rc == 111 {                 
                dis "Installing `pkg'"
                quietly ssc install `pkg', replace
        }
    }
}
