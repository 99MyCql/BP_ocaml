(*---------------------------------------------------------------------------
  @name: util.mli
  @description: 工具模块的接口
-----------------------------------------------------------------------------*)

(*
  Function print_row:
    打印一维 Array 数组

  Arguments:
    row:float array

  Returns:
    uint: nothing.

  Remark:
*)
val print_row :
  float array ->
  unit

(*
  Function print_matrix:
    打印二维 Array 数组

  Arguments:
    matr:float array array

  Returns:
    uint: nothing.

  Remark:
*)
val print_matrix :
  float array array ->
  unit

(*
  Function get_subMatrix:
    获取二维 Array 数组的子数组

  Arguments:
    matr:float array array
    start_pos:int   子数组在原数组一维中开始下标
    end_pos:int     子数组在原数组一维中结束下标

  Returns:
    subMat:float array array  子数组

  Remark:
*)
val get_subMatrix :
  float array array ->
  int ->
  int ->
  float array array

(*
  Function scatter:
    画散点图

  Arguments:
    x_arr:int             x 轴点
    y_arr:int             y 轴点
    color:Graphics.color  点颜色，如: red,green,blue

  Returns:
    uint: nothing.

  Remark: using after open_graph
*)
val scatter :
  int array ->
  int array ->
  Graphics.color ->
  unit
