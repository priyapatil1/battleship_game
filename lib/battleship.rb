class Battleship
  EMPTY = "E"
  MISS = "M"
  HIT = "H"
  SHIP = "S"
  attr_accessor :rows, :columns
  attr_reader :cells

  def initialize(cells,row_label,column_label)
    @cells = cells
    @row_label = row_label
    @column_label = column_label
  end

  def self.generate_grid(size)
    grid = []
    (0..size - 1). each do |cell|
      rand = [EMPTY,SHIP].sample
      grid << rand
    end
    grid
  end

  def place_ship(grid)
    @cells[grid] = SHIP
    @cells
  end

  def target(guess)
    index = guess.split(//)[1].to_i - 1
    letter = guess.split(//)[0]
      if letter == @row_label[1] 
        index += index + @column_label.length - 1
      end
      if @cells[index] != SHIP 
        @cells[index] = MISS
      else @cells[index] == SHIP
        @cells[index] = HIT
      end
    @cells
  end
end

