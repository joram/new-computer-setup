#sudo apt update
#sudo apt upgrade -y
sudo rm /etc/apt/preferences.d/nosnap.pref
sudo apt install git snapd snapd-xdg-open -y
sudo apt install zlib1g-dev

# browsers
apt install -y google-chrome-stable

# editors
sudo apt install vim -y
sudo snap install pycharm-professional --classic
sudo snap install goland --classic

# communication
sudo snap install slack --classic

git config --global user.email "john@oram.ca"
git config --global user.name "John Oram"

function setup_ssh() {
  ssh-keygen -t rsa -b 4096 -C "john@oram.ca"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
  sudo apt install xclip -y
  xclip -sel clip < ~/.ssh/id_rsa.pub
  while true; do
    echo "your ssh pub key is on your clipboard"
    echo "please go here, and add it: https://github.com/settings/keys"
    read -p "Have you setup the key? (y/n)" yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
  done

}

while true; do
  read -p "Do you wish to setup an ssh key (for github)? (y/n)" yn
  case $yn in
    [Yy]* ) setup_ssh; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done

rm ~/.bashrc_john


setup_workon_alias() {
  user=$1
  repo=$2
  repo_safe=$(sed 's/-/_/g' <<< "$repo")
  pyenv=$3
  version=$4

  code_dir=~/code/
  if [ ! -d "$code_dir" ]; then
    mkdir $code_dir
  fi

  user_dir=~/code/$user
  if [ ! -d "$user_dir" ]; then
    mkdir "$user_dir"
  fi

  repo_dir=~/code/$user/$repo
  if [ ! -d "$repo_dir" ]; then
    cd "$user_dir" || exit
    git clone git://github.com/"$user"/"$repo".git
  fi

  alias_line="alias workon_$repo_safe='cd $repo_dir; pyenv deactivate'"
  if [ "$pyenv" == "pyenv" ]; then
    sudo apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

    pyenv install "$version"
    pyenv virtualenv "$version" "$repo"
    alias_line="alias workon_$repo_safe='cd $repo_dir; pyenv activate $repo'"
  fi

  add_line_to_bashrc_john "$alias_line"


}

add_line_to_bashrc_john(){
  line=$1
  echo "adding line to ~/.bashrc_john $line"
  FILE=~/.bashrc_john
  if [[ ! -f "$FILE" ]]; then
      touch $FILE
      source_line='source ~/.bashrc_john'
      grep -qxF "$source_line" ~/.bashrc || echo $source_line >> ~/.bashrc
  fi
  grep -qxF "$line" $FILE || echo $line >> $FILE
}

# pyenv and virtualenv
apt install -y virtualenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
add_line_to_bashrc_john 'export PYENV_ROOT="$HOME/.pyenv"'
add_line_to_bashrc_john 'export PATH="$PYENV_ROOT/bin:$PATH"'
add_line_to_bashrc_john 'export PYENV_VIRTUALENV_DISABLE_PROMPT=1'
add_line_to_bashrc_john 'eval "$(pyenv init -)"'
add_line_to_bashrc_john 'eval "$(pyenv virtualenv-init -)"'
add_line_to_bashrc_john 'export VISUAL=vim'
add_line_to_bashrc_john 'export EDITOR="$VISUAL"'

cat <<EOT >> ~/.bashrc_john
function updatePrompt {

    # Styles
    GREEN='\[\e[0;32m\]'
    BLUE='\[\e[0;34m\]'
    RESET='\[\e[0m\]'

    # Base prompt: \W = working dir
    PROMPT="\w"

    # Current Git repo
    if type "__git_ps1" > /dev/null 2>&1; then
        PROMPT="\$PROMPT\$(__git_ps1 "\${GREEN}(%s)\${RESET}")"
    fi

    # Current virtualenv
    if [[ \$VIRTUAL_ENV != "" ]]; then
        PROMPT="\$PROMPT\${BLUE}{\${VIRTUAL_ENV##*/}}\${RESET}"
    fi

    PS1="\$PROMPT\\$ "
}
export -f updatePrompt

# Bash shell executes this function just before displaying the PS1 variable
export PROMPT_COMMAND='updatePrompt'
EOT


setup_workon_alias joram jsnek
setup_workon_alias joram whatisthisapictureof pyenv 3.8.5
setup_workon_alias joram new-computer-setup

source ~/.bashrc_john
