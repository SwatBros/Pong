extends KinematicBody2D


var speed: int = 600
var velocity: Vector2
var state: String = "moving"


func _ready():
	randomize()
	reset()


func _physics_process(delta):
	if state == "sleeping":
		return
	
	var _collision = move_and_collide(velocity * speed * delta)
	
	if _collision:
		velocity = velocity.bounce(_collision.normal)
		
		if(velocity.x == 0 or velocity.y == 0 or abs(velocity.y / velocity.x) < 0.3):
			resetDirection()
		
		speedUp()
		
		if not owner.mutedFx:
			$AudioStreamPlayer.play()


func resetPosition():
	position = Vector2(1920 / 2, 1080 / 2)


func resetDirection():
	velocity = Vector2.ZERO
	
	velocity.x = [-1, 1][randi() % 2]
	velocity.y = 0.8 * [-1, 1][randi() % 2]


func reset():
	resetPosition()
	resetDirection()
	
	speed = 600


func sleep():
	state = "sleeping"


func move():
	state = "moving"


func speedUp():
	speed += 10 
