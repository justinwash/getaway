extends Node3D

var selected = 0

@onready var transition_animation_player = get_node("../TransitionAnimationPlayer")

@onready var buttons = {
  0: {
    "hover": $StartHover,
    "on_click": "start_game_anim"
  },
  1: {
    "hover": $OptionsHover,
    "on_click": "open_options"
  },
  2: {
    "hover": $QuitHover,
    "on_click": "quit"
  }
}
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
  if Input.is_action_just_pressed("ui_right"):
    selected = clamp(selected + 1, 0, 2)
  elif Input.is_action_just_pressed("ui_left"):
    selected = clamp(selected - 1, 0, 2)

  for button in buttons.keys():
    if button == selected:
      buttons[button].hover.visible = true
    else:
      buttons[button].hover.visible = false

  if Input.is_action_just_pressed("ui_accept"):
    call(buttons[selected].on_click)

func start_game_anim():
  transition_animation_player.play("start")
  print("start_game pressed")

func start_game():
  print("start_game called")

func open_options():
  print("options pressed")

func quit():
  get_tree().quit()
