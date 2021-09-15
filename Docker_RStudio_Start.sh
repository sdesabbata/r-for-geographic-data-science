REPO_DIR=${PWD}
echo ""
echo "Creating my_granolarr folder in parent directory (if it doesn't exist)"
mkdir -p $REPO_DIR/../my_r-for-geographic-data-science
echo "Run container, bind mount my_r-for-geographic-data-science folder"
docker run -d --rm -p 28787:8787 --name r-for-geographic-data-science -v $REPO_DIR:/home/rstudio/r-for-geographic-data-science -v $REPO_DIR/../my_r-for-geographic-data-science:/home/rstudio/my_r-for-geographic-data-science sdesabbata/r-for-geographic-data-science:0.1