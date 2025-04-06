extends Control

@export var level : Node2D

func _ready() -> void:
	SignalBus.item_changed.connect(change_item)

func change_item() -> void:
	if Utils.currently_selected_item == null:
		$"CanvasLayer/Panel/NameLabel".text = ""
		$"CanvasLayer/Panel/ScrollContainer/DescriptionLabel".text = ""
		$"CanvasLayer/Panel/ItemTexture".texture = null
	else:
		$"CanvasLayer/Panel/NameLabel".text = Utils.currently_selected_item.item_name
		$"CanvasLayer/Panel/ScrollContainer/DescriptionLabel".text = Utils.currently_selected_item.description
		$"CanvasLayer/Panel/ItemTexture".texture = Utils.currently_selected_item.get_node("Sprite").texture


func _on_stash_button_button_down() -> void:
	if Utils.currently_selected_item == null:
		return
	level._spawn_children(Utils.currently_selected_item)
	level._spawn_particles(Utils.currently_selected_item)
	Utils.currently_selected_item.queue_free()
	Utils.currently_selected_item = null
	SignalBus.item_changed.emit()


func _on_background_gui_input(event:InputEvent) -> void:
	if Utils.currently_selected_item == null:
		return
	if event.is_action_pressed("left_click"):
		print("are you happening?") 
		Utils.currently_selected_item.call_deferred("showHighlight", false)
		Utils.currently_selected_item = null
		SignalBus.item_changed.emit()
