# Compiler
COBC = cobc

# Source and output directories
# TODO -> Add output directory
OUT_DIR =
SRC_DIR = src

# Name of Executable
# TODO -> Add name of executable
BIN_NAME =

# The entry point
MAIN = $(SRC_DIR)/main.cob

# All COBOL files except main.cob
SRC = $(filter-out $(MAIN), $(wildcard $(SRC_DIR)/*.cob))

# Copybooks
COPY = -I $(SRC_DIR)/ui -I $(SRC_DIR)/ui/error-scr -I $(SRC_DIR)/copy

# Warnings
WARNS = -Wall -Wadditional -Wextra -Wno-terminator

LISTING = -tlisting.lst -tlines=0 -Xref -d

all:
	$(COBC) -free \
	-x $(SRC_DIR)/main.cob $(SRC) \
	-o $(OUT_DIR)/$(BIN_NAME) $(COPY) \
	-w -q

lint:
	$(COBC) -free -fsyntax-only $(SRC) $(WARNS) $(COPY)

listing:
	$(COBC) -free -fsyntax-only $(SRC) $(LISTING)

debug:
	$(COBC) -free \
	-DDEBUG \
	-x $(SRC_DIR)/main.cob $(SRC) \
	-o $(OUT_DIR)/$(BIN_NAME)_DEBUG $(COPY) \
	-w -q -d

clean:
	del /Q /S *.exe *.dll *.o 2>nul
