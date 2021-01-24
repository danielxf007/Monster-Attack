extends Node2D

export(PackedScene) var _CELL_SCENE: PackedScene
export(Array) var _CELL_TEXTURES: Array
export(Vector2) var _START_POS: Vector2
export(Vector2) var _CELL_DIM: Vector2
export(int) var _N_ROWS: int
export(int) var _M_COLS: int
var _cells: Array

func init() -> void:
	pass

func add_cell(_pos: Vector2, _texture: Texture, _row: Array, _i: int, _j:int) -> void:
	pass

func add_cells() -> void:
	pass
