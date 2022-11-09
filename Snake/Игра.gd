extends Node2D

# Массив для длины змейки
var Snake = []

# Для проверки следующего местоположения змеи
var last_pos  = Vector2(0, 0)
var next_pos  = Vector2(0, 0)

func _ready():
	Snake = [Vector2(5, 5)]
	$TileMap.set_cellv(Snake[0], 1)

func _process(delta):
	# Начальное положение змейки
	var position = Vector2(0, 0)
	
	# Движение вверх вних
	if (Input.is_action_just_pressed("ui_up")):
		position = Vector2(0, -1)
	elif (Input.is_action_just_pressed("ui_down")):
		position = Vector2(0, 1)
	
	# Движение влево вправо	
	if (Input.is_action_just_pressed("ui_left")):
		position = Vector2(-1, 0)
	elif (Input.is_action_just_pressed("ui_right")):
		position = Vector2(1, 0)
	# Проверка на смену направления(нельзя пойти в обратную сторону в сами себя)
	if position != Vector2(0, 0) and last_pos != position *-1:
		next_pos = position
		$Timer.start()


func _on_Timer_timeout():
	if next_pos == Vector2(0, 0):
		$Timer.stop()
		return
	# Голова будет смещаться назад, а туловище увеличиваться
	var head = Snake[-1]
	var body = Snake[0]
	
	# Присоединяем голову к туловищу и указываем направление туловища за головой
	var next = head + next_pos
	Snake.append(next)
	
	# Переменная для присваивания цвета змейке если мы съедаем яблоко
	var next_cell = $TileMap.get_cellv(next)
	
	# Создаем условие, которое будет окрашивать следующую ячейку змеи
	# Если не подбирает яблоко она будет окрашиваться в серый цвет(0 элемент в списке тайлов)
	# Если она вообще ничего не подбирает, то возвращаем значение 0
	match next_cell:
		0:
			$TileMap.set_cellv(body, 0)
			$TileMap.set_cellv(next, 1)
			Snake.remove(0)
