kg-version ()
{
	eval "git --version"
}

kg-configuration ()
{
    set -- "${1:-$K_GIT_NAME}" "${2:-$K_GIT_EMAIL}" "${3:-global}" "${4:-nano}"

	eval "git config --$3 user.name \"$1\""
	eval "git config --$3 user.email \"$2\""
	eval "git config --$3 core.editor \"$4\"" #vscode -> code --wait
	eval "git config --$3 core.autocrlf input" # mac/linux -> input | windows -> true
	eval "git config --$3 -e"
    # system -> all users
    # global -> all repositories of the current user
    # local  -> the current repository
}