# asks for two numbers
# asks for the type of operation to perform: add, subtract, multiply or divide
# perform the operation
# displays the result

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(number_string)
  if number_string.to_i.to_s == number_string
    return number_string.to_i
  elsif number_string.to_f.to_s == number_string
    return number_string.to_f
  else
    return false
  end
end

def operation_to_message(op)
  word =  case op
            when '1'
              'Adding'
            when '2'
              'Subtracting'
            when '3'
              'Multiplying'
            when '4'
              'Divinding'
          end

  x = "extra code"

  word
end

prompt(MESSAGES['welcome'])

name = ''
loop do
  name = gets.chomp
  if name.empty?
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end
#prompt("Hi #{name}!")
prompt(MESSAGES['hello_name'] + name + "!")

loop do # main loop
  number1 = ''
  loop do
    prompt(MESSAGES['first_number'])
    number1 = gets.chomp

    if valid_number?(number1)
      number1 = valid_number?(number1)
      break
    end
    prompt(MESSAGES['valid_number'])
  end

  number2 = ''
  loop do
    prompt(MESSAGES['second_number'])
    number2 = gets.chomp

    if valid_number?(number2)
      number2 = valid_number?(number2)
      break
    end
    prompt(MESSAGES['valid_number'])
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
      1) add
      2) subtract
      3) multiply
      4) divide
  MSG
  
  prompt(operator_prompt)

  operator = ''
  loop do
    operator = gets.chomp
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES['valid_operator'])
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  result = case operator
           when '1'
             number1 + number2
           when '2'
             number1 - number2
           when '3'
             number1 * number2
           when '4'
             number1.to_f / number2.to_f
           end

  prompt(result.to_s)

  prompt(MESSAGES['go_again?'])
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(MESSAGES['thanks'])
