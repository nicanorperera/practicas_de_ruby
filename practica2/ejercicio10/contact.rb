class Contact

  attr_accessor :name, :birthdate, :email, :phone, :address

  def initialize(name, birthdate, email, phone, address)
    @name       = name
    @birthdate  = birthdate
    @email      = email
    @phone      = phone
    @address    = address
  end

end