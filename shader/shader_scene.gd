extends CanvasLayer

func _ready() -> void:
	SignalBus.item_picked_up.connect(_on_item_picked_up)
	
func _on_item_picked_up() -> void:
	$ColorRect.material.set_shader_parameter("found_items", Utils.found_items);
	print(Utils.found_items)
