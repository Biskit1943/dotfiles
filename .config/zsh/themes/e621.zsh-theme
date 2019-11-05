export VIRTUAL_ENV_DISABLE_PROMPT=1
export ZSH_THEME_PROMPT_ON_NEW_LINE=true
prompt_distro_fg=${DISTRO_COLOUR:-green}
prompt_host_fg=${HOST_COLOUR:-cyan}
prompt_root_red=196
prompt_line_fg="%(!.$prompt_root_red.15)"

prompt_head_start="."
prompt_line="-"
prompt_branch="|"
prompt_arrow_start="\`"
prompt_arrow_user=">"
prompt_arrow_root="%F{white}%K{$prompt_root_red}#%k%f"
prompt_dots="..."
# Git related
prompt_branch=">"
prompt_staged="%F{orange}+%f"
prompt_unstaged="%F{magenta}!%f"
width_un_staged=$(( $(echo -n $prompt_staged | wc -m) ))
# Python related
prompt_venv=""

prompt_enable_utf8() {
  prompt_head_start="┌"
  prompt_line="─"
  prompt_branch="├"
  prompt_arrow_start="└"
  prompt_arrow_user="›"
  prompt_dots="…"
  # Git related
  prompt_branch=""
  prompt_staged="%F{orange}✚%f"
  prompt_unstaged="%F{magenta}●%f"
  # Python related
  prompt_venv=" "
}

prompt_start_input_line() {
  # Beginning of an arrow: \-
  echo "%F{$prompt_line_fg}${prompt_arrow_start}${prompt_line}%f"
}

prompt_branch_prev_line() {
  # Turns \- into |- on the previous line
  # Not sure about this one, there are some extra quotes in adam2 for some reason
  echo "%{\e[A\r%}%F{$prompt_line_fg}$prompt_branch%f%{\e[B\r%}"
}

prompt_subst_width() {
  # Returns the number of characters from $1 | ~ => 1 | ~/Pictures => 10
  echo ${#${(S%%)1}}
}

prompt_replicate() {
    char="$1" size="$2"
    eval "echo \${(l:${size}::${char}:)}"
}

prompt_git() {
  (( $+commands[git] )) || return
  if [[ "$(git config --get oh-my-zsh.hide-status 2>/dev/null)" = 1 ]]; then
    return
  fi
  local ref dirty mode repo_path

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    repo_path=$(git rev-parse --git-dir 2>/dev/null)
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr $prompt_staged  # ✚
    zstyle ':vcs_info:*' unstagedstr $prompt_unstaged  # ●
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "${prompt_line}[%B${ref/refs\/heads\//$prompt_branch }${vcs_info_msg_0_%% }${mode}%b]"
  fi
}

prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    echo -n "(%B%F{green}$prompt_venv`basename $virtualenv_path`%f%b)"
  fi
}


prompt_ps1_line1() {
  dir_raw="%~"                                 # Get the current dir
  dir_width=$(prompt_subst_width "$dir_raw")   # Get the dir length

  git_raw="$(prompt_git)"                      # Get the git stuff
  git_width=$(prompt_subst_width "$git_raw")  # Add git length
  if [[ "$git_width" -ne 0 ]]; then
    # This will fix the 5 characters that are to much calculated
    git_width=$(( git_width - (width_un_staged - 5) ))
  fi

  # Generate left segment
  left="%F{$prompt_line_fg}${prompt_head_start}${prompt_line}%f(%B%F{$prompt_distro_fg}${dir_raw}%f%b)$git_raw"

  right_raw="%n@%m"
  right_width=$(prompt_subst_width "$right_raw")
  right_raw="%(!.%K{$prompt_root_red}.)%n%(!.%K.)@%B%m%b"
  right="(%F{$prompt_host_fg}${right_raw}%f)%F{$prompt_line_fg}${prompt_line}%f"

  prompt_start=""
  if [[ $ZSH_THEME_PROMPT_ON_NEW_LINE ]]; then
    prompt_start="\n"
  fi

  # Try to fit both parts:
  # .-(~/bar/path)----------------(user@host)-
  # (2 + 2 + 2 + 1)  ==> 2 char before dir + dir backets + host brackets + one right of host
  padding_size=$(( COLUMNS - dir_width - git_width - right_width - (2 + 2 + 2 + 1) ))
  if (( padding_size > 0 )); then
    padding=$(prompt_replicate "$prompt_line" "$padding_size")
    echo "$prompt_start${left}%F{$prompt_line_fg}${padding}%f${right}%F"
    return
  fi

  # Try to fit only left part:
  # .-(~/bar/path)-------------
  padding_size=$(( COLUMNS - dir_width - git_width - (2 + 2 + 1) ))
  if (( padding_size > 0 )); then
    padding=$(prompt_replicate "$prompt_line" "$padding_size")
    echo "$prompt_start${left}%F{$prompt_line_fg}${padding}%f"
    return
  fi

  # Truncate left part:
  # .-(...ar/path)-
  dir_width=$(( COLUMNS - (2 + 2 + 1) ))

  left="%F{$prompt_line_fg}${prompt_head_start}${prompt_line}%f(%B%F{$prompt_distro_fg}%$dir_width<${prompt_dots}<${dir_raw}%<<%f%b)"
  echo "$prompt_start${left}%F{${prompt_line_fg}}${prompt_line}%f"
}

prompt_ps1_line2() {
  venv_raw="$(prompt_virtualenv)"
  echo "$(prompt_start_input_line)$venv_raw%F{$prompt_host_fg}%B%(!.${prompt_arrow_root}.${prompt_arrow_user})%b%f "
}

prompt_ps2() {
  echo "$(prompt_branch_prev_line)$(prompt_start_input_line)%F{$prompt_distro_fg}%B%_${prompt_arrow_user}%b%f "
}

prompt_ps3() {
  echo "$(prompt_branch_prev_line)$(prompt_start_input_line)%F{$prompt_distro_fg}%B?#%b%f "
}

setopt PROMPT_SUBST PROMPT_CR PROMPT_PERCENT
PS1=$'$(prompt_ps1_line1)\n$(prompt_ps1_line2)'
RPS1="%(?..%B%F{red}<%?>%f%b)"
PS2=$'$(prompt_ps2)'
PS3=$'$(prompt_ps3)'
zle_highlight[(r)default:*]="default:bold"

if [[ ${LC_ALL:-${LC_CTYPE:-$LANG}} = *UTF-8* ]]; then
  # Do not enable on tty
  tmp_string="$(tty)"
  tmp_substring="tty"
  if [[ "${tmp_string#*$tmp_substring}" = "$tmp_string" ]]; then
    prompt_enable_utf8
  fi
fi
