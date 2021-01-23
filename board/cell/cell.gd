extends Sprite


var _pieces_on: int

func _ready():
	self._pieces_on = 0

func is_available() -> bool:
	return not self._pieces_on

func _on_Area2D_area_entered(_area) -> void:
	self._pieces_on += 1

func _on_Area2D_area_exited(_area) -> void:
	self._pieces_on -= 1

func change_color(color_name: String) -> void:
	self.modulate = color_name
