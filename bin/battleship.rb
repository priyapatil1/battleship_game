#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'data_table'
require 'curses'

grid = Grid.new(2,2,["E","E","E","E","E","E","E","E","E"]).place_ship(2)
COLUMNS = ['1','2','3']
ROWS = ['A','B','C']

Table.new(Kernel,Kernel,ROWS,COLUMNS,3,grid).start

