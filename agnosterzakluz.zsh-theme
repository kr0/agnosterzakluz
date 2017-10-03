# vim:ft=zsh ts=2 sw=2 sts=2
#
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for ZSH
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts).
# Make sure you have a recent version: the code points that Powerline
# uses changed in 2012, and older versions will display incorrectly,
# in confusing ways.
#
# [Nerd fonts] (https://github.com/ryanoasis/nerd-fonts)
#

CURRENT_BG='NONE'

# Special Powerline characters

() {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  # NOTE: This segment separator character is correct.  In 2012, Powerline changed
  # the code points they use for their special characters. This is the new code point.
  # If this is not working for you, you probably have an old version of the
  # Powerline-patched fonts installed. Download and install the new version.
  # Do not submit PRs to change this unless you have reviewed the Powerline code point
  # history and have new information.
  # This is defined using a Unicode escape sequence so it is unambiguously readable, regardless of
  # what font the user is viewing this source code in. Do not replace the
  # escape sequence with a single literal character.
  # SEGMENT_SEPARATOR=$'\ue0b0' # 
  SEGMENT_SEPARATOR=$'\ue0c0' # 
  # SEGMENT_SEPARATOR=$'\ue0d1' # 
  # SEGMENT_SEPARATOR=$'\ue0c6' # 
  # SEGMENT_SEPARATOR=$'\ue0c8' # 
  # SEGMENT_SEPARATOR=$'\ue0ce' # 
  # SEGMENT_SEPARATOR=$'\ue0c4' # 
  # SEGMENT_SEPARATOR=$'\ue0c4' # 

  HOME_ICON=$'\uf015'
  PROMPT_ERROR_ICON=$'\uf165'
  BG_JOB_ICON=$'\uf085'

  CALENDAR_ICON=$'\uf073'
  HOUR_ICON=$'\uf017'
  # PROMPT_ICON=$'\uf1b0' # paw
  PROMPT_ICON=$'\ue7a1' # owl

  CONNECTED_ICON=$'\uf1e6'
  BATTERY_00_ICON=$'\uf244'
  BATTERY_25_ICON=$'\uf243'
  BATTERY_50_ICON=$'\uf242'
  BATTERY_75_ICON=$'\uf241'
  BATTERY_100_ICON=$'\uf240'

  GIT_REPO_ICON=$'\uf113' #ocotocat head
  GIT_CLEAN_ICON=' \uf00c' #visto
  GIT_UNTRACKED_ICON='\uf041' #ping
  GIT_MODIFIED_ICON='\uf0e7' #rayo
  GIT_ADDED_ICON='\uf0fe' #'✚'
  GIT_DELETED_ICON='\uf00d' #x
  GIT_STASH_ICON='\uf16b' # dropbox  #'\uf013' #cog
  GIT_NOT_COMMIT_ICON='\uf024' #bandera
  GIT_COMMITS_AHEAD_ICON='\uf062' #↑
  GIT_COMMITS_BEHIND_ICON='↓' #↓
  GIT_CHANGE_ADDED_ICON='\uf067' #+

  BG_JOB_COLOR=green
  PROMPT_ERROR_COLOR=red

  USER_BG_COLOR=magenta
  USER_ICON_COLOR=black
  USER_NAME_COLOR=black

  BATTERY_00_BG_COLOR=red
  BATTERY_25_BG_COLOR=red
  BATTERY_50_BG_COLOR=yellow
  BATTERY_75_BG_COLOR=yellow
  BATTERY_100_BG_COLOR=green
  BATTERY_COLOR=black

  DATE_BG_COLOR=blue
  DATE_ICONS_COLOR=white
  DATE_COLOR=white

  DIR_BG_COLOR=yellow
  DIR_COLOR=blue

  GIT_ICON_COLOR=black
  GIT_CLEAN_BG_COLOR=white
  GIT_CLEAN_COLOR=green
  GIT_DIRTY_BG_COLOR=white
  GIT_DIRTY_COLOR=red
  GIT_ADDED_COLOR=green
  GIT_UNTRACKED_COLOR=blue
  GIT_MODIFIED_COLOR=cyan
  GIT_DELETED_COLOR=red
  GIT_STASH_COLOR=blue
  GIT_NOT_COMMIT_COLOR=red
  GIT_COMMITS_AHEAD_COLOR=magenta
  GIT_COMMITS_BEHIND_COLOR=magenta
}

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}


# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Status:
# - was there an error
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{$PROMPT_ERROR_COLOR}%}$PROMPT_ERROR_ICON"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{$BG_JOB_COLOR}%}$BG_JOB_ICON"
  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ -n "$SSH_CLIENT" ]]; then
    prompt_segment magenta white "$fg_bold[white]%(!.%{%F{white}%}.)$USER@%m$fg_no_bold[white]"
  else
    prompt_segment $USER_BG_COLOR white "$fg[$USER_ICON_COLOR]$HOME_ICON$fg[$USER_NAME_COLOR] $USER"
  fi
}

# Battery Level
prompt_battery() {
  HEART='♥ '

  if [[ $(uname) == "Linux"  ]] ; then

    function battery_is_charging() {
      ! [[ $(acpi 2&>/dev/null | grep -c '^Battery.*Discharging') -gt 0 ]]
    }

    function battery_pct() {
      if (( $+commands[acpi] )) ; then
        echo "$(acpi | cut -f2 -d ',' | tr -cd '[:digit:]')"
      fi
    }

    function battery_pct_remaining() {
      if [ ! $(battery_is_charging) ] ; then
        battery_pct
      else
        echo "External Power"
      fi
    }

    function battery_time_remaining() {
      if [[ $(acpi 2&>/dev/null | grep -c '^Battery.*Discharging') -gt 0 ]] ; then
        echo $(acpi | cut -f3 -d ',')
      fi
    }

    b=$(battery_pct_remaining)
    if [[ $(acpi 2&>/dev/null | grep -c '^Battery.*Discharging') -gt 0 ]] ; then
      if [ $b -gt 40 ] ; then
        prompt_segment green white
      elif [ $b -gt 20 ] ; then
        prompt_segment yellow white
      else
        prompt_segment red white
      fi
      echo -n "$fg_bold[white]$HEART$(battery_pct_remaining)%%$fg_no_bold[white]"
    fi
  else
    # for MacOs
    function battery_remaining {
      max_capacity=$(/usr/sbin/ioreg -r -c 'AppleSmartBattery' | grep -w 'MaxCapacity' | awk '{print $3}')
      current_capacity=$(/usr/sbin/ioreg -r -c 'AppleSmartBattery' | grep -w 'CurrentCapacity' | awk '{print $3}')
        # echo "scale=2;$current_capacity*100/$max_capacity" | bc -l
      echo "$current_capacity*100/$max_capacity" | bc
    }
    function battery_show {
      max_capacity=$(/usr/sbin/ioreg -r -c 'AppleSmartBattery' | grep -w 'MaxCapacity' | awk '{print $3}')
      current_capacity=$(/usr/sbin/ioreg -r -c 'AppleSmartBattery' | grep -w 'CurrentCapacity' | awk '{print $3}')
      echo "scale=2;$current_capacity*100/$max_capacity" | bc -l
    }
    function battery_connected {
      ioreg -n AppleSmartBattery -r | awk '$1~/ExternalConnected/{gsub("Yes", "+");gsub("No", "%"); print substr($0, length, 1)}'
    }

    charging_i=''
    charging=$(/usr/sbin/ioreg -r -c 'AppleSmartBattery' | /usr/bin/grep -w 'ExternalConnected' | /usr/bin/awk '{print $3}')
    if [ "$charging" = "Yes" ] ; then
      charging_i=$CONNECTED_ICON
    fi

    if [ $(battery_remaining) -lt 25 ] ; then
      battery_icon=$BATTERY_00_ICON
      battery_color=$BATTERY_00_BG_COLOR
    elif [ $(battery_remaining) -lt 50  ]; then
      battery_icon=$BATTERY_25_ICON
      battery_color=$BATTERY_25_BG_COLOR
    elif [ $(battery_remaining) -lt 75  ]; then
      battery_icon=$BATTERY_50_ICON
      battery_color=$BATTERY_50_BG_COLOR
    elif [ $(battery_remaining) -lt 90  ]; then
      battery_icon=$BATTERY_75_ICON
      battery_color=$BATTERY_75_BG_COLOR
    else
      battery_icon=$BATTERY_100_ICON
      battery_color=$BATTERY_100_BG_COLOR
    fi
    prompt_segment $battery_color $BATTERY_COLOR "$battery_icon  $(battery_show)%% $charging_i"
  fi
}

