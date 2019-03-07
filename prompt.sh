# Default prompt theme
export PROMPT_THEME="twoline"

# Path of base directory (used in theme scripts to find bin folder)
export PROMPT_BASE_DIR="$HOME/bin/bash_prompt"

# How many directories to display before truncating
PROMPT_DIRTRIM=8

prompt_command ()
{
    PS1=$("$PROMPT_BASE_DIR"/themes/"$PROMPT_THEME" "$?")
}

PROMPT_COMMAND=prompt_command