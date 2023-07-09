extends PathFollow2D

export var speed : float = 3
func _physics_process(delta):
	offset += speed * delta
