
// get initially clicked tile
if (mouse_check_button(mb_left)) {
  
  if (mouse_x < grid_x or mouse_x > (grid_x + grid_w) ) return;
  if (mouse_y < grid_y or mouse_y > (grid_y + grid_h) ) return;
  if (dragging_cell = true) return;
  
  var _grid_click_x;
  var _grid_click_y;
  
  _grid_click_x = floor( (mouse_x - grid_x) / (cell_size + cell_padding) );
  _grid_click_y = floor( (mouse_y - grid_y) / (cell_size + cell_padding) );
  
  var _clicked_cell = ds_grid_get(game_grid,_grid_click_x,_grid_click_y);
  
  for (var yy = 0; yy < ds_grid_height(game_grid); yy++) {
    for (var xx = 0; xx < ds_grid_width(game_grid); xx++) {
      var _curr_cell = ds_grid_get(game_grid,xx,yy)
      if (_curr_cell = _clicked_cell) _curr_cell.dragging = true;
      else _curr_cell.dragging = false;
    }
  }
  
  dragging_cell = _clicked_cell;
  dragging_cell_x = _grid_click_x;
  dragging_cell_y = _grid_click_y;
  
  dragging_cell_initial_x = mouse_x;
  dragging_cell_initial_y = mouse_y;
  
}
else {
  
  for (var yy = 0; yy < ds_grid_height(game_grid); yy++) {
    for (var xx = 0; xx < ds_grid_width(game_grid); xx++) {
      var _curr_cell = ds_grid_get(game_grid,xx,yy)
      _curr_cell.dragging = false;
    }
  }
  
  dragging_cell = null;
  dragging_cell_x = null;
  dragging_cell_y = null;
  
  dragging_cell_initial_x = null;
  dragging_cell_initial_y = null;
  
}

if (dragging_cell) {
  
  var _swapping_cell_x;
  var _swapping_cell_y;
  
  // up
  if (
    dragging_cell_initial_y - mouse_y > drag_switch_threshold 
    and dragging_cell_y > 0
  ) {
    _swapping_cell_x = dragging_cell_x;
    _swapping_cell_y = dragging_cell_y-1;
    swapping_cell = ds_grid_get(
      game_grid, _swapping_cell_x, _swapping_cell_y
    )
  }
  
  // down
  if (
    mouse_y - dragging_cell_initial_y > drag_switch_threshold 
    and dragging_cell_y > grid_size_y
  ) {
    _swapping_cell_x = dragging_cell_x;
    _swapping_cell_y = dragging_cell_y+1;
    swapping_cell = ds_grid_get(
      game_grid, _swapping_cell_x, _swapping_cell_y
    )
  }
  
  // left
  if (
    dragging_cell_initial_x - mouse_x > drag_switch_threshold 
    and dragging_cell_x > grid_size_x
  ) {
    _swapping_cell_x = dragging_cell_x-1;
    _swapping_cell_y = dragging_cell_y;
    swapping_cell = ds_grid_get(
      game_grid, _swapping_cell_x, _swapping_cell_y
    )
  }
  
  // right
  if (
    mouse_x - dragging_cell_initial_x > drag_switch_threshold 
    and dragging_cell_x > grid_size_x
  ) {
    _swapping_cell_x = dragging_cell_x+1;
    _swapping_cell_y = dragging_cell_y;
    swapping_cell = ds_grid_get(
      game_grid, _swapping_cell_x, _swapping_cell_y
    )
  }
  
  // exeute swap
  if (swapping_cell) {
    swap_grid_cells(
      game_grid, 
      dragging_cell_x, 
      dragging_cell_y, 
      _swapping_cell_x,
      _swapping_cell_y
    )
  }
  
}
else {
  swapping_cell = null;
}

