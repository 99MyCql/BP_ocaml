(*
运行入口文件
*)
open BP ;;


let data_count = 500 ;;

(* 使用 y=x^2 模型对 BP 模块进行测试 *)
let x_count = 3
and y_count = 2
and mid_count = 10 in
(* let x_arr = Array.make_matrix data_count x_count 0.
and y_arr = Array.make_matrix data_count x_count 0. in *)
init x_count mid_count y_count ;
train [|[|1.;2.;3.|];[|4.;5.;6.|]|] [|[|0.4;0.6|];[|0.3;0.5|]|] ;
let y_pred_arr = predict [|[|1.;2.;3.|];[|4.;5.;6.|]|] in
print_endline "predict ===>";
print_matrix y_pred_arr;