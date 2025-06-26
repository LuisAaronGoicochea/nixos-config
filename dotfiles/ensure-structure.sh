#!/usr/bin/env bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to ensure correct structure for a config
ensure_structure() {
    local dir="$1"
    local config_dir=".config"
    
    # Skip if not a directory or if it's a special directory
    if [[ ! -d "$dir" ]] || [[ "$dir" == "." ]] || [[ "$dir" == ".." ]] || [[ "$dir" == "$config_dir" ]]; then
        return
    fi
    
    echo -e "${BLUE}Checking structure for $dir...${NC}"
    
    # Handle special cases
    case "$dir" in
        "nvim"|"tmux"|"zsh"|"starship"|"nushell"|"zellij")
            if [[ ! -d "$dir/$config_dir/$dir" ]]; then
                echo -e "${BLUE}Restructuring $dir...${NC}"
                mkdir -p "$dir/$config_dir/$dir"
                for file in "$dir"/*; do
                    if [[ -f "$file" ]] && [[ "$(basename "$file")" != "README.md" ]]; then
                        mv "$file" "$dir/$config_dir/$dir/"
                    fi
                done
            fi
            ;;
        *)
            echo -e "${BLUE}Skipping $dir (no special handling needed)${NC}"
            ;;
    esac
}

# Process all directories
for dir in "$SCRIPT_DIR"/*; do
    if [[ -d "$dir" ]]; then
        ensure_structure "$(basename "$dir")"
    fi
done

echo -e "${GREEN}Structure check complete${NC}"
