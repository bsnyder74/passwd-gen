def menu
  puts '*' * 40
  puts "(S)imple:   alpha"
  puts "(N)ormal:   alpha + numeric"
  puts "(C)omplex:  alpha + numeric + special\n\n"
  puts "Password length must be 8 or greater.\n"
  puts '*' * 40
  puts ''

  puts "Password complexity :"
  $password_complexity = gets.chomp
  puts "Password length :"
  $password_length = gets.chomp.to_i
 
  if validate_params($password_complexity, $password_length)
    p1 = Password.new($password_complexity, $password_length)
    p2 = Password.new($password_complexity, $password_length)
    p3 = Password.new($password_complexity, $password_length)
  else
    puts "Valid options are 'S', 'N' or 'C'.  Length must be 8 or greater."
  end
end

def validate_params(c, l)
  ['s', 'n', 'c'].include?(c.downcase) && l >= 8
end


class Password
  attr_accessor :length, :complexity, :result

  def initialize(complexity, length)
    @complexity = complexity
    @length = length
    @values = create_values(@complexity)
    @result = create_password(@values)

    self.report
  end

  def create_values(c)
    a = []

    lower = ('a'..'z').to_a
    upper = ('A'..'Z').to_a
    digit = (0..9).to_a
    special = %w[! @ # $ % ^ & * ( ) < > { } - _]

    case c.downcase
    when 's'
      a = lower + upper
    when 'n'
      a = lower + upper + digit
    when 'c'
      a = lower + upper + digit + special
    else
      fail("Error generating password ...")
    end
  end

  def create_password (v)
    pass = []
    self.length.times { pass << v.shuffle[0]}
    return pass.join
  end

  def report
    puts self.result
  end

end

menu
