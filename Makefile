all: sync install

sync: 
	stow */

install: 
	./install

.PHONY: all sync install
