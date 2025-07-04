
var pos_value;
for (var yy = 0; yy < ds_grid_height(game_grid); yy++) {
  for (var xx = 0; xx < ds_grid_width(game_grid); xx++) {
    
    pos_value = ds_grid_get(game_grid,xx,yy).type;
    var padding_x = xx * cell_padding;
    var padding_y = yy * cell_padding;
    
    draw_sprite(
      cell_sprite,
      pos_value, 
      x + (xx * cell_size + padding_x), 
      y + (yy * cell_size + padding_y)
    );
    
  }
}
