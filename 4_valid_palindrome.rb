# initialize two pointers: one at first char, one at last char
# increment/decrement until the chars are alphanumeric
# compare the two chars
# if they are not the same return false
# else keep moving and comparing until the indexes are the same
# return true

# O(n) runtime, O(1) space

def is_palindrome(str)
  i = 0
  j = str.size - 1
  pattern = /[a-z0-9]/i
  while i < j
    until str[i] =~ pattern || i == j
      i += 1
    end

    until str[j] =~ pattern || i == j
      j -= 1
    end

    return false unless str[i].downcase == str[j].downcase
    i += 1
    j -= 1
  end
  true
end

p is_palindrome("  .&*a") # true 
p is_palindrome("ra ce car") # true 
p is_palindrome("A man, a plan, a canal: Panama") # true
p is_palindrome("") # true 
p is_palindrome("  .&*") # true
p is_palindrome("race a car") # false 
