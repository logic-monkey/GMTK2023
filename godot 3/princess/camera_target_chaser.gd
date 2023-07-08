extends Position2D

export(NodePath) var camera_target_node_path
var target : Node2D

func _ready():
	yield(get_tree(),"idle_frame")
	target = get_node(camera_target_node_path)
	
	
export var catch_up_rate = 0.74
const SANITY_MULTIPLIER = 30.0
func _physics_process(delta):
	if not target: return
	global_position = lerp(global_position, target.global_position, catch_up_rate * delta * SANITY_MULTIPLIER)
