class Map
  attr_reader :layout

  def initialize(layout)
    @layout = layout
  end

  def current_guard_position
    layout.each_with_index do |row, x|
      row.each_with_index do |tile, y|
        return [y, x] if tile == ?^
      end
    end
  end

  def current_guard_direction
    case tile_at(*current_guard_position)
    when ?^ then :up
    when ?v then :down
    when ?> then :right
    when ?< then :left
    end
  end

  def set_tile(x, y, tile)
    layout[y][x] = tile
  end

  def obstacle?(x, y)
    tile_at(x, y) == ?#
  end

  def visited?(x, y)
    tile_at(x, y) == ?X
  end

  def out_of_bounds?(x, y)
    x < 0 || y < 0 || y >= layout.size || x >= layout.first.size
  end

  private

  def tile_at(x, y)
    @layout.fetch(y, []).fetch(x, nil)
  end
end
