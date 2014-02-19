#!/usr/bin/env bash
# Sexy bash prompt by twolfson
# https://github.com/twolfson/sexy-bash-prompt
# Forked from gf3, https://gist.github.com/gf3/306785
if [[ \$COLORTERM = gnome-* && \$TERM = xterm ]]  && infocmp gnome-256color >/dev/null 2>&1; then export TERM=gnome-256color
    elif [[ \$TERM != dumb ]] && infocmp xterm-256color >/dev/null 2>&1; then export TERM=xterm-256color
fi

# If we are on a colored terminal
if tput setaf 1 &> /dev/null; then
  # Reset the shell from our `if` check
  tput sgr0 &> /dev/null

  # If you would like to customize your colors, use
  # # Attribution: http://linuxtidbits.wordpress.com/2008/08/11/output-color-on-bash-scripts/
  # for i in $(seq 0 $(tput colors)); do
  #   echo " $(tput setaf $i)Text$(tput sgr0) $(tput bold)$(tput setaf $i)Text$(tput sgr0) $(tput sgr 0 1)$(tput setaf $i)Text$(tput sgr0)  \$(tput setaf $i)"
  # done

  # Save common color actions
  prompt_bold="$(tput bold)"
  prompt_reset="$(tput sgr0)"
    
#PS1 'hostmachine:~ username$ '
if [ $(id -u) -eq 0 ];
then # you are root, set red colour prompt
    prompt_u_c="$prompt_bold$(tput setaf 1)"    
else # normal
    prompt_u_c="$prompt_bold$(tput setaf 27)"
fi


  # If the terminal supports at least 256 colors, write out our 256 color based set
  if [[ $(tput colors) -ge 256 ]] &> /dev/null; then
    prompt_user_color="$prompt_u_c" # BOLD BLUE
    prompt_preposition_color="$prompt_bold$(tput setaf 7)" # BOLD WHITE
    prompt_device_color="$prompt_bold$(tput setaf 39)" # BOLD CYAN
    prompt_dir_color="$prompt_bold$(tput setaf 76)" # BOLD GREEN
    prompt_git_status_color="$prompt_bold$(tput setaf 154)" # BOLD YELLOW
  else
  # Otherwise, use colors from our set of 8
    prompt_user_color="$prompt_bold$(tput setaf 4)" # BOLD BLUE
    prompt_preposition_color="$prompt_bold$(tput setaf 7)" # BOLD WHITE
    prompt_device_color="$prompt_bold$(tput setaf 6)" # BOLD CYAN
    prompt_dir_color="$prompt_bold$(tput setaf 2)" # BOLD GREEN
    prompt_git_status_color="$prompt_bold$(tput setaf 3)" # BOLD YELLOW
  fi

  prompt_symbol_color="$prompt_bold" # BOLD

else
# Otherwise, use ANSI escape sequences for coloring
  # If you would like to customize your colors, use
  # DEV: 30-39 lines up 0-9 from `tput`
  # for i in $(seq 0 109); do
  #   echo -n -e "\033[1;${i}mText$(tput sgr0) "
  #   echo "\033[1;${i}m"
  # done

  prompt_reset="\033[m"
  prompt_user_color="\033[1;34m" # BLUE
  prompt_preposition_color="\033[1;37m" # WHITE
  prompt_device_color="\033[1;36m" # CYAN
  prompt_dir_color="\033[1;32m" # GREEN
  prompt_git_status_color="\033[1;33m" # YELLOW
  prompt_symbol_color="" # NORMAL
fi

