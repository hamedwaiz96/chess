require_relative "board"
require "colorize"
require_relative "cursor"

class Display 
attr_reader :board, :cursor
	def initialize(board)
		@board = board
		@cursor = Cursor.new([0, 0], @board)
	end

	def build_grid
		@board.rows.map.with_index do |row, i|
			build_row(row, i)
		end
	end

	def build_row(row, i)
		row.map.with_index do |piece, j|
			color_options = colors_for(i, j)
			piece.to_s.colorize(color_options)
		end
	end

	def colors_for(i, j)
		if cursor.cursor_pos == [i, j]
			bg = :light_green
		elsif (i + j).odd?
			bg = :light_blue
		else
			bg = :light_yellow
		end
		{background: bg}
	end


	def render
		system("clear")
		build_grid.each {|row| puts row.join}
	end

	def play
		i = 0
		until i != 0
			self.render
			@cursor.get_input
		end
	end

end