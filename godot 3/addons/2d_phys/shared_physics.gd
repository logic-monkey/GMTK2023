extends Node
class_name SharedPhysics, "phys.svg"

export var base_drag := 0.1
export var base_gravity := 3.0
onready var body := owner as KinematicBody2D

const SANITY_MULTIPLIER := 30.0

var velocity_cache = Vector2.ZERO
func move_owner(delta: float, acceleration: Vector2 = Vector2.ZERO,\
		 drag_multiplier: float = 1, gravity_multiplier: float = 1):
	
	acceleration.y += base_gravity * gravity_multiplier * delta * SANITY_MULTIPLIER
	acceleration -= velocity_cache * base_drag * drag_multiplier * delta * SANITY_MULTIPLIER
	velocity_cache += acceleration / 2
	velocity_cache = body.move_and_slide(velocity_cache,Vector2.UP)
	velocity_cache += acceleration / 2
