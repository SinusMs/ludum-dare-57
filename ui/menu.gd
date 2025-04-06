extends Control

@export var level : Node2D

func _ready() -> void:
	SignalBus.item_changed.connect(change_item)

func change_item(newLabelText: String) -> void:
	if Utils.currently_selected_item == null:
		$"CanvasLayer/Panel/NameFrame/NameLabel".text = ""
		$"CanvasLayer/Panel/DescriptionFrame/ScrollContainer/DescriptionLabel".text = ""
		$"CanvasLayer/Panel/ItemFrame/ItemTexture".texture = null
		$"CanvasLayer/Panel/StashButton/RichTextLabel".text = newLabelText
	else:
		$"CanvasLayer/Panel/NameFrame/NameLabel".text = Utils.currently_selected_item.item_name
		$"CanvasLayer/Panel/DescriptionFrame/ScrollContainer/DescriptionLabel".text = Utils.currently_selected_item.description
		$"CanvasLayer/Panel/ItemFrame/ItemTexture".texture = Utils.currently_selected_item.get_node("Sprite").texture
		$"CanvasLayer/Panel/StashButton/RichTextLabel".text = newLabelText


func _on_stash_button_button_down() -> void:
	if Utils.currently_selected_item == null:
		return
	if !level._spawn_children(Utils.currently_selected_item):
		Utils.found_items+=1
		SignalBus.item_picked_up.emit()
	level._spawn_particles(Utils.currently_selected_item)
	Utils.currently_selected_item.queue_free()
	Utils.currently_selected_item = null
	SignalBus.item_changed.emit("")


func _on_background_gui_input(event:InputEvent) -> void:
	if Utils.currently_selected_item == null:
		return
	if event.is_action_pressed("left_click"):
		print("are you happening?") 
		Utils.currently_selected_item.call_deferred("showHighlight", false)
		Utils.currently_selected_item = null
		SignalBus.item_changed.emit("")
