# https://leetcode.com/problems/reverse-words-in-a-string-ii/

# O(n) runtime; O(1) space
# reverse entire string
# reverse each word within the string

def reverse_words(str)
  reverse_string(str, 0, str.size - 1)
  i = 0
  j = 1
  while j < str.size
    j += 1 until str[j] == ' ' || j == str.size
    reverse_string(str, i, j - 1)
    i = j + 1
    j = i + 1
  end
end

def reverse_string(str, i, j)
  return if str.size == 1
  while i < j
    temp = str[i]
    str[i] = str[j]
    str[j] = temp
    i += 1
    j -= 1
  end
end

test_cases = [
  ['the sky is blue', 'blue is sky the'],
  ['this weather is beautiful', 'beautiful is weather this'],
  ['', ''],
  ['a', 'a'],
  ['123 (*)', '(*) 123'],
]

test_cases.each do |test|
  input, output = test.map {|x| x.split('')}
  reverse_words(input)
  if input == output
    puts "passed"
  else
    p "failed; transformed: #{input.join}; solution: #{output.join}"
  end
end
