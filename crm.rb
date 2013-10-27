require_relative "contact"
require_relative "rolodex"


class CRM
	attr_accessor :name

	def initialize(name)
		@name = name
	end

	def main_menu
		#clear
		print_main_menu
		user_selected = gets.to_i 	#option user selected 1..7
		#---------------------------------------------
		call_option(user_selected)

		# begin
		# 	call_option(user_selected)
		# rescue
		# 	puts "Oops, Wrong option! Please try again:"
		# 	puts "\n"
		# 	print_main_menu
		# end
		#---------------------------------------------
	end 

	def print_main_menu
		puts "[1] Add a new contact"
		puts "[2] Modify an existing contact "
		puts "[3] Delete a contact"
		puts "[4] Display a contact"
		puts "[5] Display an attribute"
		puts "[6] Display all contacts"
		puts "[7] Exit"
		puts "Enter a number: "
	end


	def call_option(user_selected)

		case user_selected
		when 1
			add_new_contact
		when 2
			modify_existing_contact 	# read up on raising & rescuing errors
		when 3 
			delete_contact
		when 4 
			display_contact
		when 5
			display_attribute
		when 6
			display_all_contacts
		when 7
			exit
		else
			raise
		end
	end

	def add_new_contact
		clear
		puts "----- Creating New User ------"
		print "Enter First Name: "
		first_name = gets.chomp
		print "Enter Last Name: "
		last_name = gets.chomp
		print "Enter Email Address: "
		email = gets.chomp
		print "Enter a Note: "
		note = gets.chomp
		contact = Contact.new(first_name, last_name, email, note)
		Rolodex.add_contact(contact)
		line
		puts "Registration successful!"
		line
		enter
		line
		main_menu
	end

	def modify_existing_contact
		contact_selected = get_contacts("modify")

		puts "Select 1 to 4 to modify:"
		puts "[1] First name, [2] Last name, [3], Email [4] Note, [5] Id"
		attr_select = gets.chomp.to_i

		case attr_select
		when 1
			puts "Changing First Name to?"
			contact_selected.first_name = gets.chomp
		when 2
			puts "Changing Last Name to?"
			contact_selected.last_name = gets.chomp
		when 3
			puts "Changing Email to?"
			contact_selected.email = gets.chomp
		when 4
			puts "Changing Note to?"
			contact_selected.note = gets.chomp
		when 5
			puts "Changing Id to?"
			contact_selected.id = gets.chomp
		end

		clear
		main_menu
	end	


	def delete_contact
		contact_selected = get_contacts("delete")
		puts "Are you sure you would like to delete #{contact_selected.id}"
		puts "Please Type: [YES] to delete or [NO] to start again"
		attr_select = gets.chomp.downcase					# gets.chomp is string by default so no need for to_str

		case attr_select									# could also be written as a ternary eg. attr_select == "yes" ? "true" : "false"
		when "yes" 
			puts "Contact #{contact_selected.id} has been succesfully deleted!"
			index_of_contact_selected = Rolodex.contacts.index(contact_selected)
			# puts "Index of Contact Selected #{index_of_contact_selected}"			 <- trouble shooting code
			Rolodex.contacts.delete_at(index_of_contact_selected)					# delete_at is ruby code to delete an array

		else "no"
		end
		enter
		main_menu	
	end
			
	def get_contacts(modify_delete_view)
		clear 
		Rolodex.display_all_contacts
		puts "Please select the contact you would like to #{modify_delete_view}:"
		contact_select = gets.chomp.to_i
		contact_selected = retrieve_contact(contact_select -1) 
		clear

		puts "the contact retrieved is:"
		line
		puts "First Name: #{contact_selected.first_name}"
		puts "Last Name: #{contact_selected.last_name}"
		puts "Email: #{contact_selected.email}"
		puts "Note: #{contact_selected.note}"
		puts "Id: #{contact_selected.id}"
		line
		return contact_selected
	end


	def retrieve_contact(contact_selected)
		Rolodex.contacts[contact_selected]
	end

		

	def display_contact
		contact_selected = get_contacts("view")
		enter
		main_menu
	end

	def display_attribute
		puts "Display an Attribute"
	end

	def display_all_contacts
		clear
		puts "List of Contacts:"
		line
		Rolodex.display_all_contacts
		enter
		line
		main_menu
	end

	def exit
		clear
		line
		puts "Exiting! Thanks for using Moin's CRM!"
		line
	end

	def greeting
		puts "Hello, welcome to #{@name} CRM App!"
	end

	def clear
	puts "\e[H\e[2J"
	end

	def line
		puts "---------------------------------"
	end


	def populate_contacts

		Rolodex.add_contact(Contact.new("this is first name", "this is last name", "this is email", "this is a note"))

		Rolodex.add_contact(Contact.new("thisewvweve", "this evwer", "thierbverl", "this isewrbverberote"))

		Rolodex.add_contact(Contact.new("thiswwwwwwwweve", "teeeeeeeeer", "thhhhhhhl", "this isewnnnnnnnnne"))
	end


	def enter
		puts "Press ENTER to continue"
		gets
		clear
		puts "Start a new task?"
	end
end

# Creating new instance of CRM

my_crm_app = CRM.new("Moin's")


# Method calls to start CRM App
my_crm_app.clear
my_crm_app.populate_contacts
my_crm_app.greeting
my_crm_app.line
my_crm_app.main_menu

#Troubleshooting code

p Rolodex.contacts







