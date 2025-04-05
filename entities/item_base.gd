class_name ItemBase

extends Control

@export var item_name: String = ""
@export_multiline var description: String = ""
@export var rarity := Utils.RARITY.COMMON

func _on_gui_input(event:InputEvent) -> void:
	if event.is_action_pressed("left_click"): 
		Utils.currently_selected_item = self
		SignalBus.item_changed.emit()
