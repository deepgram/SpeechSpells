extends Node2D

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	$DeepgramInstance.initialize("INSERT_YOUR_API_KEY_HERE")

func _on_DeepgramInstance_message_received(message):
	var message_json = JSON.parse(message)
	if message_json.error == OK:
		if typeof(message_json.result) == TYPE_DICTIONARY:
			if message_json.result.has("is_final"):
				if message_json.result["is_final"] == true:
					var message_transcript = message_json.result["channel"]["alternatives"][0]["transcript"]
					print("Transcript received: " + message_transcript)
					for _i in message.count("fire"):
						spawn_fireball()

	else:
		print("Failed to parse Deepgram message!")

func spawn_fireball():
	var fireball = load("res://Scenes/Fireball.tscn").instance()
	add_child(fireball)
	
	var random_angle = rng.randf_range(0.0, 2 * PI)
	fireball.direction = Vector2(cos(random_angle), sin(random_angle))
	fireball.rotation = fireball.direction.angle()
	fireball.position = $Player.position
