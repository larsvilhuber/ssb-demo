/* 00_setup.do */
/* Suggested by Lars Vilhuber */
/* Create a reproducible Stata sequence by running this file as the first part of the program sequence */
/* Get it at https://gist.github.com/larsvilhuber/8ead0ba85119e4085e71ab3062760190 */

global logprefix "00_setup"
include "config.do"

/* Now install them */
/*--- SSC packages ---*/
foreach pkg in outreg esttab  {
  ssc install `pkg'
}
