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

The synthetic data are licensed under a custom Census Bureau license, alerting users to the experimental status, and prohibiting further distribution. See LICENSE.txt for details.

The confidential data require an application to the U.S. Census Bureau for use. Access can be requested through the FSRDC system (URL HERE). The authors obtained access directly via employee access; however, that is not necessary for other researchers. (NOTE: this is for illustrative purposes only: no code was actually run on confidential data.)

### Summary of Availability

- [ ] All data **are** publicly available.
- [x] Some data **cannot be made** publicly available.
- [ ] **No data can be made** publicly available.

### Details on each Data Source



#### SIPP Synthetic Beta 7.0

(describe data here)

#### SIPP Gold Standard File 7.0

Validated results in the paper (would) use confidential microdata from the U.S. Census Bureau. To gain access to the Census microdata, follow the directions here on how to write a proposal for access to the data via a Federal Statistical Research Data Center: https://www.census.gov/ces/rdcresearch/howtoapply.html. 

You must request the following datasets in your proposal:

> 1. SIPP Gold Standard 7.0


## Dataset list

| Data file | Source | Notes    |Provided |
|-----------|--------|----------|---------|
| `data/ssb_v7_0_synthetic1.dta` | SSB | Synthetic Data | Yes |
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



## Description of programs/code

(pending)

### License for Code



The code is licensed under CC0 (public dedication) license. See [code/LICENSE](LICENSE) for details.

## Instructions to Replicators

If using synthetic data: follow instructions in `REPLICATION.md` in the root directory to run using Docker, which uses the `run` main script.

Alternatively:

- possibly adjust paths in `00_setup.do`
- run Stata programs in sequence within the same Stata session, ideally by double-clicking on `00_setup.do` to start the sequence. Even better: create a `main.do` to emulate the functionality of `run`.

### Details

(coming)

## List of tables and programs

The code produces no meaningful output at this time, since it is meant for illustrative purposes. Summary stats and a Mincerian regression are reported in the Stata log. For a real application, both programs would generate tables, and output these via `outreg`.

The provided code reproduces:

- [x] All numbers provided in text in the paper
- [ ] All tables and figures in the paper
- [ ] Selected tables and figures in the paper, as explained and justified below.


| Figure/Table #    | Program                  | Line Number | Output file                      | Note                            |
|-------------------|--------------------------|-------------|----------------------------------|---------------------------------|
| Table 1           | code/01_stats.do         |             | TBD                 ||
| Table 2           | code/02_mincer.do        |             | TBD                       ||

## References

(to be updated)

- SIPP Gold Standard
- SSB

---

## Acknowledgements

Derived from Vilhuber et al (2020). Some content on this page was copied from [Hindawi](https://www.hindawi.com/research.data/#statement.templates). Other content was adapted  from [Fort (2016)](https://doi.org/10.1093/restud/rdw057), Supplementary data, with the author's permission.
