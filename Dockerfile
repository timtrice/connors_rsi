FROM rocker/rstudio:latest

ARG REPO_URL="https://github.com/timtrice/connors_rsi.git"
ARG DIR="connors_rsi"

ENV ENV_REPO_URL=$REPO_URL
ENV ENV_DIR=$DIR

RUN apt-get update \
&& apt-get install -y \
libpng-dev \
libxml2-dev \
vim

RUN cd /home/rstudio \
&& git clone $ENV_REPO_URL \
&& cd $ENV_DIR \
&& Rscript --verbose R/01_install_packages.R
