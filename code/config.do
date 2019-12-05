/* config.do */
/* Suggested by Lars Vilhuber */
/* Create a reproducible Stata sequence by calling this program from every other program in your sequence */
/* Get it at: https://gist.github.com/larsvilhuber/6bcf4ff820285a1f1b9cfff2c81ca02b */
/* Usage: 
  Adapt to your needs, save as config.do, then add
   include "config.do"
   in the author's main Stata program
   */

/* Create a log file */
local c_date = c(current_date)
local cdate = subinstr("`c_date'", " ", "_", .)
// local logprefix "logfile" // could be "myprog" or something else or could come from the main program 
log using "../results/${logprefix}_`cdate'.log", replace text

/* define global parameters and paths */
global precision 0.01

/* SSB parameters */
global SSBversion 7_0
global SSBtype synthetic
global SSBnum 4
global SSBprefix = "ssb_v${SSBversion}_${SSBtype}"

/* paths */
global basepath "/code"      // change this for your specific system
global inputdata "../data"  // this is where you would read data acquired elsewhere
global results "../results"       // All tables for inclusion in your paper go here
global programs "$basepath"    // All programs (which you might "include") are to be found here
global outputdata "$results/outputdata" // this is where you would write the data you create in this project
global adobase  "$programs/ado" // Ado packages used by the project are to be found here

cap mkdir $outputdata
cap mkdir $adobase

/* install any packages locally */
/* on codeocean, these should go into the post-install script! */
sysdir set PERSONAL "$adobase/personal"
sysdir set PLUS     "$adobase/plus"
sysdir set SITE     "$adobase/site"



/* keep this line in the config file */
/* It will provide some info about how and when the program was run */
/* See https://www.stata.com/manuals13/pcreturn.pdf#pcreturn */
di "=== SYSTEM DIAGNOSTICS ==="
di "Stata version: `c(stata_version)'"
di "Updated as of: `c(born_date)'"
di "Flavor:        `c(flavor)'"
di "Processors:    `c(processors)'"
di "OS:            `c(os)' `c(osdtl)'"
di "Machine type:  `c(machine_type)'"
di "=========================="
