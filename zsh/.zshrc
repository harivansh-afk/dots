# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(git)

ZSH_DISABLE_COMPFIX=true

source $ZSH/oh-my-zsh.sh
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"

export OPENAI_API_KEY="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"
export GREPTILE_API_KEY="O2S8ucOfjNUFniRpm57U74eZBR2KAKliFLUmB6+tE4MojKtu"

export PATH="/Users/rathi/.local/bin:$PATH"

export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# opencode
export PATH=/Users/rathi/.opencode/bin:$PATH

# Aliases
alias cc='claude --dangerously-skip-permissions'
alias ca='cursor-agent'
alias nim='nvim .' 
alias cl='clear'

# Git aliases
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gd='git diff'
unalias ga 2>/dev/null
ga() {
  if [[ $# -eq 0 ]]; then
    git add .
  else
    git add "$@"
  fi
}
alias gk='git checkout'
alias gpo='git pull origin'
alias lg='lazygit'
alias ld='lumen diff'
alias sshnet='ssh -i ~/.ssh/atlas-ssh.txt rathiharivansh@152.53.195.59'

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

alias ch='claude-handoff'

# Initialize zoxide
eval "$(zoxide init zsh)"

# Editor preferences
export EDITOR=nvim
export VISUAL=nvim

# Vi mode
bindkey -v

# bun completions
[ -s "/Users/rathi/.bun/_bun" ] && source "/Users/rathi/.bun/_bun"

# Added by Antigravity
export PATH="/Users/rathi/.antigravity/antigravity/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/rathi/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Amp CLI
export PATH="/Users/rathi/.amp/bin:$PATH"

# critic git wrapper
git() {
    command git "$@"
    local exit_code=$?

    # Trigger critic on staging operations
    case "$1" in
        add|stage|reset|checkout)
            # Run async, don't block
            if command -v critic &> /dev/null; then
                ( critic review 2>/dev/null & )
            fi
            ;;
    esac

    return $exit_code
}

# Build, install, launch iOS app and stream logs
iosrun() {
    local project=$(find . -maxdepth 1 -name "*.xcodeproj" | head -1)
    local scheme=$(basename "$project" .xcodeproj)
    local derived=".derived-data"
    local sim_name="${1:-iPhone 16e}"

    if [[ -z "$project" ]]; then
        echo "No .xcodeproj found in current directory"
        return 1
    fi

    # Build first (like Xcode does)
    echo "Building $scheme..."
    if ! xcodebuild -project "$project" -scheme "$scheme" \
        -destination "platform=iOS Simulator,name=$sim_name" \
        -derivedDataPath "$derived" build -quiet; then
        echo "Build failed"
        return 1
    fi

    echo "Build succeeded. Launching simulator..."

    # Boot simulator and open Simulator.app after successful build
    xcrun simctl boot "$sim_name" 2>/dev/null
    open -a Simulator

    # Install and launch with retry until app opens
    local app_path="$derived/Build/Products/Debug-iphonesimulator/$scheme.app"
    local bundle_id=$(/usr/libexec/PlistBuddy -c "Print :CFBundleIdentifier" "$app_path/Info.plist")

    echo "Installing $scheme..."
    while ! xcrun simctl install "$sim_name" "$app_path" 2>/dev/null; do
        sleep 0.5
    done

    echo "Launching $bundle_id..."
    while ! xcrun simctl launch "$sim_name" "$bundle_id" 2>&1 | grep -q "$bundle_id"; do
        sleep 0.5
    done

    echo "Launched $bundle_id - streaming logs (Ctrl+C to stop)"
    echo "----------------------------------------"

    # Stream logs filtered to app (excluding Apple framework noise)
    xcrun simctl spawn "$sim_name" log stream \
        --predicate "(subsystem CONTAINS '$bundle_id' OR process == '$scheme') AND NOT subsystem BEGINSWITH 'com.apple'" \
        --style compact \
        --color always 2>/dev/null | while read -r line; do
        # Strip timestamp prefix for cleaner output, highlight errors
        if [[ "$line" == *"error"* ]] || [[ "$line" == *"Error"* ]]; then
            echo "\033[31m$line\033[0m"
        elif [[ "$line" == *"warning"* ]] || [[ "$line" == *"Warning"* ]]; then
            echo "\033[33m$line\033[0m"
        else
            echo "$line"
        fi
    done
}

# Preview markdown files in browser (live reload)
mdview() {
    markserv "$1"
}

. <(fzf --zsh)

fzf-config-widget() {
    file="$(FZF_CTRL_T_COMMAND="fd --type file --hidden . ~/.config | sed 's|$HOME|~|g'" __fzf_select | cut -c2-)"
    LBUFFER+="$file"
    zle reset-prompt
}

zle -N fzf-config-widget

bindkey '^E' fzf-config-widget
export PATH="$HOME/.local/bin:$PATH"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# zsh plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^k' forward-car
bindkey '^j' backward-car
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
