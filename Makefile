CA65 := ca65
LD65 := ld65

SRC_DIR  := src
OBJ_DIR  := obj
DIST_DIR := dist

GAME_TITLE := game-of-life

SRC_FILES := $(wildcard $(SRC_DIR)/*.asm)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.asm,$(OBJ_DIR)/%.o,$(SRC_FILES))

.PHONY: all clean

all: clean $(DIST_DIR)/$(GAME_TITLE).nes

$(DIST_DIR)/$(GAME_TITLE).nes: $(OBJ_FILES)
	$(LD65) -o $@ -C nes.cfg $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm
	$(CA65) -o $@ $<

clean:
	rm -fr obj/** dist/**
