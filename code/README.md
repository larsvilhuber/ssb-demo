# Demonstration of Synthetic and Confidential Data Processing

We demonstrate a simple scenario.

## Development of code on open compute servers using synthetic data

This repository itself is the code. It runs a simple human capital model using the SIPP Synthetic Data [NEED CITE]. The code is written in Stata, and is confirmed to run on this site.

Basic structure:
- all code is under `/code`
- all data is under `/data`
- all outputs MUST be written to `/results`, otherwise they are lost

This is solved here through the inclusion of the [config.do](config.do) file, which defines some global variables, and instantiates logfiles.

Logfiles and other outputs can be found on CodeOcean in the right pane, under specific "runs". 


## Porting to confidential compute server

The compute capsule (or just the code?) are exported (via capsule export, or via git clone) and modified to run on confidential data. The goal is to have the minimal set of modifications necessary to run it (ideally, the environment does all such changes).

