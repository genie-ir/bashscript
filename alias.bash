SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source "$SCRIPT_DIR/src/.bash"
source "$SCRIPT_DIR/src/kernel.bash"
source "$SCRIPT_DIR/src/ssh.bash"
source "$SCRIPT_DIR/src/ngnix.bash"
source "$SCRIPT_DIR/src/git.bash"
source "$SCRIPT_DIR/src/docker.bash"
source "$SCRIPT_DIR/src/django.bash"
source "$SCRIPT_DIR/src/pkg.bash"









# if [ -z "$CHECK_ALIASING" ]; then
# 	echo "source ~/alias.bash" >> ~/.bashrc
# fi

# install -> i
# alias ipy3="sudo apt-get update && sudo apt install python3-pip -y && iipython"


# CD ()
# {
#     eval "mkdir -p $1 && cd $1"
# }


# ksplit ()
# {
# 	set -- "${1:-}" "${2:-1G}" "${3:-$(openssl rand -hex 12)}"
# 	local oldpath=$(pwd)
# 	eval "mkdir -p $3"
# 	eval "cd $3"
# 	eval "split ../$1 -b$2"
# 	eval "cd $oldpath"
# }


# dmssh ()
# {
# 	local msg1=$(echo "$1" | sed -e 's/\s/_/g')
# 	eval "curl --silent localhost:$remotetolocalport/notify/$USER@$(hostname)/$msg1"
# }