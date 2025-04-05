extends Node2D

@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, 'modulate:a', 1.0, 0.8)
	timer.wait_time = Main.timer_wait_time
	timer.start()

func _on_timer_timeout() -> void:
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, 'position', position + Vector2(-500, 0), 2.0)
	tween.tween_property(self, 'modulate:a', 0, 1.0)
	await tween.finished
	queue_free()
