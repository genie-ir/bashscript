kg-version ()
{
	eval "git --version"
}

kg-configuration ()
{
    set -- "${1:-$K_GIT_NAME}" "${2:-$K_GIT_EMAIL}" "${3:-global}" "${4:-main}" "${5:-nano}"
	eval "git config --$3 user.name \"$1\""
	eval "git config --$3 user.email \"$2\""
	eval "git config --$3 core.editor \"$5\"" #vscode -> code --wait
	eval "git config --$3 core.autocrlf input" # mac/linux -> input | windows -> true
	eval "git config --$3 init.defaultBranch \"$4\""
	eval "git config --$3 -e"
    # system -> all users
    # global -> all repositories of the current user
    # local  -> the current repository
}

kg-init ()
{
    set -- "${1:-~/my-project}"
	eval "k-cd \"$1\""
	eval "rm -rf .git"
	eval "git init"
	eval "kg-configuration"
}

# each commit containes a `compleate snapshot of project`, dont wory about storage, git handle that prefectly.

kg-sample ()
{
	eval "kg-init $(k-strrand)"
	eval "git status"
	eval "echo hello > file1.txt" # unstaged file
	eval "echo hello > file2.txt" # unstaged file
	eval "git status"
	eval "git add ." # `.` means entire directory recursivly. we can use regexp or listing files by space.
	eval "git status"
	eval "echo world >> file1.txt" # here we have `unstaged (changes)`
	eval "git status"
	eval "git add ."
	eval "git status"
	eval "git rm --cached file2.txt" # here we have `unstaged (file)` # TODO: git restore --staged filename
	eval "git status"
	eval "git add ."
	eval "git status"
	eval "git commit"
}