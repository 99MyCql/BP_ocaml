(*---------------------------------------------------------------------------
  @name: mnist.ml
  @description: 解析mnist数据集模块
  @author: taymarine
-----------------------------------------------------------------------------*)

open Graphics
open Util
open Printf

(* 保存图片二进制前十六个字节 *)
type image_info = {
	mutable magic_num: int;
	mutable image_num: int;
	mutable rows: int;
	mutable cols: int;
};;

(* 保存标签二进制前八个字节 *)
type label_info = {
	mutable magic_num: int;
	mutable image_num: int;
};;


(* 实例化图片标记 *)
let image : image_info = {
	magic_num = 0;
	image_num = 0;
	rows = 0;
	cols = 0;
};;

(* 实例化标签标记 *)
let label : label_info = {
	magic_num = 0;
	image_num = 0;
};;


(* 保存一组28 * 28像素数据 *)
let pixel = Array.make_matrix 60000 784 0;;
let single = Array.make_matrix 28 28 0;;
let label_num = Array.make 60000 0;;

let train_image_file = "./data/train-images.idx3-ubyte";;
let train_labels_file = "./data/train-labels.idx1-ubyte";;
let test_image_file = "./data/t10k-images.idx3-ubyte";;
let test_labels_file = "./data/t10k-labels.idx1-ubyte";;

let getval value =
	match value with
	| 0 -> 0
	| _ -> value;;

(* 将每次读取的四字节数据分割为四个一字节数据 *)
let covert (data, row, col) =
	let first_half = data / 0x10000 in
	let second_half = data mod 0x10000 in
		let highest = first_half / 0x100 in
		let higher = first_half mod 0x100 in
		let lower = second_half / 0x100 in
		let lowest = second_half mod 0x100 in
			pixel.(row).(col) <- getval(highest);
            pixel.(row).(col+1) <- getval(higher);
            pixel.(row).(col+2) <- getval(lower);
            pixel.(row).(col+3) <- getval(lowest);;

(* 递归地读取像素点，每张图片的数据放在一个二维数组中 *)
let rec readdata (file, num, row, col) =
	if col < 784 then (
		let data = input_binary_int file in
			covert (data, row, col);
		readdata(file, num, row, col+4))
	else (
		if num <= 1	then ()
		else (
			readdata(file, num-1, row+1, 0))
		);;

(* 读取图片像素标记信息，调用读数据函数 *)
let readImage (filename, num) =
	let file = open_in_bin filename in
		let magic_num = input_binary_int file in
		let image_num = input_binary_int file in
		let rows = input_binary_int file in
		let cols = input_binary_int file in
			image.magic_num <- magic_num;
			image.image_num <- image_num;
			image.rows <- rows;
			image.cols <- cols;
			let () = readdata (file, num, 0, 0) in
 				printf "%i %i %i %i\n" magic_num image_num rows cols;
		close_in file;;

(* 读取标签中的数字，每次取四个字节 *)
let covertnum (data, ser_num) =
	let first_half = data / 0x10000 in
	let second_half = data mod 0x10000 in
		let highest = first_half / 0x100 in
		let higher = first_half mod 0x100 in
		let lower = second_half / 0x100 in
		let lowest = second_half mod 0x100 in
			label_num.(ser_num*4) <- highest;
			label_num.(ser_num*4+1) <- higher;
			label_num.(ser_num*4+2) <- lower;
			label_num.(ser_num*4+3) <- lowest;;

(* 递归读数 *)
let rec readnum (file, num, ser_num) =
	if num < 1 then ()
	else (
		let data = input_binary_int file in
			covertnum (data, ser_num);
		readnum(file, num-4, ser_num+1)
	);;


(* 读取标签数据 *)
let readLabels (filename, num) =
	let file = open_in_bin filename in
		let magic_num = input_binary_int file in
		let image_num = input_binary_int file in
			image.magic_num <- magic_num;
			image.image_num <- image_num;
			let () = readnum (file, num, 0) in
				printf "%i %i\n" magic_num image_num ;
		close_in file;;

let rec display (pixel_ary, row, col) =
	if row < 28 then (
		if col < 28 then (
			if pixel_ary.(row*28+col) <> 0 then (
				draw_rect (20*(col)) (20*(28-row)) 2 0;
				single.(row).(col) <- 1
			)
			else ();
			display (pixel_ary, row, col+1)
		)
		else (
			display (pixel_ary, row+1, 0)))
	else ();;

let draw (pixel_ary, color) =
	open_graph " 560*560";
	set_color color;
	set_line_width 20;
	let () = display (pixel_ary, 0, 0) in
  printf "press Enter to close the graph\n";
	let _string = read_line () in
	close_graph ();;

let get_data num =
  readImage(train_image_file, num);
  readLabels(train_labels_file, num);
  let x = Array.make_matrix num 784 0 in
  let y = Array.make_matrix num 10 0 in
  for i=0 to num-1 do
    x.(i) <- pixel.(i);
    let pos = label_num.(i) in
    y.(i).(pos) <- 1;
  done;
  x, y
;;
