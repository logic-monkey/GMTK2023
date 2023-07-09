extends Node
class_name PlayerController, "player control icon.svg"

var vc = null
export var active := true
var sploring = false
func _process(delta):
	if Engine.is_editor_hint(): return
	if _IMP.mode != _IMP.EXPLORE: return
	sploring = true
	if not active: return
	if not vc:
		for node in owner.get_children():
			if node is VirtualGamepad:
				vc = node
				break
	if not vc: return
	for button in vc.buttons:
		vc.buttons[button].update_button(Input.is_action_pressed(button))
	vc.stick = Input.get_vector("vp_left","vp_right","vp_up","vp_down")


func _on_mode_change(mode):
	if not sploring: return
	if not vc: return
	if mode != _IMP.EXPLORE:
		vc.stick = Vector2.ZERO
		
func _ready():
	_IMP.connect("imp_mode_changed", self, "_on_mode_change")
