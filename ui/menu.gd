extends Control

@export var level : Node2D

func _ready() -> void:
	SignalBus.item_changed.connect(change_item)
	
	SignalBus.close_achievements.connect(_on_close_achievements)

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
		
		# set item frame texture beased on enuim TYPE
		if Utils.currently_selected_item.type == Utils.TYPE.STORY:
			$CanvasLayer/Panel/ItemFrame.texture = load("res://assets/UI/frame-story.png")
		elif Utils.currently_selected_item.type == Utils.TYPE.EGG:
			$CanvasLayer/Panel/ItemFrame.texture = load("res://assets/UI/frame-secret.png")
		else:
			$CanvasLayer/Panel/ItemFrame.texture = load("res://assets/UI/frame-default.png")
			

func _on_stash_button_button_down() -> void:
	if Utils.currently_selected_item == null:
		return
	if !level._spawn_children(Utils.currently_selected_item):
		Utils.found_items+=1
		SignalBus.item_picked_up.emit(Utils.currently_selected_item.duplicate())
		
	
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

		if Utils.currently_hovered_item != null:
			Utils.currently_hovered_item.set_deferred("isHighlighted", false)




func _on_achievement_button_button_down() -> void:
	SignalBus.show_achievements.emit()
	$CanvasLayer/Panel/StashButton.hide()
	$CanvasLayer/Panel/AchievementButton.hide()

func _on_close_achievements() -> void:
	$CanvasLayer/Panel/StashButton.show()
	$CanvasLayer/Panel/AchievementButton.show()
