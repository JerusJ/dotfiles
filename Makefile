CUR_PLATFORM	:= $(shell uname)
LINUX_PLATFORM	:= Linux
MAC_PLATFORM	:= Darwin

NODE_DIR := ~/.npm_global

all: sync apps emacs

sync: 
	[ -d ~/fzf-zsh-plugin ] || git clone https://github.com/unixorn/fzf-zsh-plugin.git ~/fzf-zsh-plugin
	[ -d ~/powerlevel10k ] || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
	[ -d ~/.tmux/plugins/tpm ] || mkdir -p ~/.tmux/plugins && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true
	stow */

apps:
ifeq ($(CUR_PLATFORM), $(MAC_PLATFORM))
	@./install_mac
endif

programming_packages: go node

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
	npm config set prefix '${NODE_DIR}'
	npm install --global \
		bash-language-server \
		typescript-language-server \
		prettier \
		pyright \
		stylelint \
		js-beautify

ruby:
	bundle install

emacs:
	[ -d ~/.emacs.d ] || git clone https://github.com/hlissner/doom-emacs ~/.emacs.d

clean:
	rm -f ~/.vimrc
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.config/ritty/alacritty.yml
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

.PHONY: all clean sync build go node ruby emacs dirs
