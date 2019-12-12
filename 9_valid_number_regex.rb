def is_number(str)
  return true if (
    # zero or more whitespace
    # zero or one minus sign 
    # zero or more digits
    # zero or one decimal
    # one or more digits
    # zero or more whitespace
    str =~ / *[\d]*\.?[\d]+ *$/ ||
    # zero or more whitespace
    # one or more digits
    # zero or one decimal
    # zero or more digits
    # zero or more whitespace
    str =~ / *[\d]+\.?[\d]* *$/ ||
    # zero or more whitespace
    # one or more digits
    # zero or one decimal
    # zero or more digits
    # zero or one exponent
    # zero or one negative sign
    # one or more digits
    # zero or more whitespace

  )
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
