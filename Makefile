CUR_PLATFORM	:= $(shell uname)
LINUX_PLATFORM	:= Linux

all: sync install

sync: 
	stow */
ifeq ($(CUR_PLATFORM), $(LINUX_PLATFORM))
	sudo stow root -t /
endif

install: 
	./install

.PHONY: all sync install
