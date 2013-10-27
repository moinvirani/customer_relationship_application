require_relative "contact"

class Rolodex
  @contacts = []		 # Class method - not avaialble at every method but only at the class level
  @id = 1000


  def self.contacts
    @contacts
  end

  def self.get_current_id
    @id
  end

  def self.add_contact(contact) 	# self.xyz defines it as a class method
    contact.id = @id
    @contacts << contact    # << is the push command, inserts info in array
    puts contact.id			    # class methods only work in classes!!!
    @id += 1
  end


  def self.display_all_contacts
    @contacts.each do |contact|
      puts "[#{contact.id}]"
      puts "First Name: #{contact.first_name}"
      puts "Last Name: #{contact.last_name}"
      puts "Email: #{contact.email}"
      puts "Note: #{contact.note}"
      puts "------------------------"
    end
  end
  
end
