extends Panel
var next_pos: Vector2 = Vector2(0,0)

func _ready() -> void:
	SignalBus.item_picked_up.connect(_on_item_picked_up)
	SignalBus.show_achievements.connect(_on_show_achievements)
	

func _on_exit_overview_button_down() -> void:
	$".".hide()

func _on_item_picked_up(item: Control) -> void:
	item.position = Vector2(0,0)
	$TextureRect/ScrollContainer/GridContainer.add_child(item)

	
	
func _on_show_achievements() -> void:
	$".".show()
