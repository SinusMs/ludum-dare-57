class_name ItemBase

extends Control

@export var item_name: String = ""
@export_multiline var description: String = ""
@export var rarity := Utils.RARITY.COMMON
var isHighlighted : bool = false



func _ready() -> void:
	$Highlight.hide()

func _input(event):
	if event.is_action_pressed("left_click"): 
		isHighlighted = false
		$Highlight.hide()
		Utils.currently_selected_item = null
		SignalBus.item_changed.emit()
	pass


func _on_gui_input(event:InputEvent) -> void:
	if Geometry2D.is_point_in_polygon(event.position, $CollisionPolygon2D.polygon):
		$Highlight.show()
	else:
		if !isHighlighted:
			$Highlight.hide()
	
	if Geometry2D.is_point_in_polygon(event.position, $CollisionPolygon2D.polygon):
		if event.is_action_pressed("left_click"): 
			Utils.currently_selected_item = self
			SignalBus.item_changed.emit()
			isHighlighted = true
