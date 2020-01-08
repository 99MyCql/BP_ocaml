SRC_DIR = ./src
BIN_DIR = ./bin
OBJ_DIR = ./bin/obj
TEST_DIR = ./test

CC = ocamlc

main: obj
	$(CC) -o $(BIN_DIR)/main graphics.cma $(OBJ_DIR)/util.cmo $(OBJ_DIR)/BP.cmo $(OBJ_DIR)/main.cmo

obj: $(SRC_DIR)/util.ml $(SRC_DIR)/BP.ml $(SRC_DIR)/main.ml
	$(CC) -c $(SRC_DIR)/util.mli -I $(OBJ_DIR) -o $(OBJ_DIR)/util.cmi
	$(CC) -c $(SRC_DIR)/util.ml -I $(OBJ_DIR) -o $(OBJ_DIR)/util.cmo
	$(CC) -c $(SRC_DIR)/BP.mli -I $(OBJ_DIR) -o $(OBJ_DIR)/BP.cmi
	$(CC) -c $(SRC_DIR)/BP.ml -I $(OBJ_DIR) -o $(OBJ_DIR)/BP.cmo
	$(CC) -c $(SRC_DIR)/main.ml -I $(OBJ_DIR) -o $(OBJ_DIR)/main.cmo

run: ./$(BIN_DIR)/main
	./$(BIN_DIR)/main

clean:
	-rm $(OBJ_DIR)/*.cmo
	-rm $(OBJ_DIR)/*.cmi
	-rm $(BIN_DIR)/main