# Set up for the application and database. DO NOT CHANGE. ##############
require "sequel"                                                       #
DB = Sequel.connect "sqlite://#{Dir.pwd}/development.sqlite3"          #
########################################################################  

# Database schema - this should reflect your domain model
DB.create_table! :events do
  primary_key :id
  String :title
  # "text: true" indicates that this is a special string column that requires additional characters; strings are by default ~250 characters
  String :description, text: true
  String :date
  String :location
end
DB.create_table! :rsvps do
  primary_key :id
  #typically the foreign key uses the "singular" version of the table name (ie. "event" as opposed to "events")
  foreign_key :event_id
  #Boolean = true / false; 1 or 0. Binary
  Boolean :going
  String :name
  String :email
  String :comments, text: true
end

# Insert initial (seed) data
events_table = DB.from(:events)

events_table.insert(title: "Bacon Burger Taco Fest", 
                    description: "Here we go again bacon burger taco fans, another Bacon Burger Taco Fest is here!",
                    date: "June 21",
                    location: "Kellogg Global Hub")

events_table.insert(title: "Kaleapolooza", 
                    description: "If you're into nutrition and vitamins and stuff, this is the event for you.",
                    date: "July 4",
                    location: "Nowhere")

# When you run the above code, you will create a "development.sqlit3" file. In order to read the file, you can type the following into the terminal:
## "sh sql"
### "SELECT * FROM events;"
#### When your'e done, just type ".exit"

#NOTE: Every time you run the database code, it will erase and over-write everything; so do this sparingly. There is a way to only run modifications (ie. add a column, etc.) but you'll need to deal with data corruption issues. So for now, just re-run everything.