def is_number(str)
  true
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
  signs: ['+1', '-1', '-1.2', '+1.2', '-10e4', '+10.5e-634']
}

false_tests = {
  basic: ['a', 'abc', '   ', '  a1', '1a', '1   1', '1  a', '95a54e53'],
  decimal: ['.', '1  .'],
  exponent: ['  1e', 'e3', ' 99e2.5'],
  signs: ['  --6', '-+3']
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
