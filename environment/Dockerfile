# hash:sha256:fee30791ba1952f3d647feeb46dcc3901bb5d074e0d5742586e56d9ff78c47bc
FROM registry.codeocean.com/codeocean/stata:15.0-r3.4.2-ubuntu16.04

ARG DEBIAN_FRONTEND=noninteractive

COPY stata.lic /usr/local/stata/stata.lic
RUN stata 'ssc install estout' \
    && stata 'ssc install outreg' # Original versions: latest latest
