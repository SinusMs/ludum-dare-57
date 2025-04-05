class_name ItemBase

extends Control

@export var item_name: String = ""
@export_multiline var description: String = ""
@export var rarity := Utils.RARITY.COMMON
var isHighlighted : bool = false

@export var children : Dictionary[PackedScene, Vector2]
var rauchwolke : CPUParticles2D = preload("res://entities/rauchwolke_cpu_particles.tscn").instantiate()
@export var mittelpunkt : Vector2 = Vector2(0, 0)

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



