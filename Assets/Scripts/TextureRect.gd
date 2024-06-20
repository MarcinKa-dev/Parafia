extends TextureRect


var region_values = [64, 32, 0]
var current_index = 0
var timer = 0.0
var update_interval = 0.45  # czas w sekundach
var x0 = 330
func _ready():
	# Ustaw początkowy region, jeśli potrzebujesz
	update_region()
	set_process_input(true)

func _process(delta):
	timer += delta
	if timer >= update_interval:
		timer = 0.0  # Resetuj timer
		current_index = (current_index + 1) % region_values.size()  # Przejdź do następnej wartości
		update_region()

func update_region():
	var texture_region = self.texture.get_region()
	#print(texture_region)
	texture_region.position.x = region_values[current_index]
	self.texture.set_region(texture_region)
	#self.texture = self.texture.new_with_region(texture_region)

func _input(event):
	if event is InputEventKey:
		if event.pressed:  # Reaguj tylko kiedy klawisz jest naciśnięty
			if event.keycode >= 49 and event.keycode <= 56:
				position.x = x0 + ((event.keycode - 49) * 68)
	elif event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				if position.x > x0 + (68*7):
					position.x = x0
				else:
					position.x += 34
			MOUSE_BUTTON_WHEEL_DOWN:
				if position.x < x0:
					position.x = x0 + (68*7)
				else:
					position.x -= 34
