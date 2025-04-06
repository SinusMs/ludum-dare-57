class_name ItemBase

extends Control

@export var item_name: String = ""
@export_multiline var description: String = ""
@export var rarity := Utils.RARITY.COMMON
@export var children : Dictionary[PackedScene, Vector2]
var mittelpunkt : Vector2
var isHighlighted : bool = false

func _ready() -> void:
	$Highlight.hide()
	mittelpunkt = %Mittelpunkt.position

func showHighlight(_show: bool) -> void:
	if _show:
		$Highlight.show()
	else:
		$Highlight.hide()

	


func _on_gui_input(event:InputEvent) -> void:
	if Geometry2D.is_point_in_polygon(event.position, $CollisionPolygon2D.polygon):
		showHighlight(true)
	else:
		if !isHighlighted:
			showHighlight(false)

	if Geometry2D.is_point_in_polygon(event.position, $CollisionPolygon2D.polygon):
		if event.is_action_pressed("left_click"):
			if Utils.currently_selected_item != null:
				Utils.currently_selected_item.call_deferred("showHighlight", false)
				Utils.currently_selected_item.isHighlighted = false
			Utils.currently_selected_item = self
			print(Utils.currently_selected_item.item_name)
			SignalBus.item_changed.emit()
			isHighlighted = true
