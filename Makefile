CUR_PLATFORM	:= $(shell uname)
LINUX_PLATFORM	:= Linux
MAC_PLATFORM	:= Darwin

all: sync apps emacs

dirs:
ifeq ($(CUR_PLATFORM), $(MAC_PLATFORM))
	[ -d ~/.config/polybar ] || mkdir -p ~/.config/polybar
else
endif
	[ -d ~/.config/alacritty ] || mkdir -p ~/.config/alacritty
	[ -d ~/.config/i3 ] || mkdir -p ~/.config/i3
	[ -d ~/org ] || mkdir -p ~/org

sync: dirs
ifeq ($(CUR_PLATFORM), $(MAC_PLATFORM))
	[ -f ~/.skhdrc ] || ln -s $(PWD)/yabai/skhdrc ~/.skhdrc
	[ -f ~/.yabairc ] || ln -s $(PWD)/yabai/yabairc ~/.yabairc
	[ -f ~/.config/polybar/config ] || ln -s $(PWD)/polybar/config ~/.config/polybar/config
	[ -f ~/.config/polybar/launch.sh ] || ln -s $(PWD)/polybar/launch.sh ~/.config/polybar/launch.sh
	[ -f ~/.bashrc ] || ln -s $(PWD)/bashrc ~/.bashrc
	@touch ~/.hushlogin
else
endif
ifeq ($(CUR_PLATFORM), $(LINUX_PLATFORM))
	[ -f ~/.Xmodmap ] || ln -s $(PWD)/Xmodmap ~/.Xmodmap
	[ -f ~/.Xresources ] || ln -s $(PWD)/Xresources ~/.Xresources
	[ -f ~/.config/i3/workspace1.json ] || ln -s $(PWD)/i3/workspace1.json ~/.config/i3/workspace1.json
	[ -f ~/.config/i3/workspace2.json ] || ln -s $(PWD)/i3/workspace2.json ~/.config/i3/workspace2.json
	[ -f ~/.config/i3/workspace3.json ] || ln -s $(PWD)/i3/workspace3.json ~/.config/i3/workspace3.json
	[ -f ~/.bashrc ] || ln -s $(PWD)/bashrc ~/.bashrc
	[ -f /usr/local/bin/zsh ] || sudo ln -s /usr/bin/zsh /usr/local/bin/zsh
	[ -f /usr/local/bin/tmux ] || sudo ln -s /usr/bin/zsh /usr/local/bin/tmux
	[ -s ~/.config/awesome ] || ln -s $(PWD)/awesome ~/.config
	[ -d ~/.config/awesome/awesome-wm-widgets ] || git clone https://github.com/streetturtle/awesome-wm-widgets ~/.config/awesome/awesome-wm-widgets
	[ -f ~/.config/awesome/json.lua ] || wget -P ~/.config/awesome/ https://raw.githubusercontent.com/rxi/json.lua/master/json.lua
	[ -f ~/.config/staship.toml ] || ln -s $(PWD)/starship.toml ~/.config/starship.toml
else
endif
	[ -f ~/.agignore ] || ln -s $(PWD)/agignore ~/.agignore
	[ -f ~/.config/alacritty/alacritty.yml ] || ln -s $(PWD)/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
	[ -f ~/.config/alacritty/color.yml ] || ln -s $(PWD)/alacritty/color.yml ~/.config/alacritty/color.yml
	[ -d ~/.doom.d ] || ln -s $(PWD)/doom.d ~/.doom.d
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux.conf ~/.tmux.conf
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc

apps:
ifeq ($(CUR_PLATFORM), $(MAC_PLATFORM))
	@./install_mac
else
	@./install_linux
endif

go:
	GO111MODULE=on go install github.com/cweill/gotests/...@latest
	GO111MODULE=on go install github.com/fatih/gomodifytags@latest
	GO111MODULE=on go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	GO111MODULE=on go install github.com/x-motemen/gore/cmd/gore@latest
	GO111MODULE=on go install github.com/rogpeppe/godef@latest
	GO111MODULE=on go install github.com/stamblerre/gocode@latest
	GO111MODULE=on go install golang.org/x/tools/cmd/godoc@latest
	GO111MODULE=on go install golang.org/x/tools/cmd/goimports@latest
	GO111MODULE=on go install golang.org/x/tools/cmd/gorename@latest
	GO111MODULE=on go install golang.org/x/tools/cmd/guru@latest
	GO111MODULE=on go install golang.org/x/tools/gopls@latest

node:
	npm install --global \
		bash-language-server \
		typescript-language-server \
		prettier \
		pyright \
		stylelint \
		js-beautify

ruby:
	bundle install

emacs: go
	[ -d ~/.emacs.d ] || git clone https://github.com/hlissner/doom-emacs ~/.emacs.d

clean:
	rm -f ~/.vimrc
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.config/alacritty/alacritty.yml
	rm -f ~/.bashrc
	rm -f ~/.zshrc
	rm -f ~/.tmux.conf
	rm -f ~/.agignore
	rm -f ~/.Xmodmap
	rm -f ~/.Xresources
	rm -rf ~/.doom.d
ifeq ($(CUR_PLATFORM), $(MAC_PLATFORM))
	brew cleanup
endif

.PHONY: all clean sync build go emacs dirs ruby
