require 'terminfo'
require 'io/console'

class Slides
	attr_accessor :all_slides
	def initialize
		@all_slides =[]

	end

	def get_slides(file_name)
		IO.foreach(file_name) do |line|
			if line.strip != "----"
				@all_slides<<line
			end
		end	
	end

	def send_slide(ind)
		@all_slides[ind]
	end

	def number_slides
		@all_slides.length
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
		size = TermInfo.screen_size
		(size[0]/2).times do
			puts "\n"
			end
		spaces = (size[1] - (@slides.send_slide(ind).length))/2
		spaces.times do
			print " "
			end
				puts @slides.send_slide(ind)
		(size[0]/2).times do
			puts "\n"
			end
	end
end


my_slides = Slides.new

my_slides.get_slides("slides.txt")

my_presentation = Presentation.new(my_slides)

my_presentation.start_show
while (my_presentation.location != -1)
	my_presentation.check_input
end

#Presentation.new.make_presentation(my_slides)