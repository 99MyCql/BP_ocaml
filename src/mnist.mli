(*---------------------------------------------------------------------------
  @name: mnist.mli
  @description: 解析mnist数据集模块接口
  @author: taymarine
-----------------------------------------------------------------------------*)

(*
  Function draw:
    打开图形化窗口，画出使用到的 mnist 数据集中的数字

  Arguments:
    pixel_ary: int array  数据源于一张 mnist 图片的 28*28 点阵，视为有 784 个数据的一维数组；
    color:  Graphics.color

  Returns:
    unit: nothing

  Remark:
    输入的数组中没有颜色渲染的部分均以 0 作为标识，其他部分不做限制；
*)
val draw : int array * Graphics.color -> unit

(*
  Function get_data:
    供外部引用的借口，用于提取 mnist 数据集中的数据，以格式化的形式返回；具体过程封装于文件 mnist.ml 中；

  Arguments:
    num：int 用于标识需要获取的 mnist 图片的数量

  Returns:
    x,y: int array array * int array array
    x 用于获取格式化后的图片数据集
    y 用于获取格式化后的标签集合

  Remark:
    注意返回值类型为 int;
*)
val get_data : int -> int array array * int array array