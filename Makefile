CUR_PLATFORM	:= $(shell uname)
LINUX_PLATFORM	:= Linux

all: update_submodules sync install

update_submodules:
	git submodule update --init --recursive

sync: update_submodules
	stow */ --adopt
ifeq ($(CUR_PLATFORM), $(LINUX_PLATFORM))
	sudo stow root -t /
endif

install: 
	./install

.PHONY: all update_submodules sync install
