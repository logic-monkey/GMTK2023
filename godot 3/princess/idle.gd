extends State

func enter(_msg: Dictionary = {}):
	var ca = $"%AnimationPlayer".current_animation
	if ca == "land": yield($"%AnimationPlayer", "animation_finished")
	if state_machine.current == self: $"%AnimationPlayer".play("idle 1")

export var stick_walk_threshold := 0.2
func proc(_delta: float):
	if $"%VirtualGamepad".check_button("vp_jump"):
		transition("airborn", {"jump":true})
		return
	if abs($"%VirtualGamepad".stick.x) > stick_walk_threshold:
		transition("walk")
		return
	
	
	
export var gravity_multiplier := 0.5
export var drag_multiplier := 2.0

func phys(_delta: float):
	$"%SharedPhysics".move_owner(_delta, Vector2.ZERO, drag_multiplier, drag_multiplier)
	if not $"%SharedPhysics".body.is_on_floor(): transition("airborn")

func exit():
	pass
