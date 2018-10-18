class User

  attr_accessor :address, :last_name, :first_name

  def initialize
    @first_name = 'Test'
    @last_name = 'Tester'
    @address = [UserAddress.new]
  end

end