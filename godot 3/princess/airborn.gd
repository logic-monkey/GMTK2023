extends State

export var jump_strength := 20.0
var jumping := false
func enter(_msg: Dictionary = {}):
	if "jump" in _msg:
		jumping = true
		$"%SharedPhysics".velocity_cache.y = -jump_strength
		$"%AnimationPlayer".play("into_jump")
		yield($"%AnimationPlayer","animation_finished")
		$"%AnimationPlayer".play("rising")
	else: 
		jumping = false
		$coyote_timer.start()
		$"%AnimationPlayer".play("rise_to_fall")
		yield($"%AnimationPlayer", "animation_finished")
		if state_machine.current == self: $"%AnimationPlayer".play("falling")

func proc(_delta: float):
	if $"%VirtualGamepad".check_button("vp_jump") and not $coyote_timer.is_stopped():
		transition("airborn", {"jump":true})
	
export var rising_gravity_multiplier := 0.5
export var falling_gravity_multiplier := 2
export var drag_multiplier := 0.5
export var directional_acceleration := 4.0

func phys(_delta: float):
	if jumping and not $"%VirtualGamepad".is_button_down("vp_jump"):
		jumping = false
	if jumping and $"%SharedPhysics".velocity_cache.y > 0:
		jumping = false
	var grav = rising_gravity_multiplier
	if not jumping: grav = falling_gravity_multiplier
	var xAccel = $"%VirtualGamepad".stick.x * directional_acceleration
	if xAccel > 0: $"%graphic".scale.x = 1
	elif xAccel < 0: $"%graphic".scale.x = -1
	var accel = Vector2(xAccel,0)
	
	$"%SharedPhysics".move_owner(_delta, accel, drag_multiplier, grav)
	if $"%SharedPhysics".body.is_on_floor():
		$"%AnimationPlayer".play("land")
		transition("idle")
		return
		
	if $"%AnimationPlayer".current_animation == "rising" and $"%SharedPhysics".velocity_cache.y > 0:
		$"%AnimationPlayer".play("rise_to_fall")
		yield($"%AnimationPlayer", "animation_finished")
		if state_machine.current == self: $"%AnimationPlayer".play("falling")

func exit():
	pass
