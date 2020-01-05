SRC_DIR = ./src
BIN_DIR = ./bin
OBJ_DIR = ./bin/obj
TEST_DIR = ./test

CC = ocamlc

main: BP.cmo main.cmo
	$(CC) -o $(BIN_DIR)/main $(OBJ_DIR)/BP.cmo $(OBJ_DIR)/main.cmo

BP.cmo: $(SRC_DIR)/BP.ml
	$(CC) -c $(SRC_DIR)/BP.ml -I $(OBJ_DIR) -o $(OBJ_DIR)/BP.cmo

main.cmo: $(SRC_DIR)/main.ml
	$(CC) -c $(SRC_DIR)/main.ml -I $(OBJ_DIR) -o $(OBJ_DIR)/main.cmo

run: $(BIN_DIR)/main
	./$(BIN_DIR)/main

clean:
	-rm $(OBJ_DIR)/*.cmo
	-rm $(OBJ_DIR)/*.cmi
	-rm $(BIN_DIR)/main