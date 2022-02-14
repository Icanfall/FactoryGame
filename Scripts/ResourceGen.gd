extends Node2D

const WIDTH = 256
const HEIGHT = 150

const TILES = ["Red", "Grass", "Yellow", "Blue"]

var open_simplex_noise
var camera_pos

func _ready():
	camera_pos = $Camera2D.position
	
	open_simplex_noise = OpenSimplexNoise.new()
	open_simplex_noise.seed = randi()
	
	open_simplex_noise.octaves = 4
	open_simplex_noise.period = 15
	open_simplex_noise.lacunarity = 1.5
	open_simplex_noise.persistence = 0.75
	
	_generate_world()

func _generate_world():
	for x in WIDTH:
		for y in HEIGHT:
			var noise = open_simplex_noise.get_noise_2d(float(x), float(y))
			var index = _get_tile_index(noise)
			$TileMap.set_cell(x+camera_pos.x, y+camera_pos.y, index)
			pass
	pass

func _get_tile_index(noise_sample):
	noise_sample = (noise_sample+1)/2.0*(TILES.size()+1)
	noise_sample = round(noise_sample)
	return noise_sample
