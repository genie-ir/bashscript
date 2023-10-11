k-cd ()
{
    eval "mkdir -p $1 && cd $1"
}

k-strrand ()
{
    set -- "${1:-13}"
    eval "echo $(openssl rand -hex $1)"
}

k-reload ()
{
    eval "source ~/Documents/Code/bashscript/alias.bash"
}

k-underline ()
{
    eval "printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -"
}

k-ls ()
{
    eval "ls"
    eval "k-underline"
}

k-ll ()
{
    eval "ll"
    eval "k-underline"
}