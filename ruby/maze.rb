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
		solve_helper
		@solvable
	end

	def steps
		solve_helper
		@steps
	end

	private

	def solve_helper
		@steps = solve_maze(@startpos.first, @startpos.second) - 1 unless @solved
		@solved = true
		@steps = 0 if @steps < 0
		@solvable = true if @steps > 0
	end

	def solve_maze(x, y)
		return -1 if x < 0 || x > @mazedimen.first || y < 0 ||  y > @mazedimen.second
				
		return 1 if @mazeconfig[x][y] == "B"

		return -1 if @mazeconfig[x][y] == "#" || @mazeconfig[x][y] == "+"

		storedval = @mazeconfig[x][y] 
		@mazeconfig[x][y] = "+"
		validpath = Array.new(0)
		north = solve_maze(x - 1, y)
		validpath << north if north > 0
		south = solve_maze(x + 1, y)
		validpath << south if south > 0
		west = solve_maze(x, y - 1)
		validpath << west if west> 0
		east = solve_maze(x, y + 1)
		validpath << east if east > 0
		minval = validpath.min
		@mazeconfig[x][y] = storedval
		return 1 + minval if !minval.nil? && minval > 0
		return -1
	end
end
