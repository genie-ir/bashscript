k-cd ()
{
    eval "mkdir -p $1 && cd $1"
}

k-strrand ()
{
    set -- "${1:-13}"
    eval "echo $(openssl rand -hex $1)"
}

