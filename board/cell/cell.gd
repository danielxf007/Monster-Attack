extends Sprite
signal was_selected(cell)

const _SELECT_COLOR: String = "80ffffff"
const _UNSELECT_COLOR: String = "ffffffff"
var _row: int
var _col: int
var _pieces_on: int
var _selected: bool

func _ready():
	self._pieces_on = 0
	self._selected = false

func set_coord(row: int, col: int) -> void:
	self._row = row
	self._col = col

func is_available() -> bool:
	return not self._pieces_on

func has_coord(row: int, col: int) -> bool:
	return self._row == row and self._col == col

func _on_GameBoard_selected(row: int, col: int) -> void:
	if self.is_available() and self.has_coord(row, col) and not self._selected:
		self.change_color(self._SELECT_COLOR)
		self._selected = true
		self.emit_signal("was_selected", self)
	elif self.has_coord(row, col) and self._selected:
		self.change_color(self._UNSELECT_COLOR)
		self._selected = false
		self.emit_signal("was_selected", self)

func _on_Area2D_area_entered(_area) -> void:
	self._pieces_on += 1

func _on_Area2D_area_exited(_area) -> void:
	self._pieces_on -= 1

func change_color(color_name: String) -> void:
	self.modulate = color_name
