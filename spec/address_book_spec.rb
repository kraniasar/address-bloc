require_relative '../models/address_book'

RSpec.describe AddressBook do
 let(:book) { AddressBook.new}

 def check_entry(entry, expected_name, expected_number, expected_email)
  expect(entry.name).to eql expected_name
  expect(entry.phone_number).to eql expected_number
  expect(entry.email).to eql expected_email
 end

 describe "#nuke" do
   it "should delete all entries" do
     book.add_entry("Ada Lovelace", "010.012.1815", "augusta.king@lovelace.com")
     book.add_entry("Ada Lovelace", "010.012.1815", "augusta.king@lovelace.com")
     book.add_entry("Ada Lovelace", "010.012.1815", "augusta.king@lovelace.com")

     book.nuke
     expect(book.entries.size).to eq 0
   end
 end


   describe "attributes" do
    it "should respond to entries" do
      book = AddressBook.new
      expect(book).to respond_to(:entries)
    end

    it "should initialize entries as an array" do
      book = AddressBook.new
      expect(book.entries).to be_a(Array)
    end

    it "should initialize entries as empty" do
      book = AddressBook.new
      expect(book.entries.size).to eq(0)
    end
  end

  describe "#add_entry" do
    it "adds only one entry to the address book" do
      book = AddressBook.new
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      expect(book.entries.size).to eq(1)
    end
  end

  describe "#remove_entry" do
    it "removes an entry using name, phone_number, and email" do
      book = AddressBook.new
      book.add_entry('Clark Kent', '555.555.5555', 'superman@gmail.com')
      book.remove_entry('Clark Kent', '555.555.5555', 'superman@gmail.com')

      expect(book.entries.size).to eq 0
    end
  end

  it "adds the correct information to entries" do
    book = AddressBook.new
    book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
    new_entry = book.entries[0]

    expect(new_entry.name).to eq ('Ada Lovelace')
    expect(new_entry.phone_number).to eq('010.012.1815')
    expect(new_entry.email).to eq('augusta.king@lovelace.com')
  end

    describe "#iterative_search" do
    it "searches AddressBook for a non-existent entry" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Dan")
      expect(entry).to be_nil
    end

    it "searches AddressBook for Bill" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Bill")
      expect(entry).to be_a Entry
      check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
    end
    it "searches AddressBook for Bob" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Bob")
       expect(entry).to be_a Entry
       check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
     end

     it "searches AddressBook for Joe" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Joe")
       expect(entry).to be_a Entry
       check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
     end

     it "searches AddressBook for Sally" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Sally")
       expect(entry).to be_a Entry
       check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
     end

     it "searches AddressBook for Sussie" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Sussie")
       expect(entry).to be_a Entry
       check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
     end

     it "searches AddressBook for Billy" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Billy")
       expect(entry).to be_nil
     end


  end
end
