extends Node2D

var rauchwolke : CPUParticles2D = preload("res://entities/rauchwolke_cpu_particles.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _spawn_children(item : ItemBase) -> void:
	var children : Dictionary = item.children
	if children.size() == 0:
		return
	for child : PackedScene in children:
		var child_scene : ItemBase = child.instantiate()
		child_scene.position = item.position + children[child]
		%ItemContainer.add_child(child_scene)


func _spawn_particles(item : ItemBase) -> void:
	
	rauchwolke.position = item.position + item.mittelpunkt
	rauchwolke.emitting = true
	%ParticleContainer.add_child(rauchwolke)
