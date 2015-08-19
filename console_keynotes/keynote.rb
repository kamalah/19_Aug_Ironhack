require 'terminfo'
require 'io/console'
require 'pry'

class Slides
	attr_accessor :all_slides
	def initialize
		@all_slides =[""]
		@size = TermInfo.screen_size
	end

	def get_slides(file_name)
		index = 0
		IO.foreach(file_name) do |line|
			if line.strip != "----"
				@all_slides[index]<<line
			else
				index += 1
				@all_slides[index] = ""
			end
		end	
	end

	def send_slide(ind)
		@all_slides[ind]
	end

	def number_slides
		@all_slides.length
	end

	def show_slide(ind)
		slide = @all_slides[ind]
		center_vertical(slide)
		find_endl = 0
		print_slide = slide

		while(find_endl <print_slide.length) #print line by line
			center_right(slide)
			find_endl = print_slide.index("\n")
			puts print_slide[0..find_endl]
			print_slide = print_slide[find_endl+1..print_slide.length]
		end
		center_vertical(slide)	
	end

	def center_vertical(slide)
		above_lines = (@size[0] - slide.count("\n"))/2
		above_lines.times do
			puts "\n"
			end
	end

	def center_right(slide)
		spaces = (@size[1] - slide.index("\n"))/2
		spaces.times do
			print " "
			end
	end

end

class Presentation
	attr_reader :location

	def initialize(slides)
		@slides = slides
		@location = 0
		
	end

	def start_show
		show_slide(0)
		while @location !=-1
			check_input
		end
	end

	def check_input
		print "> "
		input = gets.chomp
		input = input.strip.downcase

		case input
			when "next"
				next_slide		
			when "previous"
				previous_slide
			when "exit"
				@location = -1
			when "auto"
				run_auto
			else
				puts "invalid entry"
		end

	end

	def next_slide
		if @location < (@slides.number_slides-1)
			@location += 1
			show_slide(@location)
		end
	end

	def previous_slide
		if @location > 0
			@location -= 1
			show_slide(@location)
		end
	end

	def run_auto
		while (next_slide)
			sleep(3)
		end
		@location =-1
	end


	def show_slide (ind)
		system "clear"
		@slides.show_slide(ind)
	end

	
end


my_slides = Slides.new

my_slides.get_slides("slides2.txt")

my_presentation = Presentation.new(my_slides)
my_presentation.start_show


