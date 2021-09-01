# Base image https://hub.docker.com/r/rocker/ml
FROM rocker/geospatial:4.0.2

# create an R user
ENV USER rstudio

# Install additional required R libraries
COPY ./src/docker_config/Requirements.R /tmp/Requirements.R
RUN Rscript /tmp/Requirements.R

# Update tlmgr
RUN tlmgr update --self

# Install additional required TeX libraries
RUN tlmgr install amsmath
RUN tlmgr install latex-amsmath-dev
RUN tlmgr install iftex
RUN tlmgr install euenc
RUN tlmgr install fontspec
RUN tlmgr install tipa
RUN tlmgr install unicode-math
RUN tlmgr install xunicode
RUN tlmgr install kvoptions
RUN tlmgr install ltxcmds
RUN tlmgr install kvsetkeys
RUN tlmgr install etoolbox
RUN tlmgr install xcolor
RUN tlmgr install atbegshi
RUN tlmgr install atveryend
RUN tlmgr install auxhook
RUN tlmgr install bigintcalc
RUN tlmgr install bitset
RUN tlmgr install etexcmds
RUN tlmgr install gettitlestring
RUN tlmgr install hycolor
RUN tlmgr install hyperref
RUN tlmgr install intcalc
RUN tlmgr install kvdefinekeys
RUN tlmgr install letltxmacro
RUN tlmgr install pdfescape
RUN tlmgr install refcount
RUN tlmgr install rerunfilecheck
RUN tlmgr install stringenc
RUN tlmgr install uniquecounter
RUN tlmgr install zapfding
RUN tlmgr install pdftexcmds
RUN tlmgr install infwarerr
RUN tlmgr install fancyvrb
RUN tlmgr install framed
RUN tlmgr install booktabs
RUN tlmgr install mdwtools
RUN tlmgr install grffile
RUN tlmgr install geometry
RUN tlmgr install epstopdf-pkg
