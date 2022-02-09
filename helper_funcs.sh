#!/usr/bin/env bash

setup_workon_alias() {
  user="$1"
  repo="$2"
  repo_safe=$(sed 's/-/_/g' <<< "$repo")
  env="$3"
  version="$4"
  extra="$5"

  code_dir=~/code/
  if [ ! -d "$code_dir" ]; then
    mkdir $code_dir
  fi

  if [ "$env" == "go" ]; then
    code_dir=~/code/src
    if [ ! -d "$code_dir" ]; then
      mkdir $code_dir
    fi
    code_dir=~/code/src/github
    if [ ! -d "$code_dir" ]; then
      mkdir $code_dir
    fi
    code_dir=~/code/src/github/$user
    if [ ! -d "$code_dir" ]; then
      mkdir $code_dir
    fi

    repo_dir=~/code/src/github/$user/$repo
    if [ ! -d "$repo_dir" ]; then
      cd ~/code/src/github/$user || exit
      git clone git@github.com:"$user"/"$repo".git
    fi

  else
    user_dir=~/code/$user
    if [ ! -d "$user_dir" ]; then
      mkdir "$user_dir"
    fi

    repo_dir=~/code/$user/$repo
    if [ ! -d "$repo_dir" ]; then
      cd "$user_dir" || exit
      git clone git@github.com:"$user"/"$repo".git
    fi
  fi

  alias_line="alias workon_$repo_safe='cd $repo_dir; pyenv deactivate; $extra'"
  if [ "$env" == "pyenv" ]; then
    sudo apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

    yes no | pyenv install "$version"
    pyenv virtualenv "$version" "$repo"
    alias_line="alias workon_$repo_safe='cd $repo_dir; pyenv activate $repo'"
  fi

  if [ "$env" == "nvm" ]; then
    nvm install $version
    alias_line="alias workon_$repo_safe='cd $repo_dir; nvm use $version; pyenv deactivate'"
  fi

  echo $alias_line
  add_line_to_bashrc_john "$alias_line"


}

add_line_to_bashrc_john(){
  line=$1
  echo "adding line to ~/.bashrc_john $line"
  FILE=~/.bashrc_john
  if [[ ! -f "$FILE" ]]; then
      touch $FILE
      chmod 755 $FILE
      source_line='source ~/.bashrc_john'
      grep -qxF "$source_line" ~/.bashrc || echo $source_line >> ~/.bashrc
  fi
  grep -qxF "$line" $FILE || echo $line >> $FILE
}

safe_git_clone(){
  REPOSRC="$1"
  LOCALREPO="$2"
  LOCALREPO_VC_DIR="$LOCALREPO/.git"
  if [ ! -d $LOCALREPO_VC_DIR ]
  then
    echo "cloning $REPOSRC to $LOCALREPO"
    git clone "$REPOSRC" "$LOCALREPO"
  else
    cd $LOCALREPO
    git pull $REPOSRC
  fi
}

"$@"