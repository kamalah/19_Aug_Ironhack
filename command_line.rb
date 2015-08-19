class CommandLine
	def initialize
		@hard_password = "1234"
		@user_name = "Alex"
		@correct = false
		@enter_user =""
		@enter_password = ""
	end

	def get_entry
		print "Enter User name: "
		@enter_user = gets.chomp

		print "Enter password: "
		@enter_password = gets.chomp
	end

	def check_entry
		if (@enter_user == @user_name && @enter_password == @hard_password)
			@correct = true
		else
			@correct = false
		end
	end

	def get_text
		if @correct
			puts "\nCorrect password entered!"
			print "Please enter text: "
			text = gets.chomp
			text_array = text.split
			puts "There are #{text_array.length} words."
		else
			puts "Wrong user name or password."
		end
	end
end


my_command = CommandLine.new
my_command.get_entry
my_command.check_entry
my_command.get_text
