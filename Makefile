STOW_PACKAGES = zsh git nvim tmux karabiner ghostty claude lazygit

install:
	brew install stow
	stow -t ~ $(STOW_PACKAGES)

uninstall:
	stow -t ~ -D $(STOW_PACKAGES)

restow:
	stow -t ~ -R $(STOW_PACKAGES)
