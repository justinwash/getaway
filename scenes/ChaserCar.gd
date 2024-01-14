extends VehicleBody3D

@export var lights_on = false : set = set_headlights_on

@export var STEER_SPEED = 1
@export var STEER_LIMIT = 0.4

@export var engine_force_value = 20
@export var brake_force_value = 10

var steer_target = 0
var reverse = false

@onready var initial_friction_slip = $WheelRL.wheel_friction_slip

@onready var initial_brake_light_brightness = $Body/Brakelights/Left.light_energy

@onready var nav = $NavigationAgent3D

func _physics_process(delta):
  var speed = linear_velocity.length()*Engine.get_physics_frames()*delta
  var fwd_mps = transform.basis.x
  var speed_steer_limit = clamp(STEER_LIMIT / (speed*0.2), 0.02, STEER_LIMIT)
  
  nav.target_position = get_node("../Car").global_position
  
  var direction = Vector3()
  direction = nav.get_next_path_position() - global_position
  direction = direction.normalized()
  
  #print("fwd: ", fwd_mps, " target: ", fwd_mps.normalized() - direction.normalized())
  
  steer_target = global_position.signed_angle_to(nav.get_next_path_position(), Vector3.UP) * -10
  print("steer_target: ", steer_target)
  steer_target *= speed_steer_limit
  
  steering = move_toward(steering, steer_target, STEER_SPEED * delta)
  
  if global_position.distance_to(nav.target_position) > 2:
    engine_force = engine_force_value


#func _process(delta):
  #var speed = linear_velocity.length()*Engine.get_frames_per_second()*delta
  ##traction(speed)
  #
  #var speed_steer_limit = clamp(STEER_LIMIT / (speed*0.2), 0.02, STEER_LIMIT)
  #
  #align_camera()
  #var fwd_mps = transform.basis.x.x
  #
  #steer_target = Input.get_action_strength("steer_left") - Input.get_action_strength("steer_right")
  #steer_target *= speed_steer_limit
  #
  #if Input.is_action_just_pressed("toggle_lights"):
    #set_headlights_on(!lights_on)
    #
  #if Input.is_action_just_pressed("shift_down"):
    #reverse = true
  #elif Input.is_action_just_pressed("shift_up"):
    #reverse = false
#
  #if Input.is_action_pressed("accelerate"):
    #engine_force = Input.get_action_strength("accelerate") * (engine_force_value if !reverse else -engine_force_value)
  #else:
    #engine_force = 0
    #
  #if Input.is_action_pressed("brake"):
    #brake = Input.get_action_strength("brake") * brake_force_value
    #for light in $Body/Brakelights.get_children():
      #light.light_energy = initial_brake_light_brightness * 2
  #else:
    #brake = 0.0
    #for light in $Body/Brakelights.get_children():
      #light.light_energy = initial_brake_light_brightness
    #
  #if Input.is_action_pressed("e_brake"):
    #brake = brake_force_value / 2
    #$WheelFL.wheel_friction_slip = initial_friction_slip / 5
    #$WheelFR.wheel_friction_slip = initial_friction_slip / 5
    #$WheelRL.wheel_friction_slip = initial_friction_slip / 10
    #$WheelRR.wheel_friction_slip = initial_friction_slip / 10
  #else:
    #$WheelFL.wheel_friction_slip = initial_friction_slip
    #$WheelFR.wheel_friction_slip = initial_friction_slip
    #$WheelRL.wheel_friction_slip = initial_friction_slip
    #$WheelRR.wheel_friction_slip = initial_friction_slip
    
  #steering = move_toward(steering, steer_target, STEER_SPEED * delta)
  
  
func set_headlights_on(value):
  lights_on = value

  for light in $Body/Headlights.get_children() + $Body/Brakelights.get_children():
    light.visible = value

  return value
  
  
func align_camera():
  $CameraGimbal.global_position = global_position
  
func traction(speed):
  apply_central_force(Vector3.DOWN*speed)
