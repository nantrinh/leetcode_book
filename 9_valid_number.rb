require 'pry'

# ignore leading and trailing whitespace
# if first character encountered going left to right
# besides whitespace is NOT +, -, or a digit, return false
#
## if the first char is a + or - and it is NOT followed by a digit
# return false
#
# e's and periods are accepted if followed by at least one digit  
# if there is a character that is NOT a digit, e, +, -, or . return false
# 
# whitespaces in between two numbers is invalid

def is_number(str)
  decimal = false
  at_least_one_digit = false

  i = 0
  i += 1 while i < str.size - 1 && str[i] == ' '
  # first encountered non-whitespace character
  return false unless str[i] =~ /[+\-\.\d]/
  
  # in these cases, must be followed by at least one digit
  if str[i] =~ /[+\-]/
    return false unless i < str.size - 1 && str[i + 1] =~ /[\d]/
    i += 1
  end

  # keep going while you see digits
  at_least_one_digit = true if str[i] =~ /[\d]/
  i += 1 while i < str.size - 1 && str[i] =~ /[\d]/

  # at the end of the string
  if i == str.size - 1
    return true if str[i] =~ /[ \d]/ || at_least_one_digit && str[i] == '.'
  end

  # you encountered a whitespace character or e
  case str[i]
  when '.'
    decimal = true
  when 'e' 
    i += 1 if str[i + 1] == '-'  
  end

  i += 1
  i += 1 while i < str.size - 1 && str[i] =~ /\d/
  i += 1 while i < str.size - 1 && str[i] == ' '
  at_least_one_digit = true if str[i] =~ /\d/
  return true if i == str.size - 1 && str[i] =~ /[ \d]/ && at_least_one_digit

  if (decimal && str[i] == 'e')
    i += 1
    i += 1 while i < str.size - 1 && str[i] =~ /[\d]/
    i += 1 while i < str.size - 1 && str[i] == ' '
    return true if i == str.size - 1 && str[i] =~ /[ \d]/
  end

  false
end

def rest_of_string_is_whitespace(str, start)
  (start..str.size - 1).each do |i|
    return false unless str[i] == ' ' 
  end
  true
end


test_cases = [
  ['0', true],
  ['10  ', true],
  ['   10', true],
  ['  0.1', true],
  ['0.1  ', true],
  ['abc', false],
  ['1  a', false],
  ['2e10', true],
  ['  9e3  ', true],
  ['  -90e3  ', true],
  ['  1e', false],
  ['e3', false],
  [' 6e-1', true],
  [' 99e2.5', false],
  ['53.5e93', true],
  [' --6', false],
  ['-+3', false],
  ['95a54e53', false],
  ['+1', true],
  ['.1', true],
  ['1.', true],
  ['1.0', true],
  ['1e53b', false],
  ['1.2-53b', false],
  ['. ', false],
  ['.', false],
]

test_cases.each do |test|
  output = is_number(test[0])
  if output == test[1]
    puts "passed"
  else
    puts "failed: output: #{output} expected: #{test[1]}"
  end
end
