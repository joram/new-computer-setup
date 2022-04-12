update:

install_pyenv:
	chmod 755 ~/.bashrc
	~/.bashrc
	apt install -y virtualenv
	./helper_funcs.sh safe_git_clone https://github.com/pyenv/pyenv.git ~/.pyenv
	./helper_funcs.sh safe_git_clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
	./helper_funcs.sh add_line_to_bashrc_john '# pyenv with virtualenv'
	./helper_funcs.sh add_line_to_bashrc_john "export PYENV_ROOT='$$HOME/.pyenv'"
	./helper_funcs.sh add_line_to_bashrc_john 'export PATH="$$PYENV_ROOT/bin:$$PATH"'
	./helper_funcs.sh add_line_to_bashrc_john 'export PYENV_VIRTUALENV_DISABLE_PROMPT=1'
	./helper_funcs.sh add_line_to_bashrc_john 'export PATH="/home/john/.pyenv/shims:$${PATH}"'
	./helper_funcs.sh add_line_to_bashrc_john 'eval "$$(pyenv init -)"'
	./helper_funcs.sh add_line_to_bashrc_john 'eval "$$(pyenv virtualenv-init -)"'
	./helper_funcs.sh add_line_to_bashrc_john ''
	./helper_funcs.sh add_line_to_bashrc_john 'export VISUAL=vim'
	./helper_funcs.sh add_line_to_bashrc_john 'export EDITOR="vim"'
#	cat <<EOT >> ~/.bashrc_john
#		function updatePrompt {
#			# Styles
#			GREEN='\[\e[0;32m\]'
#			BLUE='\[\e[0;34m\]'
#			RESET='\[\e[0m\]'
#			# Base prompt: \W = working dir
#			PROMPT="\w"
#			# Current Git repo
#			if type "__git_ps1" > /dev/null 2>&1; then
#				PROMPT="\$PROMPT\$(__git_ps1 "\${GREEN}(%s)\${RESET}")"
#			fi
#			# Current virtualenv
#			if [[ \$VIRTUAL_ENV != "" ]]; then
#				PROMPT="\$PROMPT\${BLUE}{\${VIRTUAL_ENV##*/}}\${RESET}"
#			fi
#			PS1="\$PROMPT\\$ "
#		}
#		export -f updatePrompt
#
#		# Bash shell executes this function just before displaying the PS1 variable
#		export PROMPT_COMMAND='updatePrompt'
#	EOT
remove_old_bash:
	rm -f ~/.bashrc_john
	#./helper_funcs.sh add_line_to_bashrc_john "#!bash"

install_packages:
	sudo apt update
	sudo apt upgrade -y
	#sudo rm /etc/apt/preferences.d/nosnap.pref
	sudo apt install git snapd snapd-xdg-open zlib1g-dev postgresql-client -y

	# editors
	sudo apt install vim -y
	sudo snap install pycharm-professional --classic
	sudo snap install goland --classic
	sudo snap install webstorm --classic

	sudo snap install slack --classic
	sudo apt install golang -y
	sudo snap install insomnia

	# communication
	sudo snap install slack --classic

install_apps:
	./apps/aws_cli.sh
	./apps/docker.sh
	./apps/github.sh
	./apps/signal.sh
	./apps/chrome.sh
	./apps/terraform.sh

