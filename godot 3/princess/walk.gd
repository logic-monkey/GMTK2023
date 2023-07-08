extends State

func enter(_msg: Dictionary = {}):
	var ca = $"%AnimationPlayer".current_animation
	if ca == "land": yield($"%AnimationPlayer", "animation_finished")
	if state_machine.current == self: $"%AnimationPlayer".play("walk")

export var walk_stick_threshold:= 0.2
export var walk_speed_threshold:= 0.1
func proc(_delta: float):
	if $"%VirtualGamepad".check_button("vp_jump"):
		transition("airborn", {"jump":true})
		return
	if $"%SharedPhysics".velocity_cache.length_squared() < walk_speed_threshold and \
			abs($"%VirtualGamepad".stick.x) < walk_stick_threshold:
		transition("idle")
		return
	
export var walk_acceleration := 10.0
export var walk_drag_multiplier := 1
export var walk_gravity_multiplier := 0.5

export var turn_around_acceleration := 2

func phys(_delta: float):
	var xAccel = $"%VirtualGamepad".stick.x * walk_acceleration
	if xAccel > 0: 
		$"%graphic".scale.x = 1
		if $"%SharedPhysics".velocity_cache.x < 0:
			xAccel *= turn_around_acceleration
	elif xAccel < 0: 
		$"%graphic".scale.x = -1
		if $"%SharedPhysics".velocity_cache.x > 0:
			xAccel *= turn_around_acceleration
	$"%SharedPhysics".move_owner(_delta, Vector2(xAccel,0), walk_drag_multiplier,walk_gravity_multiplier)
	if not $"%SharedPhysics".body.is_on_floor(): transition("airborn")
	
func exit():
	pass
