STOW_PACKAGES = zsh git nvim tmux karabiner ghostty claude lazygit codex aerospace

install:
	brew install stow
	stow -t ~ $(STOW_PACKAGES)
	./rectangle/install.sh

uninstall:
	stow -t ~ -D $(STOW_PACKAGES)

restow:
	stow -t ~ -R $(STOW_PACKAGES)

rectangle-export:
	./rectangle/install.sh export
