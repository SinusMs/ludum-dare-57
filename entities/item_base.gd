class_name ItemBase

extends Control

@export var item_name: String = ""
@export_multiline var description: String = ""
@export var rarity := Utils.RARITY.COMMON
@export var children : Dictionary[PackedScene, Vector2]
var rauchwolke : CPUParticles2D = preload("res://entities/rauchwolke_cpu_particles.tscn").instantiate()
@export var mittelpunkt : Vector2 = Vector2(0, 0)

func _ready() -> void:
	$Highlight.hide()
	mouse_filter = Control.MOUSE_FILTER_PASS


func _on_gui_input(event:InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		Utils.currently_selected_item = self
		SignalBus.item_changed.emit()


func _spawn_children() -> void:
	if children.size() == 0:
		return
	rauchwolke.position = position + mittelpunkt
	rauchwolke.emitting = true
	for child : PackedScene in children:
		var child_scene : ItemBase = child.instantiate()
		child_scene.position = position + children[child]
		get_tree().root.add_child(child_scene)
	get_tree().root.add_child(rauchwolke)


func _on_mouse_entered() -> void:
	$Highlight.show()


func _on_mouse_exited() -> void:
	$Highlight.hide()
