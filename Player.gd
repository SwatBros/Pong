extends KinematicBody2D


var speed: int = 400
var ai: bool = false
export(String, "l", "r") var dir = "l"

func _physics_process(delta):
	var velocity: Vector2 = Vector2.ZERO
	
	if not ai:
		if Input.is_action_pressed(dir + "_up"):
			velocity += Vector2.UP
		if Input.is_action_pressed(dir + "_down"):
			velocity += Vector2.DOWN
	if Input.is_action_just_released(dir + "_ai"):
		ai = not ai
	
	if ai:
		var bp = owner.ball.position.y
		if abs(bp - position.y) > 1e-2:
			velocity += (Vector2.UP if bp < position.y
				else Vector2.DOWN)
		
	var _collision = move_and_collide(velocity * (speed + (100 if ai else 0)) * delta)
