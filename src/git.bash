# Note:
# (color) Red   -> working directory != stage directory  (from that file, point of view)
# (color) Green -> working directory == stage directory  (from that file, point of view)
# (command) commit -> save a snapshot of stage directory into repository
# (notic) after doing commit, stage directory is still alive.
# (notic) head: specefic commit in repository. [default value: latest commit]
# (define) commit it means saving a snapshot of `stage directory` to repository.
# (define) each commit in repository is a snapshot of stage directory.

kg-version ()
{
	eval "git --version"
}

kg-configuration ()
{
    set -- "${1:-$K_GIT_NAME}" "${2:-$K_GIT_EMAIL}" "${3:-local}" "${4:-main}" "${5:-nano}"
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

kg-cfg ()
{
	set -- "${1:-local}" # system, global, local
	eval "git config --$1 -e"
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

kg-status () # workdir vs stage
{
	eval "git status -s" # output -> (stage_dir, working_dir, filename)
	eval "k-underline"
}

kg-ls-stage () # ls inside stage directory
{
	eval "git ls-files"
	eval "k-underline"
}

kg-rm-stage () # only remove from the stage directory
{
	eval "git rm --cached -rf \"$1\""
}

kg-rm-both () # both -> working directory and stage directory
{
	eval "git rm -rf \"$1\""
}

kg-show ()
{
	set -- "${1:-HEAD~0}" # $1: identifire or HEAD~n
	eval "git show $1"
	eval "k-underline"
}

kg-repository () # --show -> select commit with identifire or HEAD~n | --file -> cat file of commit that have been selected by --show flag.
{
	eval "k-argparse --arg oneline:show:file $@"
	if [ -z "$K_ARG_SHOW" ]
	then
		if [ -z "$K_ARG_ONELINE" ]
		then
			eval "git log"
		else
			eval "git log --oneline"
		fi
	else
		if [ -z "$K_ARG_FILE" ]
		then
			eval "kg-show $K_ARG_SHOW"
		else
			eval "kg-show $K_ARG_SHOW:$K_ARG_FILE"
		fi
	fi
}

kg-repo ()
{
	eval "kg-repository $@ --oneline set"
}


# Note: viewing diff is a forward operation. from (work_dir to [stage or head]) or from (stage to head)
kg-diff-workdir-stage () # The `git diff` command displays the changes between the working directory and the staging area.
{
	eval "git diff"
	eval "k-underline"
}

kg-diff-workdir-head () # shows all the changes made between the working directory and HEAD, including changes in the staging area. It displays all the changes since the last commit, whether staged for commit or not.
{
	set -- "${1:-0}"
	eval "git diff HEAD~$1" # TODO: do it code for reciving head as an argument.
	eval "k-underline"
}

kg-diff-stage-head () # The --cached option displays the changes between the staging area and the HEAD.
{
	eval "git diff --staged" #eval "git diff --cached"  --> (--staged is a synonym for --cached)
	eval "k-underline"
}















# NOTE: examples of git commands.
kg-ex-status ()
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

kg-ex-history ()
{
	eval "kg-init $(k-strrand)"
	eval "echo hello > file1.txt" # unstaged file
	eval "echo hello > file2.txt" # unstaged file
	eval "git add ."
	eval "git commit -m fs"
	eval "k-underline"
	eval "echo changes >> file1.txt"
	eval "git add ."
	eval "git commit -m sc"
	eval "k-underline"
	eval "kg-repo --show HEAD~0 --file ./file1.txt"
	eval "kg-repo --show HEAD~1 --file ./file1.txt"
	eval "kg-repo --show HEAD~0 --file ./file1.txt"
}

kg-ex-rm () # remove eample
{
	eval "kg-init $(k-strrand)"
	eval "kg-status"
	eval "echo hello > file1.txt" # unstaged file
	eval "echo hello > file2.txt" # unstaged file
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"
	eval "git add ."
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"
	eval "git commit -m done"
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"
	eval "rm file1.txt"
	eval "kg-status"
	eval "kg-ls-stage" # file1 is exist on stage
	eval "k-ls"
	eval "git add ." # NOTE: do it on stage!! file1 is deleted from stage
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"
	eval "rm file2.txt"
	eval "kg-status"
	eval "kg-ls-stage" # file2 exist on stage
	eval "k-ls"
	eval "git restore file2.txt"
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"
	eval "git commit -m ok"
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"
}

kg-ex-rm2 () # remove eample: git rm ...
{
	eval "kg-init $(k-strrand)"
	eval "kg-status"
	eval "echo hello > file1.txt" # unstaged file
	eval "echo hello > file2.txt" # unstaged file
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"
	eval "git add ."
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"
	eval "git rm -rf file1.txt" # removed file from working directory and stage directory
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"
	eval "git commit -m ok"
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"
	eval "git rm -rf file2.txt"
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"

}

kg-ex-mv () # rename example
{
	eval "kg-init $(k-strrand)"
	eval "kg-status"
	eval "echo hello > file1.txt" # unstaged file
	eval "echo hello > file2.txt" # unstaged file
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"
	eval "git add ."
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"
	eval "mv file1.txt main.js"
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"
	eval "git add ."
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"
	eval "git commit -m ok"
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"
}

kg-ex-mv2 () # rename example: git mv ...
{
	eval "kg-init $(k-strrand)"
	eval "kg-status"
	eval "echo hello > file1.txt" # unstaged file
	eval "echo hello > file2.txt" # unstaged file
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"
	eval "git add ."
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"
	eval "git mv file1.txt main.js"
	eval "kg-status"
	eval "kg-ls-stage"
	eval "k-ls"
}

kg-ex-diff () # viewing diff between workdir -> stage and stage -> head
{
	eval "kg-init $(k-strrand)"
	echo -e "viewing results:\n\n"
	eval "echo hello > file1.txt" # unstaged file
	eval "echo hello > file2.txt" # unstaged file
	eval "kg-diff-workdir-stage" # Note: stage: empty -> No diff
	eval "kg-diff-stage-head"    # Note: stage: empty -> No diff
	eval "git add ."
	eval "kg-diff-workdir-stage" # Note: work_dir and stage are same -> No diff
	eval "kg-diff-stage-head"    # Note: stage is not empty -> view diff between stage and head
	eval "git commit -m ok"
	echo -e "viewing results after commit:\n\n"
	eval "kg-diff-workdir-stage" # workdir and stage are same
	eval "kg-diff-stage-head"    # stage and head are same
}



