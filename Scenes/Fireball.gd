extends Area2D

export var speed = 220
var direction = Vector2(0, 0)

func _physics_process(delta):
	var velocity = direction.normalized() * speed
	
	rotation = velocity.angle()
	position += velocity * delta

	if position.x > 320 + 16:
		get_tree().queue_delete(self)
	if position.x < 0 - 16:
		get_tree().queue_delete(self)
	if position.y > 240 + 16:
		get_tree().queue_delete(self)
	if position.y < 0 - 16:
		get_tree().queue_delete(self)
