extends Node

export (PackedScene) var mob_scene
var score

func _ready():
	randomize()

func new_game():
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$HUD.update_score(score)
	
	$ScoreTimer.start()
	
	$HUD.show_message("Get ready...")
	
	yield($StartTimer, "timeout")
	$StartTimer.start()
	$MobTimer.start()
	
	
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_message("Game Over")

func _on_MobTimer_timeout():
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.unit_offset = randf()
	
	var mob = mob_scene.instance()
	add_child(mob)
	
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction) 


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
