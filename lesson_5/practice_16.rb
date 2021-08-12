require 'securerandom'

HEX_DIGITS = %w(0 1 2 3 4 5 6 7 8 9 a b c d e f)

def create_UUID
  # SecureRandom.uuid --Easy way
  sections = [8, 4, 4, 4, 12]

  uuid = ''

  sections.each do |num|
    num.times { uuid << HEX_DIGITS.sample }
    uuid << "-" unless num == sections.last
  end

  uuid
end


5.times do
  puts create_UUID
end