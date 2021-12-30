# install brew
echo "[Brew]"
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "Installing"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Updating"
    brew update
fi

echo "[Vimac]"
if [[ ! -d "/Applications/vimac.app" ]]; then
	echo "Installing"
	# install vimac
	brew tap kidonng/malt
	brew install vimac
else
	echo "Already installed"
fi 
