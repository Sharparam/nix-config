#!/usr/bin/env bash

flavor=${CATPPUCCIN_THEME:-frappe}

# shellcheck source=catppuccin_frappe.sh
source "$CONFIG_DIR/colors/catppuccin_$flavor.sh"

export RANDOM_CAT_COLOR=("$BLUE" "$LAVENDER" "$SAPPHIRE" "$SKY" "$TEAL" "$GREEN" "$YELLOW" "$PEACH" "$MAROON" "$RED" "$MAUVE" "$PINK" "$FLAMINGO" "$ROSEWATER")

function getRandomCatColor() {
  echo "${RANDOM_CAT_COLOR[$RANDOM % ${#RANDOM_CAT_COLOR[@]}]}"
}

export BAR_COLOR=$BASE
export BAR_BORDER_COLOR=$SURFACE1
export ICON_COLOR=$TEXT
export LABEL_COLOR=$TEXT
export SHADOW_COLOR=$CRUST
