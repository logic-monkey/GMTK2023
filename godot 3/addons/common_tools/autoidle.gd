extends AnimationPlayer

export var randomize_start := false
export var maximum_speed_variance := 0.0
func _ready():
	play("idle",-1,1 + rand_range(-maximum_speed_variance,maximum_speed_variance))
	if randomize_start:
		advance(rand_range(0, current_animation_length))
