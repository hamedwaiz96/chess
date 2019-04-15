require_relative "piece"

class Board
	attr_reader :rows
	def initialize
		rows = Array.new(8) {Array.new(8)}
		@rows = rows
		x = 0
		k = 0
		while x <= 7
			while k <= 7
				if x == 0 || x == 1 || x == 6 || x == 7
					@rows[x][k] = Piece.new
				else
					@rows[x][k] = nil
				end
				k += 1
			end
			k = 0
			x += 1
		end
		@sentinel = NullPiece.new
	end

	def [](pos)
		row, col = pos
		@rows[row][col]
	end

	def []=(pos, value)
		row, col = pos
		@rows[row][col] = value
	end

	def move_piece(start_pos, end_pos)
		row1, col1 = start_pos
		row2, col2 = end_pos
		raise ArgumentError.new("no piece at start") if @rows[row1][col1] == nil
		raise ArgumentError.new("end_pos has piece on it") if @rows[row2][col2].is_a?(Piece) == true
		a = @rows[row1].delete_at(col1)
		b = @rows[row2].delete_at(col2)
		@rows[row1][col1] = b
		@rows[row2][col2] = a
	end

	def valid_pos?(pos)
		row, col = pos
		if row > 7 || row < 0 || col > 7 || col < 0
			return false
		else
			return true
		end
	end

end

