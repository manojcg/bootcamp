class Pair
	attr_accessor :first
	attr_accessor :second
	def initialize(first, second)
		@first = first
		@second = second
	end
end

class Maze
	attr_accessor :mazeconfig
	def initialize(mazeconfigstr)
		numcol = mazeconfigstr.index("\n")
		numrow = mazeconfigstr.length / (numcol + 1) + 1
		#Instance variables to be used by the methods
		@solved = false
		@solvable = false
		@steps = 0
		@startpos = Pair.new(-1, -1)
		@mazedimen = Pair.new(numrow, numcol)
		@mazeconfig = Array.new(numrow) { Array.new(numcol) }
		row_index = 0
		col_index = 0
		mazeconfigstr.each_char do |chr|
			if chr == "\n"
				row_index += 1
				col_index = 0
			else
				@mazeconfig[row_index][col_index] = chr
				@startpos = Pair.new(row_index,col_index) if chr == "A"
				col_index += 1	
			end
		end
	end

	def solvable?
		@solvable = solve_maze(@startpos.first, @startpos.second)
		@solvable
	end

	def steps
		
	end

	private

	def solve_maze(x, y)
		return false if x < 0 || x > @mazedimen.first || y < 0 ||  y > @mazedimen.second
				
		return true if @mazeconfig[x][y] == "B"

		return false if @mazeconfig[x][y] == "#" || @mazeconfig[x][y] == "+"
		storedval = @mazeconfig[x][y] 
		@mazeconfig[x][y] = "+"
		return true if solve_maze(x - 1, y) == true
		return true if solve_maze(x + 1, y) == true
		return true if solve_maze(x, y - 1) == true
		return true if solve_maze(x, y + 1) == true
		@mazeconfig[x][y] = storedval
		return false
	end
end
