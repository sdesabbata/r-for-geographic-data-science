$REPO_DIR=${PWD}
Write-Output ""
Write-Output "Bind mount r-for-geographic-data-science folder from: $REPO_DIR"
docker run -ti --rm --name r-for-geographic-data-science -u rstudio -v ${REPO_DIR}:/home/rstudio/r-for-geographic-data-science sdesabbata/r-for-geographic-data-science:0.1 Rscript /home/rstudio/r-for-geographic-data-science/src/Make.R /home/rstudio/r-for-geographic-data-science