extends Node3D

@export var brightness = 3.0 : set = set_brightness

func set_brightness(value):
  for light in get_children():
    light.get_node("SpotLight3D").light_energy = value

  brightness = value
  return value