install_repos:
	# personal stuff
	./helper_funcs.sh setup_workon_alias joram new-computer-setup
	./helper_funcs.sh setup_workon_alias joram whatisthisapictureof pyenv 3.8.5
	./helper_funcs.sh setup_workon_alias joram recipes pyenv 3.8.5
	./helper_funcs.sh setup_workon_alias joram passwords pyenv 3.8.5
	./helper_funcs.sh setup_workon_alias joram steps pyenv 3.8.5
	./helper_funcs.sh setup_workon_alias joram hydroponics pyenv 3.8.5
	./helper_funcs.sh setup_workon_alias joram homepage nvm 12
	./helper_funcs.sh setup_workon_alias joram oram.ca nvm 16.13
	./helper_funcs.sh setup_workon_alias joram jsnek
	./helper_funcs.sh setup_workon_alias joram cnc
	./helper_funcs.sh setup_workon_alias joram opencam nvm 15.5.1
	./helper_funcs.sh setup_workon_alias joram mec_items pyenv 3.9.0
	./helper_funcs.sh setup_workon_alias joram trails pyenv 3.9.0
	./helper_funcs.sh setup_workon_alias joram triptracks pyenv 3.9.0
	./helper_funcs.sh setup_workon_alias joram triptracks2 pyenv 3.9.0
	./helper_funcs.sh setup_workon_alias joram news pyenv 3.9.0
	./helper_funcs.sh setup_workon_alias joram RVSecurity nvm 16.13
	./helper_funcs.sh setup_workon_alias joram crawler-experiment pyenv 3.9.0
	./helper_funcs.sh setup_workon_alias joram battlesnake-game-collector pyenv 3.9.0
	./helper_funcs.sh setup_workon_alias joram finances pyenv 3.9.0
	./helper_funcs.sh setup_workon_alias joram private-python-packages-repository-experimentation pyenv 3.9.0
	./helper_funcs.sh setup_workon_alias mkellerman dataarchive-postgres pyenv 3.10.0
	./helper_funcs.sh setup_workon_alias mkellerman dataarchive-db pyenv 3.10.0

	# certn stuff
	./helper_funcs.sh setup_workon_alias certn api_server pyenv 3.6.2 "source dev.env"
	./helper_funcs.sh setup_workon_alias certn test_framework pyenv 3.6.2
	./helper_funcs.sh setup_workon_alias certn pipeline_server pyenv 3.6.2
	./helper_funcs.sh setup_workon_alias certn billing_server pyenv 3.9.0 "source dev.env"
	./helper_funcs.sh setup_workon_alias certn pipeline_check_service_prototype pyenv 3.9.0 "source dev.env"
	./helper_funcs.sh setup_workon_alias certn web_server nvm 12
	./helper_funcs.sh setup_workon_alias certn web_local nvm 12
	./helper_funcs.sh setup_workon_alias certn certn_support nvm 13.6
	./helper_funcs.sh setup_workon_alias certn certn_deps
	./helper_funcs.sh setup_workon_alias certn certn-deploy pyenv 3.8.5
	./helper_funcs.sh setup_workon_alias certn large_data_collider pyenv 3.9.0
	./helper_funcs.sh setup_workon_alias certn canonical-data-service pyenv 3.9.0
	./helper_funcs.sh setup_workon_alias certn certn-infrastructure
	./helper_funcs.sh setup_workon_alias certn helm-charts
	./helper_funcs.sh setup_workon_alias certn argocd-apps

	./helper_funcs.sh add_line_to_bashrc_john "alias ssh_steps='ssh ubuntu@192.168.1.78'"
	./helper_funcs.sh add_line_to_bashrc_john "alias ssh_stilton='ssh john@192.168.1.221'"
	./helper_funcs.sh add_line_to_bashrc_john "alias ssh_saintAgur='ssh john@192.168.1.222'"
	./helper_funcs.sh add_line_to_bashrc_john "alias ssh_cnc='ssh john@192.168.1.209'"
	./helper_funcs.sh add_line_to_bashrc_john "alias ssh_3dprinter='ssh ubuntu@192.168.1.199'"
	./helper_funcs.sh add_line_to_bashrc_john "alias ssh_hydroponics='ssh pi@192.168.1.90'"

end:
	# requires AWS_* envs
	aws ecr get-login-password --region ca-central-1 | docker login --username AWS --password-stdin 617658783590.dkr.ecr.ca-central-1.amazonaws.com
	chmod 755 ~/.bashrc_john
	~/.bashrc_john

install: remove_old_bash install_packages install_pyenv install_repos install_apps end
