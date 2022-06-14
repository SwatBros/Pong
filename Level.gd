extends Node2D

onready var ball = $Ball
onready var lLabel = $Labels/LPoints
onready var rLabel = $Labels/RPoints
onready var timerLabel = $Labels/Timer
onready var timer = $Timer

var rPoints: int = 0
var lPoints: int = 0

var mutedFx: bool = false


func _ready():
	OS.set_window_maximized(true)
	
	rLabel.text = "0"
	lLabel.text = "0"
	
	ball.sleep()
	startTimer()


func _process(_d):
	if Input.is_action_just_released("reset"):
		ball.reset()
		ball.sleep()
		
		startTimer()
		
		rPoints = 0
		lPoints = 0
		rLabel.text = str(rPoints)
		lLabel.text = str(lPoints)
	
	if Input.is_action_just_released("mute_s"):
		if $Soundtrack.playing:
			$Soundtrack.stop()
		else:
			$Soundtrack.play()
	
	if Input.is_action_just_pressed("mute_fx"):
		mutedFx = not mutedFx
	
	if Input.is_action_just_released("license"):
		$Labels/License.visible = not $Labels/License.visible
	
	if Input.is_action_just_pressed("fullscreen"):
		OS.set_window_fullscreen(!OS.window_fullscreen)
	
	if Input.is_action_just_released("close"):
		get_tree().quit()
	
	
	if timerLabel.visible == false:
		return
	
	if not mutedFx and timerLabel.text != str(ceil(timer.time_left)):
		$AudioT.play()
	
	timerLabel.text = str(ceil(timer.time_left))


func _input(event):
	if event is InputEventMouseMotion:
		if not $Labels/Keys.visible:
			$Labels/Keys.visible = true
			$TextFadeOut.start()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_LeftArea_body_entered(body):
	if body == ball:
		ball.reset()
		ball.sleep()
		
		startTimer()
		
		rPoints += 1
		rLabel.text = str(rPoints)
		
		if not mutedFx:
			$AudioScore.play()


func _on_RightArea_body_entered(body):
	if body == ball:
		ball.reset()
		ball.sleep()
		
		startTimer()
		
		lPoints += 1
		lLabel.text = str(lPoints)
		
		if not mutedFx:
			$AudioScore.play()


func _on_Timer_timeout():
	ball.move()
	timerLabel.visible = false
	
	if not mutedFx:
		$AudioT.play()


func startTimer():
	timer.start()
	timerLabel.visible = true


func _on_TextFadeOut_timeout():
	if $Labels/Keys.visible:
		$Labels/Keys.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
