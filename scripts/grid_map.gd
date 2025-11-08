extends GridMap


func destroy_block(world_coordinate):
	#print("Hit:", self)
	#print("Parent:", self.get_parent_node_3d())
	var local_pos = to_local(world_coordinate)
	var map_coordinate = local_to_map(local_pos)
	set_cell_item(map_coordinate, -1)
	
func place_block(world_coordinate, block_idx):
	var local_pos = to_local(world_coordinate)
	var map_coordinate = local_to_map(local_pos)
	set_cell_item(map_coordinate, block_idx)
	