# Apply any color overrides that have been set in the environment
if [[ -n "$PROMPT_USER_COLOR" ]]; then prompt_user_color="$PROMPT_USER_COLOR"; fi
if [[ -n "$PROMPT_PREPOSITION_COLOR" ]]; then prompt_preposition_color="$PROMPT_PREPOSITION_COLOR"; fi
if [[ -n "$PROMPT_DEVICE_COLOR" ]]; then prompt_device_color="$PROMPT_DEVICE_COLOR"; fi
if [[ -n "$PROMPT_DIR_COLOR" ]]; then prompt_dir_color="$PROMPT_DIR_COLOR"; fi
if [[ -n "$PROMPT_GIT_STATUS_COLOR" ]]; then prompt_git_status_color="$PROMPT_GIT_STATUS_COLOR"; fi
if [[ -n "$PROMPT_SYMBOL_COLOR" ]]; then prompt_symbol_color="$PROMPT_SYMBOL_COLOR"; fi

function get_git_branch() {
  # On branches, this will return the branch name
  # On non-branches, (no branch)
  ref="$(git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///')"
  if [[ $ref != "" ]]; then
    echo $ref
  else
    echo "(no branch)"
  fi
}

is_branch1_behind_branch2 () {
  # $ git log origin/master..master -1
  # commit 4a633f715caf26f6e9495198f89bba20f3402a32
  # Author: Todd Wolfson <todd@twolfson.com>
  # Date:   Sun Jul 7 22:12:17 2013 -0700
  #
  #     Unsynced commit

  # Find the first log (if any) that is in branch1 but not branch2
  first_log="$(git log $1..$2 -1 2> /dev/null)"

  # Exit with 0 if there is a first log, 1 if there is not
  [[ -n "$first_log" ]]
}

branch_exists () {
  # List remote branches           | # Find our branch and exit with 0 or 1 if found/not found
  git branch --remote 2> /dev/null | grep --quiet "$1"
}

parse_git_ahead () {
  # Grab the local and remote branch
  branch="$(get_git_branch)"
  remote_branch=origin/"$branch"

  # $ git log origin/master..master
  # commit 4a633f715caf26f6e9495198f89bba20f3402a32
  # Author: Todd Wolfson <todd@twolfson.com>
  # Date:   Sun Jul 7 22:12:17 2013 -0700
  #
  #     Unsynced commit

  # If the remote branch is behind the local branch
  # or it has not been merged into origin (remote branch doesn't exist)
  if (is_branch1_behind_branch2 "$remote_branch" "$branch" ||
      ! branch_exists "$remote_branch"); then
    # echo our character
    echo 1
  fi
}

parse_git_behind () {
  # Grab the branch
  branch="$(get_git_branch)"
  remote_branch=origin/"$branch"

  # $ git log master..origin/master
  # commit 4a633f715caf26f6e9495198f89bba20f3402a32
  # Author: Todd Wolfson <todd@twolfson.com>
  # Date:   Sun Jul 7 22:12:17 2013 -0700
  #
  #     Unsynced commit

  # If the local branch is behind the remote branch
  if is_branch1_behind_branch2 "$branch" "$remote_branch"; then
    # echo our character
    echo 1
  fi
}

parse_git_dirty () {
  # ?? file.txt # Unstaged new files
  # A  file.txt # Staged new files
  #  M file.txt # Unstaged modified files
  # M  file.txt # Staged modified files
  #  D file.txt # Unstaged deleted files
  # D  file.txt # Staged deleted files

  # If the git status has *any* changes (i.e. dirty)
  if [[ -n "$(git status --porcelain 2> /dev/null)" ]]; then
    # echo our character
    echo 1
  fi
}

function is_on_git() {
  git rev-parse 2> /dev/null
}

function get_git_status() {
  # Grab the git dirty and git behind
  dirty_branch="$(parse_git_dirty)"
  branch_ahead="$(parse_git_ahead)"
  branch_behind="$(parse_git_behind)"

  # Iterate through all the cases and if it matches, then echo
  if [[ $dirty_branch == 1 && $branch_ahead == 1 && $branch_behind == 1 ]]; then
    echo "⬢"
  elif [[ $dirty_branch == 1 && $branch_ahead == 1 ]]; then
    echo "▲"
  elif [[ $dirty_branch == 1 && $branch_behind == 1 ]]; then
    echo "▼"
  elif [[ $branch_ahead == 1 && $branch_behind == 1 ]]; then
    echo "⬡"
  elif [[ $branch_ahead == 1 ]]; then
    echo "△"
  elif [[ $branch_behind == 1 ]]; then
    echo "▽"
  elif [[ $dirty_branch == 1 ]]; then
    echo "*"
  fi
}

