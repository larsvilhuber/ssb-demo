# Demonstration of Synthetic and Confidential Data Processing

We demonstrate a simple scenario of using containers (Docker) hosted on CodeOcean to faciliate synthetic and confidential data processing. The purpose of using containers is to provide users with access to data and coding resources such that
their analysis is easily reproducible. CodeOcean is a commercial service facilitating that process by making the resources available through a web browser, though the basic functionality can be achieved on any container system. 

Reproducibility is important for synthetic data products when there
is a validation or verification process involved. In such a setting, data users will first use the synthetic
data to build and test their code for a desired analysis. Once the user is satisfied with the code used to
perform their analysis, they can request a validation and their code will be run by the Census Bureau on
the confidential data. Output from the analysis on the confidential data will then have to satisfy the
Census Bureau’s Disclosure Review Board requirements before it can be released to the user.

In order for this process to run smoothly, the data user’s code needs to be able to run succesfully on any
machine, regardless of any local settings. This ensures that the user’s code can be easily transferred and
run on the confidential data. This can be achieved by using a "container." A container collects all of the
necessary libraries, dependencies, and code needed to run an analysis in a single
package. This container can then be downloaded to any machine and used with the local system to run
the application.

CodeOcean uses a compute capsule, based on a Docker container, that can help ensure that the entire code
building, validation, and output release process is simple and efficient for both the data user and the
Census Bureau. The Census Bureau can use CodeOcean to house both the synthetic dataset as well as
setup and configuration code that will assist the data user in creating code that is reproducible. The data
user can then build on the setup and configuration code provided by the Census Bureau to perform their
desired analysis. To perform the analysis on the synthetic data, users may either run the code directly on
CodeOcean by paying for access to computing resources (CodeOcean also provides a limited amount of
storage space and computing time for free), or they may download the compute capsule to their local
machine and user their own computing resources. When the user requests a validation, the Census
Bureau can download the user’s compute capsule, make minimal changes to excecute the analysis on a
secure sever with the confidential data, and then run the user’s code and reproduce their analysis on
the confidential data.

In addition to providing a location for the Census Bureau and data users to share access to the synthetic
dataset and code, it also ensures that the analysis will run correctly for both the data user and on the
confidential data. One problem that can arise when maintaining a validation process is when the
computing environment on the data user’s end does not exactly match the computing environment for
the internal validation. This can lead to validation attempts that fail to run correctly or at all, which
increases the wait time for data users and the time involved in performing the validation for the Census
Bureau. The compute capsules on CodeOcean can prevent this problem by packaging not only the data
and analysis code, but also specifying the computational environment. By ensuring that everything can
run within the CodeOcean compute capsule using the synthetic data, it also ensures that everything can
be run within the associated compute capsule's container using the confidential data, even when the confidential data is not housed on CodeOcean or any publicly accessible service.

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

The compute capsule are exported (via "Capsule -> Export"), or via git clone, and modified to run on confidential data. The goal is to have the minimal set of modifications necessary to run it (ideally, the environment does all such changes).
Two key modifications are needed. 

### Modifying the container base image

First, the CodeOcean-specific Linux image used to execute the code (in the case of this capsule, `registry.codeocean.com/codeocean/stata:15.0-r3.4.2-ubuntu16.04`), needs to be replaced with an image that is security-vetted for execution within the secure environment housing the confidential data. In some simple cases, this may be the same image, but stored locally (redirecting registry.codeocean.com to a local server). In other cases, it might be an equivalent image, but independently built. Presumably, CodeOcean uses relatively standard container build scripts, which could be exported and re-implemented within the secure environment. 

### Modifying the input data

Second, the synthetic input data available in the public-facing environment needs to be replaced by confidential data, and certain parameters in the `config.do` modified (or dynamic code used in `config.do` that auto-detects the environment. The template code provided here suffices for that.