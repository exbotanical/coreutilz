CC ?= gcc
AR ?= ar
LINTER ?= clang-format

PROG := coreutilz

SRCDIR := src
TESTDIR := t
BINDIR := bin

SRC := $(wildcard $(SRCDIR)/*.c)

CFLAGS :=-Wall -Wextra -pedantic
LIBS :=

$(BINDIR):
	mkdir -p $(BINDIR)

# Generate the list of compiled programs
COMPILED_PROGS := $(foreach prog,$(notdir $(basename $(SRC))),$(BINDIR)/$(prog))

%: src/%.c bin
	$(CC) $(CFLAGS) $(LIBS) -o $(BINDIR)/$(basename $@) $<

bin/%: src/%.c bin
	$(CC) $(CFLAGS) $(LIBS) -o $(basename $@) $<

test: $(COMPILED_PROGS)
	./$(TESTDIR)/utils/run.bash
	$(MAKE) clean

clean:
	rm -f ./$(BINDIR)/*

lint:
	$(LINTER) -i $(SRC) $(wildcard $(TESTDIR)/*/*.c)

.PHONY: test clean lint
