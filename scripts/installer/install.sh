#!/usr/bin/env bash

set -euo pipefail

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source "$BASE_DIR/scripts/installer/helper.sh"

trap 'trap_message' INT TERM

print_bold_blue "\nAnan Hyprland Laptop"
echo "----------------------"

init_runtime_context
check_os

run_script "prerequisites.sh" "Prerequisites"
run_script "hypr.sh" "Hyprland Core"
run_script "utilities.sh" "Utilities And UI Configs"
run_script "theming.sh" "Theming And Fonts"
run_script "extras.sh" "Optional Personal Extras"
run_script "final.sh" "Final Notes"

print_bold_blue "\nSetup complete."

