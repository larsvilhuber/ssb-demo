# hash:sha256:ffd2bb313417cff79c49583e124f80ebb4358de6b4c5f1762999db633c728474
FROM registry.codeocean.com/codeocean/stata:16.0-ubuntu18.04

ARG DEBIAN_FRONTEND=noninteractive

COPY stata.lic /usr/local/stata/stata.lic
RUN stata 'ssc install estout' \
    && stata 'ssc install outreg' # Original versions: 7 Jan 2020 18 Aug 2022
