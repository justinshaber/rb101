require 'yaml'
MESSAGE = YAML.load_file('loan_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(number_string)
  if number_string.to_i.to_s == number_string && number_string.to_i > 0
    return number_string.to_i
  elsif number_string.to_f.to_s == number_string && number_string.to_i > 0
    return number_string.to_f
  else
    return false
  end
end

prompt(MESSAGE['welcome'])

loan_amount = ''
loop do 
  prompt(MESSAGE['loan_amount?'])
  loan_amount = gets.chomp
  if valid_number?(loan_amount)
    loan_amount = valid_number?(loan_amount)
    break
  end
  prompt(MESSAGE['invalid_loan_amount'])
end

apr = ''
monthly_interest = ''
loop do 
  prompt(MESSAGE['apr?'])
  apr = gets.chomp
  if valid_number?(apr)
    apr = valid_number?(apr) / 100.00
    monthly_interest = apr / 12
    break
  end
  prompt(MESSAGE['invalid_apr'])
end

loan_duration_years = ''
loan_duration_months = ''
loop do 
  prompt(MESSAGE['loan_duration?'])
  loan_duration = gets.chomp
  if valid_number?(loan_duration)
    loan_duration_years = valid_number?(loan_duration)
    loan_duration_months = loan_duration_years * 12
    break
  end
  prompt(MESSAGE['invalid_loan_duration'])
end  

monthly_payment = loan_amount * (monthly_interest / (1 - (1 + monthly_interest)**(-loan_duration_months)))
total_interest = loan_amount * apr * loan_duration_years

loan_details = <<-MSG
  You'll be paying $#{monthly_payment} for #{loan_duration_months} months.
  You'll pay #{total_interest} in interest over the life of the loan.
MSG

prompt(loan_details)

