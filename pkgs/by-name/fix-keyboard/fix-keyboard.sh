#!/usr/bin/env bash

set -euo pipefail

config='{
  "UserKeyMapping": [
    {
      "HIDKeyboardModifierMappingSrc": 0x700000064,
      "HIDKeyboardModifierMappingDst": 0x700000035
    },
    {
      "HIDKeyboardModifierMappingSrc": 0x700000035,
      "HIDKeyboardModifierMappingDst": 0x700000064 
    },
    {
      "HIDKeyboardModifierMappingDst": 30064771113,
      "HIDKeyboardModifierMappingSrc": 30064771129
    }
  ]
}
'

# orig_config='{
#   "UserKeyMapping": [
#     {
#       "HIDKeyboardModifierMappingSrc": 0x700000035,
#       "HIDKeyboardModifierMappingDst": 0x700000064
#     },
#     {
#       "HIDKeyboardModifierMappingSrc": 0x700000064,
#       "HIDKeyboardModifierMappingDst": 0x700000035
#     }
#   ]
# }
# '

orig_config='{
  "UserKeyMapping": [
    {
      "HIDKeyboardModifierMappingDst": 30064771113,
      "HIDKeyboardModifierMappingSrc": 30064771129
    }
  ]
}
'

# remaps the paragraph/plus-minus key (left of the 1 key) to tilde/backtick like it should be
# and vice versa
function fix() {
  echo "Fixing..."
  hidutil property --set "$config"
}

function restore() {
  echo "Restoring..."
  hidutil property --set "$orig_config"
}

action='fix'

while [[ $# -gt 0 ]]; do
  case $1 in
  r | restore | -r)
    action='restore'
    shift
    ;;
  *)
    shift
    ;;
  esac
done

if [[ "$action" = "restore" ]]; then
  restore
else
  fix
fi
