extends Area2D
export var speed = 400
var Screen_size = Vector2(0, 0)

func _ready():
	Screen_size = get_viewport_rect().size

func _process(delta):
	var Direction = Vector2(0, 0)
	if (Input.is_action_pressed("ui_right")):
		Direction.x = Direction.x + 1
	if (Input.is_action_pressed("ui_left")):
		Direction.x = Direction.x - 1
	if (Input.is_action_pressed("ui_up")):
		Direction.y = Direction.y - 1
		
	if (Input.is_action_pressed("ui_down")):
		Direction.y = Direction.y + 1
		
	position += Direction * speed * delta

	# Метод clamp - не дает выйти игроку за границы экрана
	position.x = clamp(position.x, 0, Screen_size.x)
	position.y = clamp(position.y, 0, Screen_size.y)

