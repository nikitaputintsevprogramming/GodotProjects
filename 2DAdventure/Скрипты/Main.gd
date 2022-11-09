extends Node

export(PackedScene) var mob_scene
var score

func _ready():
	randomize()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$DeathSound.play()


func new_game():
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	


func _on_MobTimer_timeout():
	# Создаем сцену с мобом 
	var mob = mob_scene.instance()

	# Выбираем рандомую локацию для моба на уровень
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()

	# Устанавливаем направление моба перпендикулярное пути направления
	var direction = mob_spawn_location.rotation + PI / 2

	# Устанавливаем рандомную позицию моба 
	mob.position = mob_spawn_location.position

	# Задаем рандомные направления для мобов во время каждого появления
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Выбираем скорость для мобов
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Спавним моба добавляя их на сцену
	add_child(mob)

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
