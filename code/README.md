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

## The use of external packages
Stata, R, and many other programming languages use external packages of code to augment native capabilities. Initially, these need to be installed over the internet. However, there are various ways to address the issue at subsequent installations:

1. Packages can always be re-installed from source
2. Packages can be installed by a programming-language specific install script, and stored locally. 
3. Packages can be incorporated into the container image itself.

CodeOcean has the ability to do the third method, via a "post-install" script and environment setup (see [here](https://help.codeocean.com/getting-started/the-computational-environment/using-the-postinstall-script-for-further-customization) and [here](https://help.codeocean.com/tips-and-tricks/language-specific-issues/using-stata-on-code-ocean)). It can also support the first method during runtime (while connected to the internet). Because each run of Stata is transitory, there is no easy way to accomodate the second method. 

## Concrete example

This example runs a Mincer equation on the SIPP Synthetic Beta data (need cite). The code is split into 4 pieces, tied together by a script.

### Script
The script [run](run) ties all Stata programs together. An alternative would be to have both a generic run, plus a master Stata do file. Both options work.

### Stata programs
- [config.do](config.do) creates various global variables, and initializes a per-program log file, which will show up in `/results`.
- [00_setup.do](00_setup.do) initializes the code setup for each run. 
  - It could also install Stata packages from SSC (see discussion above).
- [01_stats.do](01_stats.do) computes a few simple descriptive stats. Only log output is generated, but this could generate a summary stats table ("Table 1") of a paper.
- [02_mincer.do](02_mincer.do) does data prep and runs a Mincer regression. Output is generated through `esttab`, and stored in `/results/mincer_results.csv`.

## Porting to confidential compute server

The compute capsule (or just the code?) are exported (via capsule export, or via git clone) and modified to run on confidential data. The goal is to have the minimal set of modifications necessary to run it (ideally, the environment does all such changes).
Two key modifications are needed. 

### Modifying the container base image
First, the CodeOcean-specific Linux image used to execute the code (in the case of this capsule, `registry.codeocean.com/codeocean/stata:15.0-r3.4.2-ubuntu16.04`), needs to be replaced with an image that is security-vetted for execution within the secure environment housing the confidential data. In some simple cases, this may be the same image, but stored locally (redirecting registry.codeocean.com to a local server). In other cases, it might be an equivalent image, but independently built. Presumably, CodeOcean uses relatively standard container build scripts, which could be exported and re-implemented within the secure environment.

### Modifying the input data
Second, the synthetic input data available in the public-facing environment needs to be replaced by confidential data, and certain parameters in the `config.do` modified (or dynamic code used in `config.do` that auto-detects the environment. The template code provided here suffices for that now.