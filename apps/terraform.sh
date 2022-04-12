git clone https://github.com/tfutils/tfenv.git ~/.tfenv
./helper_funcs.sh add_line_to_bashrc_john PATH=$PATH:~/.tfenv/bin
source ~/.bashrc_john
tfenv install 1.0.0
tfenv install latest