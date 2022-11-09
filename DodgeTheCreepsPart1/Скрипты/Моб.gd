extends RigidBody2D

export var min_speed = 150
export var max_speed = 250

func _ready():
	# randomize()
	$AnimatedSprite.playing = true
	# Создаем переменную для хранения названий анимаций
	var mob_type = $AnimatedSprite.frames.get_animation_names()
	# Назначаем анимацию с помощью массива и диапазона
	$AnimatedSprite.animation = mob_type[randi() % mob_type.size()]

# Метод для удаления моба если он выйдет за пределы экрана, чтобы не нагружать память
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
