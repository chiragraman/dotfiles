#!/bin/zsh
# Based on Mathias' prompt: https://github.com/mathiasbynens/dotfiles/blob/master/.bash_prompt

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
    echo "%{$fg_bold[white]%}on%{$reset_color%} %{$fg_bold[teal]%}${git_branch}%{$reset_color%}" | tr -d '\n'

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

    # Load color variables to make it easier to color things
    autoload -U colors && colors

    # Make using 256 colors easier
    if [[ "$(tput colors)" == "256" ]]; then
        # Change default colors
        fg[green]=$FG[064]
        fg[cyan]=$FG[037]
        fg[blue]=$FG[033]
        fg[teal]=$FG[041]
        fg[red]=$FG[160]
        fg[orange]=$FG[166]
        fg[yellow]=$FG[136]
        fg[magenta]=$FG[125]
        fg[violet]=$FG[061]
        fg[brown]=$FG[094]
        fg[neon]=$FG[112]
        fg[pink]=$FG[183]
        fg[darkred]=$FG[088]

        # Change the bold colors
        fg_bold[green]=$FX[bold]$FG[064]
        fg_bold[cyan]=$FX[bold]$FG[037]
        fg_bold[blue]=$FX[bold]$FG[033]
        fg_bold[teal]=$FX[bold]$FG[041]
        fg_bold[red]=$FX[bold]$FG[160]
        fg_bold[orange]=$FX[bold]$FG[166]
        fg_bold[yellow]=$FX[bold]$FG[136]
        fg_bold[magenta]=$FX[bold]$FG[125]
        fg_bold[violet]=$FX[bold]$FG[061]
        fg_bold[brown]=$FX[bold]$FG[094]
        fg_bold[neon]=$FX[bold]$FG[112]
        fg_bold[pink]=$FX[bold]$FG[183]
        fg_bold[darkred]=$FX[bold]$FG[088]
    else
        fg[teal]=$fg[blue]
        fg[orange]=$fg[yellow]
        fg[violet]=$fg[magenta]
        fg[brown]=$fg[orange]
        fg[neon]=$fg[green]
        fg[pink]=$fg[magenta]
        fg[darkred]=$fg[red]

        fg_bold[teal]=$fg_bold[blue]
        fg_bold[orange]=$fg_bold[yellow]
        fg_bold[violet]=$fg_bold[magenta]
        fg_bold[brown]=$fg_bold[orange]
        fg_bold[neon]=$fg_bold[green]
        fg_bold[pink]=$fg_bold[magenta]
        fg_bold[darkred]=$fg_bold[red]
    fi

    # Add the precmd hook
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd prompt_precmd

    #Set symbols for the prompt
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
