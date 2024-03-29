# pull the main repo
git pull
# Initially retrieve the submodules
git submodule update --init --recursive
# Update the submodules
git submodule update --recursive --remote
