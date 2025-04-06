extends Node2D

var rauchwolke_scene : PackedScene = preload("res://entities/rauchwolke_cpu_particles.tscn")
var screen_tint_scene : PackedScene = preload("res://entities/kein_minigame/screen_tint.tscn")
var trash_scene : PackedScene = preload("res://entities/kein_minigame/draggable_object.tscn")
var usable_trash_can_scene : PackedScene = preload("res://entities/kein_minigame/usable_trashcan.tscn")
var items_bis_km : int = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.item_changed.connect(item_play_sound)
	SignalBus.trash_removed.connect(remove_trash)
	SignalBus.item_picked_up.connect(spawn_trash)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func item_play_sound(string : String) -> void:
	if Utils.currently_selected_item == null:
		return
	$AudioStreamPlayer.stream = Utils.currently_selected_item.sound
	$AudioStreamPlayer.play()


func _spawn_children(item : ItemBase) -> bool:
	var children : Dictionary = item.children
	if children.size() == 0:
		return false
	for child : PackedScene in children:
		var child_scene : ItemBase = child.instantiate()
		child_scene.position = item.position + children[child]
		%ItemContainer.add_child(child_scene)
	return true


func _spawn_particles(item : ItemBase) -> void:
	var rauchwolke: CPUParticles2D = rauchwolke_scene.instantiate()
	rauchwolke.position = item.position + item.mittelpunkt
	rauchwolke.emitting = true
	%ParticleContainer.add_child(rauchwolke)

var trash_amount : int = 0
func spawn_trash() -> void:
	items_bis_km -= 1
	if items_bis_km != 0:
		return
	trash_amount = 8
	var screen_tint : TextureRect = screen_tint_scene.instantiate()
	%KeinMinigameContainer.add_child(screen_tint)
	var usable_trash_can : Area2D = usable_trash_can_scene.instantiate()
	%KeinMinigameContainer.add_child(usable_trash_can)
	usable_trash_can.position = Vector2(64, 600)
	for i : int in trash_amount:
		var trash : CharacterBody2D = trash_scene.instantiate()
		%KeinMinigameContainer.add_child(trash)
		trash.position = Vector2(randi_range(64, 480), randi_range(64, 576))


func remove_trash(trash : CharacterBody2D) -> void:
	var rauchwolke: CPUParticles2D = rauchwolke_scene.instantiate()
	rauchwolke.position = trash.position
	rauchwolke.emitting = true
	%ParticleContainer.add_child(rauchwolke)
	trash.queue_free()
	trash_amount -= 1
	if trash_amount <= 0:
		cleanup()


func cleanup() -> void:
	for child in %KeinMinigameContainer.get_children():
		child.queue_free()
	items_bis_km = 2
