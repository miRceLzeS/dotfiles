DOTCONFIG:
	stow -v -t ~/.config/ .config/

clean:
	stow -v -D -t ~/.config/ .config/
	echo "remove ~/.config"
	rm -rf ~/.config
	mkdir ~/.config

local: clean DOTCONFIG

.PHONY: DOTCONFIG local clean
