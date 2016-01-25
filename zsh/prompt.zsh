#!/bin/zsh

###
# Git functions
###

git_info() {
    # Reset info variables
    git_branch=
    git_status=

    # Check if the current directory is in a Git repository.
	if [ $($git rev-parse --is-inside-work-tree &>/dev/null; \
    echo "${?}") '==' '0' ]; then

		# check if the current directory is in .git before running git checks
		if [ "$($git rev-parse --is-inside-git-dir 2>/dev/null)" '==' 'false' ]; then

			# Ensure the index is up to date.
			$git update-index --really-refresh -q &>/dev/null;

			# Check for uncommitted changes in the index.
			if ! $($git diff --quiet --ignore-submodules --cached); then
				git_status+=$GIT_STATUS_UNCOMMITED;
			fi;

			# Check for unstaged changes.
			if ! $($git diff-files --quiet --ignore-submodules --); then
				git_status+=$GIT_STATUS_UNSTAGED;
			fi;

			# Check for untracked files.
			if [ -n "$($git ls-files --others --exclude-standard)" ]; then
				git_status+=$GIT_STATUS_UNTRACKED;
			fi;

            # Check git arrows
            git_check_arrows
            git_status+=${git_arrows}

            # Check for stashed files.
			if $($git rev-parse --verify refs/stash &>/dev/null); then
				git_status+=$GIT_STATUS_STASHED;
			fi;

		fi;

        # If the git status is set, add the prefix and suffix
        [ -n "${git_status}" ] && \
        git_status=" $GIT_STATUS_PREFIX${git_status}$GIT_STATUS_SUFFIX"

        # Get the short symbolic ref.
		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		git_branch="$($git symbolic-ref --quiet --short HEAD 2>/dev/null || \
			$git rev-parse --short HEAD 2>/dev/null || \
			echo '(unknown)')"
	else
		return;
	fi;
}

#cheers Sindre Sorhus <https://github.com/sindresorhus/pure>
git_check_arrows() {
	# Reset git arrows
	git_arrows=

	# Check if there is an upstream configured for this branch
	command $git rev-parse --abbrev-ref @'{u}' &>/dev/null || return

	local arrow_status

    # Check git left and right arrow_status
	arrow_status="$(command $git rev-list --left-right --count HEAD...@'{u}' 2>/dev/null)"

    # Exit if the command failed
	(( !$? )) || return

	# Left and right are tab-separated, split on tab and store as array
	arrow_status=(${(ps:\t:)arrow_status})
	local arrows left=${arrow_status[1]} right=${arrow_status[2]}

	(( ${right:-0} > 0 )) && arrows+=$GIT_STATUS_BEHIND
	(( ${left:-0} > 0 )) && arrows+=$GIT_STATUS_AHEAD

	[[ -n $arrows ]] && git_arrows="${arrows}"
}

git_prompt(){
    # Check if a branch name has been set
    ! [ -n git_branch ] && return;

    # Print the branch name
    echo "%{$fg_bold[white]%}on%{$reset_color%} %{$fg_bold[cyan]%}${git_branch}%{$reset_color%}" | tr -d '\n'

    # Print the git status, if applicable
    [ -n "${git_status}" ] && \
    echo "%{$fg_bold[blue]%}${git_status}%{$reset_color%}"
}

###
# Misc. functions
###

directory_name() {
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

###
# Hooks
###
prompt_precmd() {
    #get git information
    git_info
}

###
# Setup
###
prompt_setup() {
    # prevent percentage showing up if output doesn't end with a newline
	export PROMPT_EOL_MARK=''

    prompt_opts=(subst percent)

    autoload -U colors && colors
    autoload -Uz add-zsh-hook

    add-zsh-hook precmd prompt_precmd

    #Set symbols and colors
    GIT_STATUS_PREFIX="["
    GIT_STATUS_SUFFIX="]"
    GIT_STATUS_AHEAD="↑"
    GIT_STATUS_BEHIND="↓"
    GIT_STATUS_UNTRACKED="?"
    GIT_STATUS_UNSTAGED="!"
    GIT_STATUS_UNCOMMITED="+"
    GIT_STATUS_STASHED="$"
    PROMPT_SYMBOL="%{$fg_bold[white]%}❯%{$reset_color%}"

    if (( $+commands[git] ))
    then
      git="$commands[git]"
    else
      git="/usr/bin/git"
    fi

    #Define the prompts
    export PROMPT=$'\n%{$fg_bold[white]%}in $(directory_name) $(git_prompt)\n$PROMPT_SYMBOL '

    export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

prompt_setup "%@"
