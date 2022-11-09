extends Sprite

var speed 

func _on_MenuItem_firstCheck():
	speed = 10

func _on_MenuItem_secondCheck():
	speed = 20

func _on_MenuItem_thirdCheck():
	speed = 30

func _on_Timer_timeout():
	print(speed)
