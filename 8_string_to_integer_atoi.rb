# is first non-whitespace character encountered a digit or +/-?
# if +/-, is next character a digit?
# keep going until you hit a non-digit or end of string
#
# number = 0
# as you go left to right multiply number * 10 plus the current digit
# if the number > 214748364 then you know it is going to overflow
# because even if the current digit is 0, you will have 2147483650
# if the number == 214748364 then if the current digit is > 7 it will
# overflow
#
# for negative numbers, same as above, except in the last condition
# if the current digit is > 8 it will overflow

# O(n) runtime, O(1) space

INT_MAX = (2 ** 31) - 1 # 2,147,483,647
INT_MIN = -(2 ** 31) # -2,147,483,648

def my_atoi(str)
  i = 0
  negative = false

  # first character
  i += 1 while i < str.size && str[i] == ' '

  return 0 unless str[i] =~ /[+\-0-9]/

  if str[i] =~ /[+\-]/
    return 0 unless str[i + 1] =~ /[0-9]/ 
    negative = (str[i] == '-') 
    i += 1
  end

  number = str[i].to_i
  i += 1

  # rest of the number
  while i < str.size && str[i] =~ /[0-9]/
    if overflow(number, str[i].to_i, negative)
      return negative ? INT_MIN : INT_MAX
    end

    number *= 10
    number += str[i].to_i
    i += 1
  end

  negative ? -1 * number : number
end

def overflow(number, n, negative)
  threshold = 214748364
  if number > threshold 
    return true
  elsif number == threshold 
    if negative
      return true if n > 8
    else
      return true if n > 7
    end
  end
  false
end

test_cases = [
  ['42', 42],
  ['   -42', -42],
  ['4193 with words', 4193],
  ['words and 987', 0],
  ['-91283472332', -2147483648],
  ['000072332', 72332],
  ['-00001', -1],
]

test_cases.each do |test|
  output = my_atoi(test[0])
  if output == test[1]
    puts "passed"
  else
    puts "failed: output: #{output}, expected: #{test[1]}" 
  end
end
