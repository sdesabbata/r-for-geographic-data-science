REPO_DIR=${PWD}
echo ""
echo "Bind mount r-for-geographic-data-science folder from: $REPO_DIR"
docker run -ti --rm --name r-for-geographic-data-science -u rstudio -v $REPO_DIR:/home/rstudio/r-for-geographic-data-science sdesabbata/r-for-geographic-data-science:4.2.2 Rscript /home/rstudio/r-for-geographic-data-science/src/Make.R /home/rstudio/r-for-geographic-data-science
