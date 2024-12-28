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

