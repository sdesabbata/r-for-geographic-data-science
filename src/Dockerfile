# Base image https://hub.docker.com/r/rocker/geospatial
FROM rocker/geospatial:4.3.1

# create an R user
ENV USER rstudio

# Install additional required R libraries
COPY ./docker_config/Requirements.R /tmp/Requirements.R
RUN Rscript /tmp/Requirements.R