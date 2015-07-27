require 'grid'

describe Game  do 
  EMPTY = "E"
  MISS = "M"
  HIT = "H"
  SHIP = "S"
  DESTROYER = "D"
  SUBMARINE = "SUB"

  describe '#place_ship and place_destroyer' do 
    initial_grid = [EMPTY,EMPTY,EMPTY,EMPTY]
    grid_ship_placed = [EMPTY,EMPTY,SHIP,EMPTY]

    let(:row_label) {['A','B']}
    let(:column_label) {['1','2']}
    let(:input) {StringIO.new('A1')}

    it 'has 0 rows and 0 columns' do 
      expect(Game.new(input,initial_grid,row_label,column_label).cells).to eq(initial_grid)
    end

    it 'has empty 2 rows and 2 columns' do 
      expect(Game.new(input,initial_grid,row_label,column_label).cells).to eq(initial_grid)
    end

    it 'has 1 ship as a coordinate' do 
      expect(Game.new(input,initial_grid,row_label,column_label).place_ship(2)).to eq(grid_ship_placed)
    end

    it 'has 1 destroyer as two horizontal coordinates' do
      initial_grid = [EMPTY,EMPTY,EMPTY,EMPTY]
      grid_ship_placed = [DESTROYER,DESTROYER,EMPTY,EMPTY]
      expect(Game.new(input,initial_grid,row_label,column_label).place_destroyer(0)).to eq(grid_ship_placed)
    end

    it 'has 1 submarine as three horizontal coordinates' do 
      initial_grid = [EMPTY,EMPTY,EMPTY,EMPTY]
      grid_ship_placed = [SUBMARINE,SUBMARINE,SUBMARINE,EMPTY]
      expect(Game.new(input,initial_grid,row_label,column_label).place_submarine(0)).to eq(grid_ship_placed)
    end

    describe '#target' do 
      let(:row_label) {['A','B']}
      let(:column_label) {['1','2']}
      let(:input) {StringIO.new('A2')}

      it 'changes an empty coordinate to a miss' do
        initial_grid = ["E","E","E","E"]
        input = StringIO.new('A1')
        ship_placed = (Game.new(input,initial_grid,row_label,column_label).place_ship(1))
        expect(Game.new(input,ship_placed,row_label,column_label).target(0)).to eq(["◦", "∙", "∙", "∙"])
      end

      it 'changes a coordinate in the first row with a ship to a hit' do 
        input = StringIO.new('A2')
        initial_grid = ["E","S","E","E"]
        ship_placed = (Game.new(input,initial_grid,row_label,column_label).place_ship(1))
        expect(Game.new(input,initial_grid,row_label,column_label).target(1)).to eq(["∙", "HIT", "∙", "∙"])
      end

      it 'changes a coordinate with a ship in second row hit' do 
        input = StringIO.new('B1')
        initial_grid = ["E","E","E","E"]
        ship_placed = (Game.new(input,initial_grid,row_label,column_label).place_ship(3))
        expect(Game.new(input,ship_placed,row_label,column_label).target(3)).to eq(["∙", "∙", "∙", "HIT"])
      end

      it 'changes a coordinate with a ship in the third row hit' do 
        row_label = ['A','B','C']
        column_label = ['1','2','3']
        initial_grid = ["E","E","E","E","E","E","E","E","E"]
        ship_placed = (Game.new(input,initial_grid,row_label,column_label).place_ship(3))
        expect(Game.new(input,ship_placed,row_label,column_label).target(4)).to eq(["∙", "∙", "∙", "∙", "◦", "∙", "∙", "∙", "∙"])
        expect(Game.new(input,ship_placed,row_label,column_label).target(7)).to eq(["∙", "∙", "∙", "∙", "◦", "∙", "∙", "◦", "∙"])

      end

      it 'changes a coordinate when a destroyer is hit' do 
        initial_grid = ["E","E","E","E"]
        ship_placed = (Game.new(input,initial_grid,row_label,column_label).place_destroyer(1))
        expect(Game.new(input,ship_placed,row_label,column_label).target(1)).to eq(["∙", "HD", "∙", "∙"])
        expect(Game.new(input,ship_placed,row_label,column_label).target(0)).to eq(["◦", "HD", "∙", "∙"])
      end

      it 'changes a coordinate when a submarine is hit' do 
        initial_grid = ["E","E","E","E"]
        ship_placed = (Game.new(input,initial_grid,row_label,column_label).place_submarine(0))
        expect(Game.new(input,ship_placed,row_label,column_label).target(0)).to eq(["HS", "∙", "∙", "∙"])
        expect(Game.new(input,ship_placed,row_label,column_label).target(1)).to eq(["HS", "HS", "∙", "∙"])
        expect(Game.new(input,ship_placed,row_label,column_label).target(2)).to eq(["HS", "HS", "HS", "∙"])
      end

      it 'changes ship and empty letters to empty icons that can be shown in the display before a guess is made' do 
        initial_grid = ["E","E","E","E","E","E","E","E","E"]
        input = StringIO.new('A1')
        initial = Game.new(input,initial_grid,row_label,column_label)
        result = initial.place_ship(1)
        expect(initial.player_one_move(result)).to eq(["∙","∙","∙","∙","∙","∙","∙","∙","∙"])
      end

      it 'changes icon to hit once a player makes a guess' do 
        initial_grid = ["E","E","E","E","E","E","E","E","E"]
        input = StringIO.new('A2')
        new_game =  Game.new(input,initial_grid,row_label,column_label)
        new_game.place_ship(1)
        result = new_game.target(1)
        expect(result).to eq(["∙","HIT","∙","∙","∙","∙","∙","∙","∙"])
      end
    end

    describe '#generate_grid and #generate empty grid' do
      it 'generates 4 random cells' do 
        grid = Game.generate_grid(4) 
        expect(grid.size).to eq(4)
      end

      it 'generates 10 random cells' do 
        grid = Game.generate_grid(10) 
        expect(grid.size).to eq(10)
      end

      it "auto genetares an empty grid if one isn't supplied" do
        ROWS= ['A','B','C']
        COLUMNS = ['1','2','3']
        input = StringIO.new('A1')
        expect(Game.generate_empty_cells(ROWS,COLUMNS)).to eq(["E","E","E","E","E","E","E","E","E"])
      end
    end
  end
end