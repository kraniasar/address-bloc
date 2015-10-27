require_relative '../models/address_book'

 class MenuController
   attr_accessor :address_book

   def initialize
     @address_book = AddressBook.new
   end

   def main_menu
 # #2
     puts "Main Menu - #{@address_book.entries.count} entries"
     puts "1 - View all entries"
     puts "2 - Create an entry"
     puts "3 - Search for an entry"
     puts "4 - Import entries from a CSV"
     puts "5 - View Entry Number n"
     puts "6 - Nuke all entries"
     puts "7 - Exit"
     print "Enter your selection: "

 # #3
     selection = gets.to_i
     puts "You picked #{selection}"

    case selection
    when 1
       system "clear"
       view_all_entries
       main_menu
    when 2
      system "clear"
      create_entry
      main_menu
    when 3
      system "clear"
      search_entries
      main_menu
    when 4
      system "clear"
      read_csv
      main_menu
    when 5
      system "clear"
      entry_n_submenu
      main_menu
    when 6
      system "clear"
      @address_book.nuke
      puts "All entries deleted"
      main_menu
    when 7
      puts "Good-bye!"
    # #8
      exit(0)
    # #9
    else
      system "clear"
      puts "Sorry, that is not a valid input"
      main_menu
    end
  end

  def entry_n_submenu
    print "Entry number to view: "
    selection = gets.chomp.to_i

    if selection < @address_book.entries.count
      puts @address_book.entries[selection]
      puts "Press enter to return to the main menu"
      gets.chomp
      system "clear"
    else
      puts "#{{selection}} is not a valid input"
      entry_n_submenu
  end

  def view_all_entries
    @address_book.entries.each do |entry|
    system "clear"
    puts entry.to_s
    entry_submenu(entry)
  end

  def entry_submenu(entry)
   puts "\nn - next entry"
   puts "d - delete entry"
   puts "e - edit this entry"
   puts "m - return to main menu"

   selection = $stdin.gets.chomp

   case selection
   when "n"
   when "d"
 # #7
    delete_entry(entry)
   when "e"
 # #8
     edit_entry(entry)
     entry_submenu(entry)
   when "m"
     system "clear"
     main_menu
   else
     system "clear"
     puts "#{selection} is not a valid input"
     entry_submenu(entry)
   end
 end

    system "clear"
    puts "End of entries"
  end

      def create_entry
      end

      def search_entries
        print "Search by name: "
     name = gets.chomp
 # #10
     match = @address_book.binary_search(name)
     system "clear"
 # #11
     if match
       puts match.to_s
       search_submenu(match)
     else
       puts "No match found for #{name}"
     end
    end

      def read_cs
 # #1
     print "Enter CSV file to import: "
     file_name = gets.chomp

 # #2
     if file_name.empty?
       system "clear"
       puts "No CSV file read"
       main_menu
     end

 # #3
     begin
       entry_count = @address_book.import_from_csv(file_name).count
       system "clear"
       puts "#{entry_count} new entries added from #{file_name}"
     rescue
       puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
       read_csv
     end
   end

   def delete_entry(entry)
     @address_book.entries.delete(entry)
     puts "#{entry.name} has been deleted"
   end

   def edit_entry(entry)
 # #4
     print "Updated name: "
     name = gets.chomp
     print "Updated phone number: "
     phone_number = gets.chomp
     print "Updated email: "
     email = gets.chomp
 # #5
     entry.name = name if !name.empty?
     entry.phone_number = phone_number if !phone_number.empty?
     entry.email = email if !email.empty?
     system "clear"
 # #6
     puts "Updated entry:"
     puts entry
   end

 end
end
