require 'csv'
require_relative 'contact'

class CsvReader

  attr_reader :contacts

  def initialize
    @contacts = []
  end

  def read_in_csv_data(csv_file_name)
    CSV.foreach(csv_file_name, headers: true) do |row|
      @contacts << Contact.new(row["Name"], row["Birthdate"], row["Email"], row["Phone"], row["Address"])
    end
  end

end