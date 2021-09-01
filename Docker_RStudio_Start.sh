REPO_DIR=${PWD}
echo ""
echo "Creating my_granolarr folder in parent directory (if it doesn't exist)"
mkdir -p $REPO_DIR/../my_granolarr
echo "Run container, bind mount my_granolarr folder"
docker run -d --rm -p 28787:8787 --name granolarr -v $REPO_DIR:/home/rstudio/granolarr -v $REPO_DIR/../my_granolarr:/home/rstudio/my_granolarr sdesabbata/granolarr