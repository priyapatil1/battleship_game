require 'data_table'

describe Grid do 
  let(:input) {StringIO.new('A2')}
  let(:output) {StringIO.new('')}
  let(:coordinates) {['∙','◦','∙','∙']}
  let(:grid) {Battleship.new(2,2,["E","E","E","E"]).place_ship(1)}
  let(:table) {output.string.split("\n")}

  describe 'two by two grid' do
    COLUMNS = ['1','2']
    ROWS = ['A','B']

    it 'creates the table with coordinates' do 
      Grid.new(input,output,ROWS,COLUMNS,2,grid).display_table(coordinates)
      expect(table[0]).to include("1","2")
      expect(table[1]).to include("A")
    end

    it 'asks the user to guess a coordinate' do 
      Grid.new(input,output,ROWS,COLUMNS,2,grid).start
      expect(table[0]).to include("Guess a coordinate")
      expect(table[1]).to include("1")
    end

    it 'creates a table with y axis letters' do 
      Grid.new(input,output,ROWS,COLUMNS,2,grid).display_table(['∙'])
      expect(table[0]).to include("1","2")
      expect(table[1]).to include("A")
    end

    it 'creates a table with x axis numbers' do 
      Grid.new(input,output,ROWS,COLUMNS,2,grid).display_table(['∙'])
      expect(table[0]).to include("1","2")
      expect(table[1]).to include("∙")
    end

    it 'takes a 1d array and outputs a 2 by 2 grid' do 
      Grid.new(input,output,ROWS,COLUMNS,2,grid).display_table(coordinates)
      expect(table[0]).to include("1","2")
      expect(table[2]).to include("∙")
    end

    it 'displays an updated grid once a player has made a guess' do 
      grid = Battleship.new(2,2,["E","E","E","E"]).place_ship(1)
      Grid.new(input,output,ROWS,COLUMNS,2,grid).start
      expect(table[1]).to include("1","2")
      expect(table[2]).to include("∙")
    end
  end

  describe 'three by three grid' do 
    rows = ['A','B','C']
    columns = ['1','2','3']

    it 'displays an empty 3 by 3 grid' do 
      grid = Battleship.new(3,3,["E","E","E","E","E","E","E","E","E"]).place_ship(1)
      Grid.new(input,output,rows,columns,2,grid).display_table(grid)
      expect(table[0]).to include("1","2","3")
      expect(table[1]).to include("A\t")
      expect(table[2]).to include("B\t")
      expect(table[3]).to include("C\t")
    end
  end
end