# Date and time
prompt_time() {
  prompt_segment $DATE_BG_COLOR white "$fg[$DATE_ICONS_COLOR]$CALENDAR_ICON $fg[$DATE_COLOR] %D{%a %d-%m-%G} $fg[$DATE_ICONS_COLOR]$HOUR_ICON$fg[$DATE_COLOR] %T"
}

# Dir: current working directory
prompt_dir() {
  prompt_segment $DIR_BG_COLOR $DIR_COLOR "%~"
}


# Git: branch/detached head, dirty status
prompt_git() {
  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR="$fg[$GIT_ICON_COLOR]$GIT_REPO_ICON"
  }
  local ref dirty mode repo_path clean has_upstream
  local modified untracked added deleted tagged stashed
  local ready_commit git_status bgclr fgclr
  local commits_diff commits_ahead commits_behind has_diverged to_push to_pull

  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    git_status=$(git status --porcelain 2> /dev/null)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    if [[ -n $dirty ]]; then
      clean=''
      bgclr=$GIT_DIRTY_BG_COLOR
      fgclr=$GIT_DIRTY_COLOR
      git_color=$GIT_DIRTY_COLOR
    else
      clean="$fg[$GIT_CLEAN_COLOR]$GIT_CLEAN_ICON"
      bgclr=$GIT_CLEAN_BG_COLOR
      fgclr=$GIT_CLEAN_COLOR
      git_color=$GIT_CLEAN_COLOR
    fi

    local upstream=$(git rev-parse --symbolic-full-name --abbrev-ref @{upstream} 2> /dev/null)
    if [[ -n "${upstream}" && "${upstream}" != "@{upstream}" ]]; then has_upstream=true; fi

    local current_commit_hash=$(git rev-parse HEAD 2> /dev/null)

    local number_of_untracked_files=$(\grep -c "^??" <<< "${git_status}")
    # if [[ $number_of_untracked_files -gt 0 ]]; then untracked=" $number_of_untracked_files◆"; fi
    if [[ $number_of_untracked_files -gt 0 ]]; then untracked=" $fg[$GIT_UNTRACKED_COLOR][$number_of_untracked_files$GIT_UNTRACKED_ICON]"; fi

    local number_added=$(\grep -c "^A" <<< "${git_status}")
    if [[ $number_added -gt 0 ]]; then added=" $fg[$GIT_ADDED_COLOR][$number_added$GIT_ADDED_ICON]"; fi

    local number_modified=$(\grep -c "^.M" <<< "${git_status}")
    if [[ $number_modified -gt 0 ]]; then
      modified=" $fg[$GIT_MODIFIED_COLOR][$number_modified$GIT_MODIFIED_ICON]"
    fi

    local number_added_modified=$(\grep -c "^M" <<< "${git_status}")
    local number_added_renamed=$(\grep -c "^R" <<< "${git_status}")
    if [[ $number_modified -gt 0 && $number_added_modified -gt 0 ]]; then
      modified="$fg[$GIT_MODIFIED_COLOR]$modified$((number_added_modified+number_added_renamed))$GIT_CHANGE_ADDED_ICON"
    elif [[ $number_added_modified -gt 0 ]]; then
      modified=" $fg[$GIT_MODIFIED_COLOR][$GIT_MODIFIED_ICON$((number_added_modified+number_added_renamed))$GIT_CHANGE_ADDED_ICON]"
    fi

    local number_deleted=$(\grep -c "^.D" <<< "${git_status}")
    if [[ $number_deleted -gt 0 ]]; then
      deleted=" $fg[$GIT_DELETED_COLOR]$number_deleted$GIT_DELETED_ICON"
      # bgclr='red'
      # fgclr='white'
    fi

    local number_added_deleted=$(\grep -c "^D" <<< "${git_status}")
    if [[ $number_deleted -gt 0 && $number_added_deleted -gt 0 ]]; then
      deleted="$deleted$number_added_deleted(3)±"
    elif [[ $number_added_deleted -gt 0 ]]; then
      deleted=" ‒$number_added_deleted(4)±"
    fi

    local tag_at_current_commit=$(git describe --exact-match --tags $current_commit_hash 2> /dev/null)
    if [[ -n $tag_at_current_commit ]]; then tagged=" ☗$tag_at_current_commit "; fi

    local number_of_stashes="$(git stash list 2> /dev/null | wc -l)"
    if [[ $number_of_stashes -gt 0 ]]; then
      stashed=" $fg[$GIT_STASH_COLOR]$number_of_stashes$GIT_STASH_ICON"
      # bgclr='magenta'
      # fgclr='white'
    fi

    if [[ $number_added -gt 0 || $number_added_modified -gt 0 || $number_added_deleted -gt 0 ]]; then
      ready_commit=" $fg[$GIT_NOT_COMMIT_COLOR]$GIT_NOT_COMMIT_ICON"
    fi

    local upstream_prompt=''
    if [[ $has_upstream == true ]]; then
      commits_diff="$(git log --pretty=oneline --topo-order --left-right ${current_commit_hash}...${upstream} 2> /dev/null)"
      commits_ahead=$(\grep -c "^<" <<< "$commits_diff")
      commits_behind=$(\grep -c "^>" <<< "$commits_diff")
      upstream_prompt="$(git rev-parse --symbolic-full-name --abbrev-ref @{upstream} 2> /dev/null)"
      upstream_prompt=$(sed -e 's/\/.*$/ ☊ /g' <<< "$upstream_prompt")
    fi

    has_diverged=false
    if [[ $commits_ahead -gt 0 && $commits_behind -gt 0 ]]; then has_diverged=true; fi
    if [[ $has_diverged == false && $commits_ahead -gt 0 ]]; then
      to_push=" $fg[$GIT_COMMITS_AHEAD_COLOR]$GIT_COMMITS_AHEAD_ICON $commits_ahead"
    fi
    if [[ $has_diverged == false && $commits_behind -gt 0 ]]; then to_pull=" $fg[$GIT_COMMITS_BEHIND_COLOR_]$GIT_COMMITS_BEHIND_ICON$commits_behind"; fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    prompt_segment $bgclr $fgclr

    echo -n "$fg[$fgclr]${ref/refs\/heads\//$PL_BRANCH_CHAR $fg[$git_color]$upstream_prompt}${mode}$to_push$to_pull$clean$tagged$stashed$untracked$modified$deleted$added$ready_commit"
  fi
}

## Main prompt
build_prompt() {
  RETVAL=$?
  # echo -n "\n"
  prompt_status
  prompt_context
  prompt_battery
  prompt_time
  # prompt_virtualenv
  prompt_dir
  prompt_git
  # prompt_hg
  prompt_end
  CURRENT_BG='NONE'
  echo -n "\n"
  echo $PROMPT_ICON
}

PROMPT='%{%f%b%k%}$(build_prompt) '
