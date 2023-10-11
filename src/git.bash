# Note:
# (color) Red   -> working directory != stage directory  (from that file, point of view)
# (color) Green -> working directory == stage directory  (from that file, point of view)
# (command) commit -> save a snapshot of stage directory into repository
# (notic) after doing commit, stage directory is still alive.

kg-version ()
{
	eval "git --version"
}

kg-status ()
{
	eval "git status"
	eval "k-underline"
}

kg-ls ()
{
	eval "git ls-files"
	eval "k-underline"
}

kg-rm-both () # both -> working directory and stage directory
{
	eval "git rm -rf \"$1\""
}

kg-rm-stage () # only remove from stage directory
{
	eval "git rm --cached -rf \"$1\""
}

kg-configuration ()
{
    set -- "${1:-$K_GIT_NAME}" "${2:-$K_GIT_EMAIL}" "${3:-global}" "${4:-main}" "${5:-nano}"
	eval "git config --$3 user.name \"$1\""
	eval "git config --$3 user.email \"$2\""
	eval "git config --$3 core.editor \"$5\"" #vscode -> code --wait
	eval "git config --$3 core.autocrlf input" # mac/linux -> input | windows -> true
	eval "git config --$3 init.defaultBranch \"$4\""
	eval "git config --$3 -e" # open configuration file in default editor
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
	eval "echo \".gitignore\" > .gitignore"
	eval "kg-configuration"
}

# each commit containes a `compleate snapshot of project`, dont wory about storage, git handle that prefectly.

# NOTE: examples of git commands.
kg-ex-ls ()
{
	eval "kg-init $(k-strrand)"
	eval "kg-status"
	eval "echo hello > file1.txt" # unstaged file
	eval "echo hello > file2.txt" # unstaged file
	eval "kg-status"
	eval "git add ." # `.` means entire directory recursivly. we can use regexp or listing files by space.
	eval "kg-status"
	eval "echo world >> file1.txt" # here we have `unstaged (changes)`
	eval "kg-status"
	eval "git add ."
	eval "kg-status"
	eval "git rm --cached file2.txt" # here we have `unstaged (file)` # TODO: git restore --staged filename
	eval "kg-status"
	eval "git add ."
	eval "kg-status"
	eval "git commit" # not using -m flag, was cuesd to openning git_commit file in default editor
}

kg-ex-rm () # remove eample
{
	eval "kg-init $(k-strrand)"
	eval "kg-status"
	eval "echo hello > file1.txt" # unstaged file
	eval "echo hello > file2.txt" # unstaged file
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"
	eval "git add ."
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"
	eval "git commit -m done"
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"
	eval "rm file1.txt"
	eval "kg-status"
	eval "kg-ls" # file1 is exist on stage
	eval "k-ls"
	eval "git add ." # NOTE: do it on stage!! file1 is deleted from stage
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"
	eval "rm file2.txt"
	eval "kg-status"
	eval "kg-ls" # file2 exist on stage
	eval "k-ls"
	eval "git restore file2.txt"
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"
	eval "git commit -m ok"
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"
}

kg-ex-rm2 () # remove eample: git rm ...
{
	eval "kg-init $(k-strrand)"
	eval "kg-status"
	eval "echo hello > file1.txt" # unstaged file
	eval "echo hello > file2.txt" # unstaged file
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"
	eval "git add ."
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"
	eval "git rm -rf file1.txt" # removed file from working directory and stage directory
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"
	eval "git commit -m ok"
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"
	eval "git rm -rf file2.txt"
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"

}

kg-ex-mv () # rename example
{
	eval "kg-init $(k-strrand)"
	eval "kg-status"
	eval "echo hello > file1.txt" # unstaged file
	eval "echo hello > file2.txt" # unstaged file
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"
	eval "git add ."
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"
	eval "mv file1.txt main.js"
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"
	eval "git add ."
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"
	eval "git commit -m ok"
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"
}

kg-ex-mv2 () # rename example: git mv ...
{
	eval "kg-init $(k-strrand)"
	eval "kg-status"
	eval "echo hello > file1.txt" # unstaged file
	eval "echo hello > file2.txt" # unstaged file
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"
	eval "git add ."
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"
	eval "git mv file1.txt main.js"
	eval "kg-status"
	eval "kg-ls"
	eval "k-ls"
}

