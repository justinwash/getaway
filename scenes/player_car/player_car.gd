extends Node3D

@export var lights_on = false : set = set_headlights_on

func set_headlights_on(value):
  lights_on = value

  for light in $Body/Headlights.get_children() + $Body/Brakelights.get_children():
    light.visible = value

  return value
