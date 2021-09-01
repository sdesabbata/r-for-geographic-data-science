$REPO_DIR=${PWD}
Write-Output ""
Write-Output "Bind mount granolarr folder from: $REPO_DIR"
docker run -ti --rm --name granolarr -u rstudio -v ${REPO_DIR}:/home/rstudio/granolarr sdesabbata/granolarr Rscript /home/rstudio/granolarr/Make.R /home/rstudio/granolarr
