FROM registry.codeocean.com/codeocean/stata:15.0-r3.4.2-ubuntu16.04

ARG DEBIAN_FRONTEND=noninteractive

COPY license.lic /usr/local/stata/stata.lic
RUN stata 'ssc install estout' # version 3.21
