extends Node2D

const WIDTH = 200
const HEIGHT = 100

const TILES = ["Red", "Grass", "Yellow", "Blue"]

var open_simplex_noise
var camera_pos

func _ready():
	randomize()
	camera_pos = $Camera_Holder.position
	
	open_simplex_noise = OpenSimplexNoise.new()
	open_simplex_noise.seed = randi()
	
	open_simplex_noise.octaves = 4
	open_simplex_noise.period = 50
	open_simplex_noise.lacunarity = 1.5
	open_simplex_noise.persistence = 0.75
	
	_generate_world()

func _generate_world():
	camera_pos = $Camera_Holder.position/$TileMap.cell_size
	for x in range(camera_pos.x,WIDTH+camera_pos.x):
		for y in range(camera_pos.y,HEIGHT+camera_pos.y):
			if $TileMap.get_cell(x,y) != -1:
				continue
			var noise = open_simplex_noise.get_noise_2d(float(x), float(y))
			var index = _get_tile_index(noise)
			$TileMap.set_cell(x, y, index)

func _get_tile_index(noise_sample):
	noise_sample = (noise_sample+1)/2.0*(TILES.size()+1)
	noise_sample = round(noise_sample)
	return noise_sample
