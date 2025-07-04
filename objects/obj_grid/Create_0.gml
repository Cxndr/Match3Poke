
// settings
grid_size_x = 8;
grid_size_y = 8;
cell_size = 16;
cell_padding = 3;
cell_sprite = spr_cell_types;
drag_switch_threshold = 5;

// mechanical
game_grid = ds_grid_create(grid_size_x,grid_size_y)
cell_type_count = sprite_get_number(cell_sprite);
grid_x = x;
grid_y = y;
grid_w = (grid_size_x * (cell_size + cell_padding)) + cell_padding;
grid_h = (grid_size_y * (cell_size + cell_padding)) + cell_padding;
dragging_cell = null;
dragging_cell_x = null;
dragging_cell_y = null;
dragging_cell_initial_x = null;
dragging_cell_initial_y = null;
swapping_cell = null;

// cells
enum CELL_TYPE {
  NONE,
  FIRE,
  WATER,
  GRASS,
  SPEC1,
  SPEC2,
  SPEC3,
  SPEC4
}
enum CELL_STATE {
  IDLE,
  SWITCHING,
  FALLING,
  EXPLODING
}

function grid_cell(_type = 0) constructor {
  type = _type;
  state = CELL_STATE.IDLE;
  dragging = false;
  swapping = false;
}

function check_for_match(_type, _pos_x, _pos_y) {
  
  // check left
  if (_pos_x - 1 > 0) {
    if ds_grid_get(game_grid, _pos_x-1, _pos_y).type == _type {
      if ds_grid_get(game_grid, _pos_x-2, _pos_y).type == _type {
        return true;
      }
    }
  }
  
  // check up
  if (_pos_y - 1 > 0) {
    if ds_grid_get(game_grid, _pos_x, _pos_y-1).type == _type {
      if ds_grid_get(game_grid, _pos_x, _pos_y-2).type == _type {
        return true;
      }
    }
  }
  
  return false;
}

// set random initial grid
for (var yy = 0; yy < ds_grid_height(game_grid); yy++) {
  for (var xx = 0; xx < ds_grid_width(game_grid); xx++) {
    
    var _assigned_type = irandom(cell_type_count-2)+1
    
    var _attempts = 0;
    var _max_attempts = cell_type_count * 2;
    while (check_for_match(_assigned_type,xx,yy) && _attempts < _max_attempts) {
      _assigned_type += 1
      if (_assigned_type > cell_type_count-1) { _assigned_type = 1 }
      _attempts++
    }
    
    ds_grid_set(
      game_grid,xx,yy,
      new grid_cell(_assigned_type)
    );
  }
}

function swap_grid_cells(grid, x1, y1, x2, y2) {
    // Bounds checking
    if (x1 < 0 || x1 >= ds_grid_width(grid) || y1 < 0 || y1 >= ds_grid_height(grid) ||
        x2 < 0 || x2 >= ds_grid_width(grid) || y2 < 0 || y2 >= ds_grid_height(grid)) {
        show_debug_message("Invalid grid coordinates for swap");
        return false;
    }
    
    // Perform the swap
    var temp = ds_grid_get(grid, x1, y1);
    ds_grid_set(grid, x1, y1, ds_grid_get(grid, x2, y2));
    ds_grid_set(grid, x2, y2, temp);
    
    return true;
}
