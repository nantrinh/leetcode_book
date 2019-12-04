# INPUT: string
# OUTPUT: string
#
# reverse the input string word by word
# no leading or trailing spaces
# only 1 space between words
# any sequence of non-space characters is a word

# initialize a new string
# iterate through str
# copy each character to the new string until you hit a space
# add that new string to an array
#
# initialize a new string
# keep moving through the string until you encounter another space
# repeat until you have moved through the entire string
# 
# create a new string
# working backwards in your array
# copy it to new string, add space to new string, copy next one
# to new string, repeat until you have added all words to the string
#
# return the new string
#
#
# each character gets copied twice in the worst case
# O(n) runtime and space
# two passes


# question about the given solution:
# when you append a word, doesn't that involve copying every character over to the new string?

def reverse_words(str)
  words = []
  i = 0
  word = ''
  while i < str.size
    if str[i] != ' '
      word += str[i]
    elsif word.size > 0
      words.push(word)
      word = ''
    end
    i += 1
  end
  words.push(word) if word.size > 0

  reversed = ''
  i = words.size - 1 
  while i >= 0 
    reversed += words[i]
    reversed += ' ' unless i.zero?
    i -= 1
  end

  reversed
end

test_cases = [
  ['the sky is blue', 'blue is sky the'],
  ['  hello world!  ', 'world! hello'],
  ['a good   example', 'example good a'],
  ['', ''],
]

test_cases.each do |test|
  output = reverse_words(test[0])
  if output == test[1]
    puts "passed"
  else
    puts "failed; output: #{output}; solution: #{test[1]}"
  end
end
