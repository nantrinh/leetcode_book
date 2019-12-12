# frozen_string_literal: true

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

# [whitespace]*[number]+[decimal]?[number]+[exponent]?[number]+[whitespace]*

def appropriate_ending_char(str, i, at_least_one_digit, exponent)
  character = str[i]
  !!((character =~ /\d/ && (
        (i.zero?) ||
        (str[i - 1] == ' ' && !at_least_one_digit) ||
        (str[i - 1] != ' ')
      )) ||
     (character == ' ' && at_least_one_digit) ||
     (character == '.' && at_least_one_digit && !exponent)
    )
end


def is_number(str)
  decimal = false
  exponent = false
  at_least_one_digit = false

  ### PART 1 ###
  i = 0
  i += 1 while i < str.size - 1 && str[i] == ' '
  if i == str.size - 1
    return appropriate_ending_char(str, i, at_least_one_digit, exponent)
  end

  at_least_one_digit = !!(str[i] =~ /\d/)
  i += 1 while i < str.size - 1 && str[i] =~ /\d/
  i += 1 while i < str.size - 1 && str[i] == ' '

  if i == str.size - 1
    return appropriate_ending_char(str, i, at_least_one_digit, exponent)
  end

  case str[i]
  when '.'
    decimal = true
    return false unless str[i + 1] =~ /\d/
    i += 1
  when 'e'
    return false unless at_least_one_digit

    exponent = true
    i += 1
    i += 1 if i < str.size - 1 && str[i] == '-'
  when /[\+\-]/
    return false unless str[i + 1] =~ /\d/

    i += 1
  else
    return false
  end

  ### PART 2 ###
  at_least_one_digit = !!(str[i] =~ /\d/)
  i += 1 while i < str.size - 1 && str[i] =~ /\d/
  i += 1 while i < str.size - 1 && str[i] == ' '
  if i == str.size - 1
    return appropriate_ending_char(str, i, at_least_one_digit, exponent)
  end

  case str[i]
  when '.'
    return false if decimal || exponent

    i += 1
  when 'e'
    return false unless at_least_one_digit

    exponent = true
    i += 1
    i += 1 if i < str.size - 1 && str[i] == '-'
  else
    return false
  end

  ### PART 3 ###
  at_least_one_digit = !!(str[i] =~ /\d/)
  i += 1 while i < str.size - 1 && str[i] =~ /\d/
  i += 1 while i < str.size - 1 && str[i] == ' '

  if i == str.size - 1
    return appropriate_ending_char(str, i, at_least_one_digit, exponent)
  end

  false
end

test_cases = [
  ['3. ', true],
  ['  0', true],
  ['1  4', false],
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
  ['. 1', false]
]

test_cases.each do |test|
  output = is_number(test[0])
  if output == test[1]
    puts 'passed'
  else
    puts "failed: output: #{output} expected: #{test[1]}"
  end
end