get_git_info () {
  # Grab the branch
  branch="$(get_git_branch)"

  # If there are any branches
  if [[ "$branch" != "" ]]; then
    # Echo the branch
    output="$branch"

    # Add on the git status
    output=$output"$(get_git_status)"

    # Echo our output
    echo "$output"
  fi
}

# Symbol displayed at the line of every prompt
function get_prompt_symbol() {
  # If we are root, display `#`. Otherwise, `$`
  if [[ $UID == 0 ]]; then
    echo "#"
  else
    echo "\$"
  fi
}

# Define the sexy-bash-prompt
PS1="\[$prompt_user_color\]\u\[$prompt_reset\] \
\[$prompt_preposition_color\]at\[$prompt_reset\] \
\[$prompt_device_color\]\h\[$prompt_reset\] \
\[$prompt_preposition_color\]in\[$prompt_reset\] \
\[$prompt_dir_color\]\w\[$prompt_reset\]\
\$( is_on_git && \
  echo -n \" \[$prompt_preposition_color\]on\[$prompt_reset\] \" && \
  echo -n \"\[$prompt_git_status_color\]\$(get_git_info)\" && \
  echo -n \"\[$prompt_preposition_color\]\")\n\[$prompt_reset\]\
\[$prompt_symbol_color\]$(get_prompt_symbol) \[$prompt_reset\]"

#Hostcolors

lion='\[\e[0;36m\]'         #macbook air, cyan
corny='\[\e[0;32m\]'        #pi, green
bounty='\[\e[0;35m\]'       #macbook, purple
duplo='\[\e[0;33m\]'        #ams1 digital ocean server, yellow
butterfinger='\[\e[1;37m\]' #butterfinger, white
milkyway=$MAGENTA           #milkyway
default='\[\e[1;31m\]'      #orange 

wonderbar='\[\e[0;37m\]'    #iphone  
kitkat='\[\e[0;37m\]'       #kindle
#list of possible future hostnames
hostn=`hostname -s`

case $hostn in
lion)
    hostncolor=$lion
    ;;
corny)
    hostncolor=$corny
    ;;
bounty)
    hostncolor=$bounty
    ;;
duplo)
    hostncolor=$duplo
    ;;
butterfinger)
    hostncolor=$butterfinger
    ;;
wonderbar)
    hostncolor=$wonderbar
    ;;
kitkat)
    hostncolor=$kitkat
    ;;
milkyway)
    hostncolor=$milkyway
    ;;
*) 
    hostncolor=$default
    echo "color not defined"
esac
#debugging
#echo $hostn
#echo $hostncolor

#PS1 'hostmachine:~ username$ '
#if [ $(id -u) -eq 0 ];
#then # you are root, set red colour prompt
#    PS1="\[\e[1;31m\]\h\[\e[0;38m\]:\[\e[0;32m\]\w \[\e[0;36m\]\u\[\e[0;37m\]\$ \[\033[0m\]"
#else # normal
#    PS1="$hostncolor\h\[\e[0;38m\]:\[\e[0;32m\]\w \[\e[0;36m\]\u\[\e[0;37m\]\$ \[\033[0m\]"
#fi

##http://www.bergspot.com/blog/2012/02/how-to-fix-warning-setlocale-lc_ctype-cannot-change-locale-utf-8/
##manual locale set
export LANG="de_DE.UTF-8"
export LC_CTYPE="de_DE.UTF-8"
export LC_ALL="de_DE.UTF-8"
