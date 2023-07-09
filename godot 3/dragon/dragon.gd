extends CanvasLayer

func _ready():
	_GM.connect("game_lose", self, "_on_lose")
func _on_lose():
	$AnimationPlayer.play("awake")
