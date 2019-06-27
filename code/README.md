# Demonstration of Synthetic and Confidential Data Processing

We demonstrate a simple scenario.

## Development of code on open compute servers using synthetic data

This repository itself is the code. The code is written in Stata, and is confirmed to run on this site.

Basic structure ([refs](https://help.codeocean.com/getting-started/uploading-code-and-data/paths)):
- all code is under `/code`
- all data is under `/data`
- all outputs [MUST be written to `/results`](https://help.codeocean.com/getting-started/uploading-code-and-data/saving-files), otherwise they are lost

This is solved here through the inclusion of the [config.do](config.do) file, which defines some global variables, and instantiates logfiles.

Logfiles and other outputs can be found on CodeOcean in the right pane, under specific "runs". 

Packages need to be installed through a "post-install" script, which is not part of the codebase here, but rather part of the system setup files (which are also versioned). Instructions are [here](https://help.codeocean.com/getting-started/the-computational-environment/using-the-postinstall-script-for-further-customization) and [here](https://help.codeocean.com/tips-and-tricks/language-specific-issues/using-stata-on-code-ocean).

## Concrete example

This example runs a Mincer equation on the SIPP Synthetic Beta data (need cite). The code is split into 4 pieces, tied together by a script.

### Script
The script [run](run) ties all Stata programs together. An alternative would be to have both a generic run, plus a master Stata do file. Both options work.

### Stata programs
- [config.do](config.do) creates various global variables, and initializes a per-program log file, which will show up in `/results`.
- [00_setup.do](00_setup.do) initializes the system. In this case, it installs Stata packages from SSC. This could also be incorporated into the Dockerfile as a script. We chose this method since it is slightly more transparent, at the cost of some replicability (when packages change on SSC).
- [01_stats.do](01_stats.do) computes a few simple descriptive stats. Only log output is generated, but this could generate a summary stats table ("Table 1") of a paper.
- [02_mincer.do](02_mincer.do) does data prep and runs a Mincer regression. Output is generated through `esttab`, and stored in `/results/mincer_results.csv`.

## Porting to confidential compute server

The compute capsule (or just the code?) are exported (via capsule export, or via git clone) and modified to run on confidential data. The goal is to have the minimal set of modifications necessary to run it (ideally, the environment does all such changes).

