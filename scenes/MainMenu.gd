extends Node3D

var job1scene = preload("res://scenes/Job1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
  $BackgroundAnimationPlayer.play("main_menu")


func start_game():
  get_tree().change_scene_to_packed(job1scene)

