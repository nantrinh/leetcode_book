def is_number(str)
  i = 0
  # leading whitespace
  i += 1 while i < str.size && str[i] == ' '
  # a plus or minus sign
  i += 1 if i < str.size && (str[i] == '+' || str[i] == '-')
  is_numeric = false
  # if there's a number, i will be incremented
  # and is_numeric will be set to true
  while i < str.size && str[i] =~ /\d/
    i += 1
    is_numeric = true
  end
  # increment once if you're at a decimal
  if i < str.size && str[i] == '.'
    i += 1
    # keep incrementing if you're at digits
    # and set is_numeric to true
    while i < str.size && str[i] =~ /\d/
      i += 1
      is_numeric = true
    end
  end
  # increment once if you're at an exponent
  # and there were preceding digits
  if is_numeric && i < str.size && str[i] == 'e'
    i += 1
    # a plus or minus sign immediately following
    # the exponent is acceptable
    i += 1 if str[i] == '+' || str[i] == '-'
    # set is_numeric to false because there must be a
    # whole number after the exponent
    is_numeric = false

    # keep incrementing if you're at digits
    # and set is_numeric to false
    while i < str.size && str[i] =~ /\d/
      i += 1
      is_numeric = true
    end
  end
  # trailing whitespace
  i += 1 while i < str.size && str[i] == ' '
  # if you're at the end of the string now and
  # you have encountered at least one digit, the str is a valid number
  is_numeric && i == str.size
end

true_tests = {
  basic: ['0', '0  ', '  0', '  0  ',
          '01', '01  ', '  01', '  01  ',
          '10', '10  ', '  10', '  10  '],
  decimal: ['1.0', '1.0  ', '  1.0', '  1.0  ',
            '.10', '.10  ', '  .10', '  .10  ',
            '10.', '10.  ', '  10.', '  10.  '],
  exponent: ['1e1', '1e1  ', '  1e1', '  1e1  ',
             '10e5', '6e-9', '5.4e0', '-5.5e-6'],
  signs: ['+1', '-1', '-1.2', '+1.2', '-10e4', '+10.5e-634', ' 005047e+6']
}

false_tests = {
  basic: ['a', 'abc', '   ', '  a1', '1a', '1   1', '1  a', '95a54e53'],
  decimal: ['.', '1  .'],
  exponent: ['  1e', 'e3', ' 99e2.5'],
  signs: ['  --6', '-+3', '-1-1']
}

def info(str)
  puts str.center(50, '-')
end

def test(tests, boolean)
  tests.each do |name, inputs|
    info("TESTING FOR #{name.upcase}")
    inputs.each do |i|
      output = is_number(i)
      puts output == boolean ? 'passed' : "failed. input: \"#{i}\""
    end
  end
end

info('TRUE TESTS')
test(true_tests, true)
info('FALSE TESTS')
test(false_tests, false)
