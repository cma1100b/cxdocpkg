# SPDX-License-Identifier: MIT

TEX       = latexmk
TEXFLAGS  = -lualatex -quiet -interaction=nonstopmode -file-line-error

CFGD      = src
OBJD      = build
SRCD      = examples

export TEXINPUTS := $(CFGD)//:

STYF      =
CLSF      = $(CFGD)/cxdoc/cxdoc.cls

SRCS     := $(wildcard $(SRCD)/*.tex)
OBJS     := $(SRCS:$(SRCD)/%.tex=$(OBJD)/%.pdf)

.PHONY: all clean

all: $(OBJS)

$(OBJD)/%.pdf: $(SRCD)/%.tex $(CLSF) $(STYF)
	mkdir -p $(dir $@)
	$(TEX) $(TEXFLAGS) -output-directory=$(OBJD) $<

clean:
	$(TEX) -C $(SRCS)
	rm -rf $(OBJD)
