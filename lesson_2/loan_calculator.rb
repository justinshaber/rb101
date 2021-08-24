require 'yaml'
MESSAGE = YAML.load_file('loan_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(number_string)
  number_string.to_i.to_s == number_string ||
    number_string.to_f.to_s == number_string
end

loop do
  prompt(MESSAGE['spacer'])
  prompt(MESSAGE['welcome'])
  prompt(MESSAGE['spacer'])

  loan_amount = ''
  loop do
    prompt(MESSAGE['loan_amount?'])
    loan_amount = gets.chomp

    break if valid_number?(loan_amount) && loan_amount.to_i > 0
    prompt(MESSAGE['invalid_loan_amount'])
  end

  apr = ''
  loop do
    prompt(MESSAGE['apr?'])
    apr = gets.chomp

    break if valid_number?(apr) && apr.to_f >= 0
    prompt(MESSAGE['invalid_apr'])
  end

  loan_duration_years = ''
  loop do
    prompt(MESSAGE['loan_duration?'])
    loan_duration_years = gets.chomp

    break if valid_number?(loan_duration_years) && loan_duration_years.to_i > 0
    prompt(MESSAGE['invalid_loan_duration'])
  end

  apr = apr.to_f / 100.00
  monthly_interest = apr / 12
  loan_duration_months = loan_duration_years.to_i * 12

  if apr != 0
    monthly_payment = loan_amount.to_i *
                      (monthly_interest /
                      (1 - (1 + monthly_interest)**(-loan_duration_months)))
  else
    monthly_payment = loan_amount.to_i / loan_duration_months
  end

  total_interest = loan_amount.to_i * apr * loan_duration_years.to_i

  loan_details = <<-MSG
    You'll be paying $#{monthly_payment.floor(2)} for #{loan_duration_months} months.
       You'll pay $#{total_interest} in interest over the life of the loan.
  MSG

  prompt(MESSAGE['spacer'])
  prompt(loan_details)
  prompt(MESSAGE['spacer'])

  prompt(MESSAGE['go_again?'])
  answer = gets.chomp.downcase
  break if answer != 'y'
end

prompt(MESSAGE['goodbye'])
