
// settings
grid_size_x = 8;
grid_size_y = 8;
cell_size = 16;
cell_padding = 3;
cell_sprite = spr_cell_types;

// mechanical
game_grid = ds_grid_create(grid_size_x,grid_size_y)
cell_type_count = sprite_get_number(cell_sprite);

// set random initial grid
for (var yy = 0; yy < ds_grid_height(game_grid); yy++) {
  for (var xx = 0; xx < ds_grid_width(game_grid); xx++) {
    ds_grid_set(game_grid,xx,yy,irandom(cell_type_count-2)+1);
  }
}
