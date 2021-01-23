extends "res://board/board.gd"

export(float) var _CLICK_TIME_WAIT: float
const _SELECT_COLOR: String = "80ffffff"
const _UNSELECT_COLOR: String = "ffffffff"
var _cells_node: Node
var _pieces_node: Node
var _selected_cells: Array
var _top_l_coord: Vector2
var _click_timer: Timer

func _ready():
	self._click_timer = Timer.new()
	self._click_timer.wait_time = self._CLICK_TIME_WAIT
	self._click_timer.one_shot = true
	self.add_child(self._click_timer)
	self.init()
	self.add_cells()

func init() -> void:
	if not self._cells:
		self._cells = []
	if not self._cells_node:
		self._cells_node = Node.new()
		self.add_child(self._cells_node)
	if not self._pieces_node:
		self._pieces_node = Node.new()
		self.add_child(self._pieces_node)
	else:
		self.clear_pieces_node()
	if not self._selected_cells:
		self._selected_cells = []
	else:
		self._selected_cells.clear()
	if not self._top_l_coord:
		self._top_l_coord = Vector2()
		self._top_l_coord.x = self._START_POS.x - self._CELL_DIM.x/2
		self._top_l_coord.y = self._START_POS.y - self._CELL_DIM.y/2

func clear_pieces_node() -> void:
	for child in self._pieces_node.get_children():
		self._pieces_node.remove_child(child)
		child.destroy()

func add_cell(_pos: Vector2, _texture: Texture, _row: Array) -> void:
	var cell: Sprite =  self._CELL_SCENE.instance()
	cell.texture = _texture
	self._cells_node.add_child(cell)
	cell.global_position = _pos
	_row.append(cell)

func add_cells() -> void:
	var row: Array
	var curr_pos: Vector2 = self._START_POS
	var flag: bool = true
	for _i in range(self._N_ROWS):
		row = []
		for _j in range(self._M_COLS):
			self.add_cell(curr_pos, self._CELL_TEXTURES[int(flag)], row)
			curr_pos.x += self._CELL_DIM.x
			flag = not flag
		self._cells.append(row)
		curr_pos.x = self._CELL_DIM.x
		curr_pos.y += self._CELL_DIM.y

func convert_to_board_coord(pos: Vector2) -> Array:
	var board_coord: Array
	if pos.x - self._top_l_coord.x < 0.0 or pos.y - self._top_l_coord.y < 0.0:
		board_coord = [-1, -1]
	else:
		var j: int = int((pos.x - self._top_l_coord.x)/self._CELL_DIM.x)
		var i: int = int((pos.y - self._top_l_coord.y)/self._CELL_DIM.y)
		board_coord = [i, j]
	return board_coord

func valid_coord(i: int, j: int) -> bool:
	return i >= 0 and i < self._N_ROWS and j >= 0 and j < self._M_COLS

func select_cell(i: int, j: int) -> void:
	var cell: Sprite = self._cells[i][j]
	if not cell in self._selected_cells:
		cell.change_color(self._SELECT_COLOR)
		self._selected_cells.append(cell)
	else:
		cell.change_color(self._UNSELECT_COLOR)
		self._selected_cells.erase(cell)

func _input(event):
	if event is InputEventMouseButton and self._click_timer.is_stopped():
		self._click_timer.start()
		if event.button_index == BUTTON_LEFT:
			var coord: Array = self.convert_to_board_coord(event.position)
			if self.valid_coord(coord[0], coord[1]):
				self.select_cell(coord[0], coord[1])
