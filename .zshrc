# turn colored output on
export CLICOLOR=1






# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
# zstyle ':vcs_info:git:*' formats '(on branch %b) '
 
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST


NEWLINE=$'\n'


PROMPT='%B%F{85}%n%f%b at %B%F{172}%m%f%b in %B%F{33}%~%f%b %B%F{215}${vcs_info_msg_0_}%f%b${NEWLINE}> '

RPROMPT="%B%F{230}(%?)%f%b"
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/aarsh/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/aarsh/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/aarsh/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/aarsh/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

