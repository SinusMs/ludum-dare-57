extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Highlight.hide()


func _on_mouse_entered() -> void:
	$Highlight.show()


func _on_mouse_exited() -> void:
	$Highlight.hide()


func _on_body_entered(body: Node2D) -> void:
	SignalBus.trash_removed.emit(body)
