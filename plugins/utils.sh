# This file contains useful functions that you might want to include in all
# different profiles

# Function to list available themes
lpt ()
{
	ls "$PTHEME_THEMES_DIR"
}

# Helper function to check if a theme exists
_check_theme_exists()
{
	if [ -f "$PTHEME_THEMES_DIR/$1" ]; then
		return 0
	else
		return 1
	fi
}

# Helper function for switching themes
# Changes the variable for the theme to be ran, and sources some .inputrc files
#	Your default one with main readline configuration,
#		(read by default for all other programs that use readline)
#	default settings for this set of prompts,
#		(main settings that apply only to your prompt)
#		(for ex. your default readline turns on show-mode-in-prompt, but most
#		prompts aren't set up to support it. instead of adding inputrc's for
#		all of them to turn off settings you don't want from your main readline
#		config, make those changes in .inputrc in the theme directory.)
#	and one for just the theme
#		(good for visual settings specific to the current theme)
_switch_theme()
{
	PTHEME_THEME="$1"
	[ -f "$HOME/.inputrc" ] &&
		bind -f "$HOME/.inputrc"
	[ -f "$PTHEME_THEMES_DIR/.inputrc" ] &&
		bind -f "$PTHEME_THEMES_DIR/.inputrc"
	[ -f "$PTHEME_THEMES_DIR/.$PTHEME_THEME.inputrc" ] &&
		bind -f "$PTHEME_THEMES_DIR/.$PTHEME_THEME.inputrc"
	return 0
}

# Function to quickly switch themes
# No args: display current theme
# One arg: check if theme exists, switch to it if so, print error if no
#			also refresh the inputrc files
# Multiple args: ignored. you must use "" if you want a space in the name
pt ()
{
	if [ -z "$1" ]; then
		echo "$PTHEME_THEME"
	else
		if _check_theme_exists "$1"; then
			_switch_theme "$1"
		else
			echo "Theme \"$1\" not in $PTHEME_THEMES_DIR"
			return 1
		fi
	fi
}

# Function to open the current theme in your editor
# No args: edit current theme
# One arg: check if theme exists, edit if so, print error if no
# Multiple args: ignored. you must use "" if you want a space in the name
ept ()
{
	if [ -z "$1" ]; then
		theme="$PTHEME_THEME"
	else
		theme="$1"
	fi

	case "$EDITOR" in
		vim | nvim)
			"$EDITOR" "$PTHEME_THEMES_DIR/$theme" -c "ped $PTHEME_THEMES_DIR/.$theme.inputrc"
			;;
		**)
			"$EDITOR" "$PTHEME_THEMES_DIR/$theme"
			;;
	esac
}
