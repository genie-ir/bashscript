k-argparse () # specify an arbitrary list of arguments:
{
    output=$(eval "$K_COMPILER_PY $K_ROOT_DIR/python/argparse_handler.py $@")
    eval "$output"
}


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
    set -- "${1:--}"
    eval "printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' $1"
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