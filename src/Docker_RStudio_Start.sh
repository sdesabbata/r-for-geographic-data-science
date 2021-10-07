REPO_DIR=${PWD}
echo ""
echo "Creating my_rgds folder in parent directory (if it doesn't exist)"
mkdir -p $REPO_DIR/../my_rgds
echo "Run container, bind mount my_rgds folder"
docker run -d --rm -p 28787:8787 --name rgds-rstudio -v $REPO_DIR:/home/rstudio/r-for-geographic-data-science -v $REPO_DIR/../my_rgds:/home/rstudio/my_rgds sdesabbata/r-for-geographic-data-science:0.2
echo "Container running at http://127.0.0.1:28787"