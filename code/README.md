---
contributors:
  - Lars Vilhuber
  - Evan Totty
  - Gary Benedetto
---


## Overview

This replication package is meant to be executed both in public and restricted-access environments. Execution in public environments uses Docker, and is described in `REPLICATION.md` when downloading as a ZIP file. Execution in restricted-access environments is described in more detail in the `Description-docker-confidential.md`. Both will execute `code/run`, which in turn calls Stata programs to produce simple output. Data inputs are synthetic SIPP in public environments, and confidential "gold standard" SIPP data  in restricted environments. The only known restricted environment is within the U.S. Census Bureau.

## Data Availability and Provenance Statements

### Statement about Rights

- [x] I certify that the author(s) of the manuscript have legitimate access to and permission to use the data used in this manuscript. 
- [x] I certify that the author(s) of the manuscript have documented permission to redistribute/publish the data contained within this replication package. Appropriate permission are documented in the [LICENSE.txt](LICENSE.txt) file.


### License for Data

The synthetic data are licensed under a custom Census Bureau license, alerting users to the experimental status, and prohibiting further distribution. See <https://www.census.gov/programs-surveys/sipp/guidance/sipp-synthetic-beta-data-product.html#par_textimage_5> for details.

The confidential data require an application to the U.S. Census Bureau for use. Access can be requested through the FSRDC system (<https://www.census.gov/topics/research/guidance/restricted-use-microdata/standard-application-process.html>). The authors obtained access directly via employee access; however, that is not necessary for other researchers. (NOTE: this is for illustrative purposes only: no code was actually run on confidential data.)

### Summary of Availability

- [ ] All data **are** publicly available.
- [x] Some data **cannot be made** publicly available.
- [ ] **No data can be made** publicly available.

### Details on each Data Source



#### SIPP Synthetic Beta 7.0

> "The SIPP Synthetic Beta (SSB) is a Census Bureau product that integrates person-level micro-data from a household survey with administrative tax and benefit data. These data link respondents from the Survey of Income and Program Participation (SIPP) to Social Security Administration (SSA)/Internal Revenue Service (IRS) Form W-2 records and SSA records of retirement and disability benefit receipt, and were produced by Census Bureau staff economists and statisticians in collaboration with researchers at Cornell University, the SSA and the IRS. The purpose of the SSB is to provide access to linked data that are usually not publically available due to confidentiality concerns. To overcome these concerns, Census synthesizes, or models, all the variables in a way that changes the record of each individual so as to preserve the underlying covariate relationships between the variables." [1](https://www.census.gov/programs-surveys/sipp/guidance/sipp-synthetic-beta-data-product.html)

#### SIPP Gold Standard File 7.0

Validated results in the paper (would) use confidential microdata from the U.S. Census Bureau. To gain access to the Census microdata, follow the directions here on how to write a proposal for access to the data via a Federal Statistical Research Data Center: <https://www.census.gov/topics/research/guidance/restricted-use-microdata/standard-application-process.html>

You must request the following datasets in your proposal:

> 1. SIPP Gold Standard 7.0


## Dataset list

| Data file | Source | Notes    |Provided |
|-----------|--------|----------|---------|
| `data/ssb_v7_0_synthetic1.dta` | SSB | Synthetic Data | No |
| `confidential-data/ssb_v7_0_confidential1.dta` | SIPP Gold Standard | As per terms of use | No |


## Computational requirements


### Software Requirements

- Stata (code was last run with version 15)
  - `estout` (as of 2022-09-01)
  - `outreg` (as of 2022-09-01)
  - the program "`0_setup.do`" will install all dependencies locally, and should be run once.
- Docker (optional)

The controller file (`run`) relies on bash scripting, which may require Linux or macOS.

### Controlled Randomness

N/A.


### Memory and Runtime Requirements


#### Summary

Approximate time needed to reproduce the analyses on a standard (CURRENT YEAR) desktop machine:

- [x] <10 minutes
- [ ] 10-60 minutes
- [ ] 1-8 hours
- [ ] 8-24 hours
- [ ] 1-3 days
- [ ] 3-14 days
- [ ] > 14 days
- [ ] Not feasible to run on a desktop machine, as described below.

#### Details

A standard 2018-era laptop with 4GB of RAM should be sufficient to run the analysis.



## License for Code

The code is licensed under CC0 (public dedication) license. See [code/LICENSE](LICENSE) for details.

## Instructions to Replicators

If using synthetic data: follow instructions in `REPRODUCING.md` in the root directory to run using Docker, which uses the `run` main script.

Alternatively:

- possibly adjust paths in `config.do` (the current paths work within the Docker container)
- run Stata programs in sequence within the same Stata session, ideally by double-clicking on `00_setup.do` to start the sequence. Even better: create a `main.do` to emulate the functionality of `run`.

### Details

- `00_setup.do` will install any programs, and create output folders, if these don't yet exist.
- `01_stats.do` will generate some statistics. Statistics are printed to console/log (no separate output file is generated) (not compliant)
- `02_mincer.do` will clean the data and run a Mincer-style regression. Regression output is printed to console/log (no separate output file is generated) (not compliant)

## List of tables and programs

The code produces no meaningful output at this time, since it is meant for illustrative purposes. Summary stats and a Mincerian regression are reported in the Stata log. Regression results are provided as a CSV file in `results`. For a real application, both programs would generate tables.

The provided code reproduces:

- [x] All numbers provided in text in the paper
- [ ] All tables and figures in the paper
- [ ] Selected tables and figures in the paper, as explained and justified below.


| Figure/Table #    | Program                  | Line Number | Output file                      | Note                            |
|-------------------|--------------------------|-------------|----------------------------------|---------------------------------|
| Table 1           | code/01_stats.do         |             | In log file                 ||
| Table 2           | code/02_mincer.do        |             | /results/mincer_results.csv                      ||

## References

- U.S. Census Bureau. “SIPP Synthetic Beta Version 7.0.” [Computer file]. Washington,DC and Ithaca, NY, USA: Cornell University, Synthetic Data Server [distributor], 2015. <https://www.census.gov/programs-surveys/sipp/guidance/sipp-synthetic-beta-data-product.html>

- U.S. Census Bureau. “SIPP Gold Standard 7.0.” [Computer file]. Washington,DC, USA: Federal Statistical Research Data Center [distributor], 2015. <https://www.census.gov/topics/research/guidance/restricted-use-microdata/standard-application-process.html>


---

## Acknowledgements

Code provided for illustrative purposes by Evan Totty and Gary Benedetto.

Derived from Vilhuber et al (2020). 
