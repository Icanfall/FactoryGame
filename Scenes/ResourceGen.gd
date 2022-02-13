extends Node2D

const WIDTH = 1020
const HEIGHT = 600

const TILES = ["Grass", "Red", "Blue", "Yellow"]

var open_simplex_noise

func _ready():
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
			pass
	pass

func _get_tile_index(noise_sample):
	noise_sample = (noise_sample+2)/2*TILES.size()
	noise_sample = round(noise_sample)
	return noise_sample
