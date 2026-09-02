# DEV LOG: Bubble Sort

## Task:

Build a method `#bubble_sort` that takes an array and returns a sorted array. It must use the bubble sort methodology.

e.g.

```ruby
bubble_sort([4,3,78,2,0,2])
# [0,2,2,3,4,78]
```

## First thoughts

Process:

1. loop through numbers provided
2. compare number at index 0 to number at index 1
3. if number at index 1 is larger, swap places with number at index 0
4. index 1 and index 2 and repeat step 3.
5. continue in this fashion until the end of the provided numbers is reached
6. repeat process from index 0
7. loop ends when it has gone through all the indexes without performing any swaps
8. return sorted numbers

In the previous project, I learned how to use nested loops while staggering array traversal.

If I implemented something similar here, I could use it to compare value at index 0 to value at index 0 + 1. But if could I just compare it to i + 1 every time then I don't need nested loops, right?

## Problem: Compare `i` with `i + 1` in loop, and trade places if `i` is greater

```ruby
received_nums LOOP array by index DO |index|
  hold = nil

  IF index < index + 1
    hold = index # hold onto the value at first index
    received_nums[index] = index + 1
    received_nums[index + 1] = hold # transfer value of first index from hold
  END OF IF
END OF LOOP
```

Let's make it more idiomatic.

```ruby
received_nums LOOclearP array by index DO |i|
  buffer_i = nil # to remember value at left_i during swap with right_i
  left_i = i
  right_i = i + 1

  IF left_i < right_i
    buffer_i = left_i
    received_nums[left_i] = right_i
    received_nums[right_i] = buffer_i
  END OF IF
END OF LOOP
```

Testign in scratch.rb:

```ruby
sort_this_please = [4, 3, 78, 2, 0, 2]

def bubble_sort(nums_to_sort)
  received_nums = nums_to_sort
  p "solution here: #{received_nums}"

  received_nums.each_with_index do |i|
    buffer_i = nil # to remember value at left_i during swap with right_i
    left_i = i
    right_i = i + 1

    p "buffer: #{buffer_i}, left i: #{left_i}, right i: #{right_i}"

    # INFINITE LOOP JAIL:
    # if left_i < right_i
    #   buffer_i = left_i
    #   received_nums[left_i] = right_i
    #   received_nums[right_i] = buffer_i
    #   p "buffer: #{buffer_i}, left i: #{left_i}, right i: #{right_i}"
    #   p "received nums: #{received_nums}"
    # end
  end
end

bubble_sort(sort_this_please)
```

Ok, so not only did that result in an infinite loop, but `i + 1` incremented the value rather than the index position in the array.

**Next steps:**

1. Find a way to increment the index, not it's value. Trying to avoid nesting loops, but that's my plan b.
2. If the above doesn't resolve the infinite loop, add a win condition so the loop can terminate.

I tried using `right_i` = `received_nums[i + 1]`, but it resulted in `2` even though `i` was at index `0`.

This worked to iterate through the indexes:

```ruby
nums = [23, 54, 87, 29, 32, 43, 76]

nums.each_with_index do |number, i|
  this_index = i
  next_index = i + 1

  p "this is this index #{this_index}"
  p "this is next index #{next_index}"
end
```

Now to << the text here got deleted somehow and is lost forever >>

Ref:

```ruby
nums = [223, 54, 87, 29, 32, 43, 76]

nums.map! do |i|
  this_value = i
  next_value = nums[i + 1]
  buffer = nil

  p "this is this value #{this_value}"
  p "this is next value #{next_value}"
  p "this is buffer #{buffer}"

  if next_value > this_value
    buffer = this_value
    p "this is buffer #{buffer}"
    nums[i] = next_value
    p "this is this value #{this_value}"
    nums[i + 1] = buffer
    p "this is next value #{next_value}"
    p "this is the nums #{nums}"
  end
end
```

this one below skips the first index and looks backwards instead of forward when comparing values in order not to end up with a nil value at the end of the loop

```ruby
array = [223, 54, 87, 29, 32, 43, 76]

array.each_with_index do |el, i|
  next if i === 0
  prev_el = array[i-1]  #will be nil for the first element
  current_el = array[i]  #will be nil for the last element
  # if next_el < prev_el
  #   p "next el is smaller than prev el #{next_el} < #{prev_el}"
  # end
  p "prev el: #{prev_el}; current el: #{current_el}"
end
```

the below seems to work in print, but doesn't edit the array in place. Going to switch to map.

```ruby
array = [223, 54, 87, 29, 32, 43, 76]

array.each_with_index do |el, i|
  next if i === 0
  prev_el = array[i-1]  #will be nil for the first element
  current_el = array[i]  #will be nil for the last element
  buffer = nil

  if current_el < prev_el
    p "#{current_el} < #{prev_el}"
    buffer = prev_el
    prev_el = current_el
    current_el = buffer
    p "values updated: buffer: #{buffer}; prev el: #{prev_el}; current el: #{current_el}"
  end

  p "prev el: #{prev_el}; current el: #{current_el}"
  p "end of loop #{i}"
  p array
end
```

Happy with this solution below, however, it is not pushing new values to the array because it is apparently nil, however, the p statements just above that command clearly show they are not nil

```ruby
array = [223, 54, 87, 29, 32, 43, 76]

sorted_array = array.map.with_index do |el, i|
  next if i === 0 # prevent prev_el from being nil for first element
  prev_el = array[i-1]  #will be nil for the first element
  current_el = array[i]
  buffer = 0

  if prev_el > current_el
    p "#{prev_el} > #{current_el}"
    buffer = prev_el
    prev_el = current_el
    current_el = buffer
    p "values updated: prev el: #{prev_el}; current el: #{current_el}; buffer: #{buffer}"

    sorted_array << prev_el
    p sorted_array
    sorted_array << current_el
    p sorted_array
    p "array updated: #{sorted_array}"
  end

  p "end of loop #{i} || prev el: #{prev_el}; current el: #{current_el}"

end

p 'sorted array:'
p sorted_array.compact
```

Here's what I came up with, it's not working out.

```ruby
array = [223, 54, 87, 29, 32, 43, 76]
sorted_array = []

sorted_array = array.map.with_index do |el, i|
  next if i === 0 # prevent prev_el from being nil for first element
  prev_el = array[i-1]  #will be nil for the first element
  current_el = array[i]
  buffer = 0
  p "top of loop #{i} || prev el: #{prev_el}; current el: #{current_el}"
  p "array progress: #{sorted_array}"

  if prev_el > current_el
    p "#{prev_el} > #{current_el}"
    buffer = prev_el
    prev_el = current_el
    current_el = buffer
    # p "values updated: prev el: #{prev_el}; current el: #{current_el}; buffer: #{buffer}"

    sorted_array << prev_el
    sorted_array << current_el
    p "array updated: #{sorted_array}"
  else
    p "#{prev_el} is not greater than #{current_el}"
  end

end

p 'sorted array:'
p sorted_array.compact
```

This isn't quite going the way I had hoped. Abandoning it, I will explore my first idea which was to use nested loops.

```ruby
array = [223, 54, 87, 29, 32, 43, 76]
sorted_array = []

sorted_array = array.map.with_index(0) do |ei, i|
  next if i === array.length - 1 # prevent nil at end of loop
  array.map.with_index(1) do |ej, j|

  # next if j === 0 # stagger i and j for operations

  prev_el = array[i]
  current_el = array[j]
  buffer = 0

  p "top of loop #{i} || prev el: #{prev_el}; current el: #{current_el}"
  p "array progress: #{sorted_array}"

    if prev_el > current_el
      p "#{prev_el} > #{current_el}"
      buffer = prev_el
      prev_el = current_el
      current_el = buffer
      # p "values updated: prev el: #{prev_el}; current el: #{current_el}; buffer: #{buffer}"

      sorted_array << prev_el
      sorted_array << current_el
      p "array updated: #{sorted_array}"
    else
      p "#{prev_el} is not greater than #{current_el}"
    end
  end
end

p 'sorted array:'
p sorted_array.compact

```

The above try didn't work because the nested loop did all of the `j` comparisons with the first `i`, which I for some reason totally blanked on, so this is not the answer.

I'm having trouble modifying the array in place using map, because I can't find a way to identify the index of the elements being worked on in each loop.

Chaining `#map` with `#with_index` means I can't use a bang to modify it in place. When I add it to a new array, that new array would then need to be operated on to continue the bubble sort operation. Further, I can't seem to get the whole array built in the first place.

It continually adds my largest number, which I put at the front of my mockup array, while also swapping it to the back. It's not swapping of course, but being added to the new array. I could use `#uniq` to remove duplicates, but of course this would result in a bug if there were duplicates present in any other number set fed to this bubble sort method. I need to think.

(...)

I wonder if this should have been obvious, but I discussed my problem above with with a TOP alumni who is now a senior programmer, and I feel kind of ridiculous now. To my embarassment, she pointed out that I should be using helper functions. I of course know that, but I was experimenting with making "bad" (but working) code and refactoring later, the idea being that I focus on solving the problem rather than making it elegant and idiomatic, which was a major distraction for me on most of my previous projects, even every commit message would take me 10 minutes or longer to finalize. But forgoing the elegance altogether? I took it too far and it was working against me. I see that now.

All this is to say that I overlooked something: I don’t have to swap the index values while iterating over them. My helper function can handle it from outside the loop.

I think I overlooked this because I was trying not to implement helpers until later. I went too hard the other way on not trying to build the most elegant and idiomatic solutions possible (which caused other problems including constant refactoring). I broke the habit, at least. Now to find the happy middle. The middle way.

So it’s basically this:

```ruby
numbers = [223, 54, 87, 29, 32, 43, 76]

numbers.each_with_index do |number, index|
  # skip if index == 0
  # compare current and previous number
  # if previous > current, swap
end

def swap_elements_at_indices(list, index_one, index_two)
  # read the element stored at index 1
  # read the element stored at index 2
  # write element 1 to index 2
  # write element 2 to index 1

end
```

ok so after hacking away at it, I got some working code, just need to work out some snags.

```ruby
nums_to_sort = [223, 54, 87, 29, 32, 43, 76]

# - - - - - MAIN PROGRAM FUNCTION - - - -

def bubble_sort(array_to_sort)

  unsorted_array = array_to_sort

  unsorted_array.map.with_index do |el, i|

    next if i === 0 # prevent prev_el from being nil for first element

    prev_el = unsorted_array[i-1]
    current_el = unsorted_array[i]

    p "top of loop #{i} || prev el: #{prev_el}; current el: #{current_el}"
    p "array progress: #{unsorted_array}"

    if prev_el > current_el
      p "#{prev_el} > #{current_el}"
      swap_elems_at_indices(unsorted_array, prev_el, current_el)
    else
      next
    end
  end
end

# - - - - - HELPER FUNCTION: SWAP ELEMENTS - - - -

def swap_elems_at_indices(list, ind_prev, ind_current)
  buffer = [] # this is returning [nil]
  buffer[0] = list[ind_prev] # this is returning [nil]
  p "buffer: #{buffer}"
  list[ind_prev] = ind_current # this is not overwriting the current value
  list[ind_current] = buffer[0]
    p "values updated: ind prev: #{ind_prev}; ind curr: #{ind_current}; buffer: #{buffer}"
    p "array updated: #{list}"
end

# - - - - - RUN / TEST PROGRAM - - - -
sorted_nums = bubble_sort(nums_to_sort)

p 'sorted array:'
p sorted_nums
```

So I'm still having some problems, but I think this solution is promising.

Problems:

1. My `buffer` array in the helper function `swap_elems_at_indices(list, ind_prev, ind_current)` keeps returning nil no matter how I create it, and I can't seem to write to it.
2. `array[index] = value` format is not writing to the array in the helper function.

ok, I got buffer working. The trick is not making it an array. Why on earth did I think it had to be an array? It's just `buffer = ind_prev` now.

```ruby
def swap_elems_at_indices(list, ind_prev, ind_current)
  p "list: #{list}"
  p "ind_prev: #{ind_prev}"
  buffer = ind_prev # returns 223 on first loop :)
  p "buffer: #{buffer}"
  list[ind_prev] = ind_current # this is not overwriting the current value
  list[ind_current] = buffer[0]
    p "values updated: ind prev: #{ind_prev}; ind curr: #{ind_current}; buffer: #{buffer}"
    p "array updated: #{list}"
end
```

However, my output still returns an array with tons of nil values in it. It's not coming from `buffer`, so I realize that the `ind_prev` is the value and not the current index. So that's an issue. I can't write to the index being iterated on when this helper is called because (I'm assuming) I'm writing to index 223 on the first loop, not index 0.

I want to see if I can correct it by adding more arguments to my helper function:

`swap_elems_at_indices(list, el_prev, el_current, prev_index, current_index)`

and when it's called in `bubble_sort`:

`swap_elems_at_indices(unsorted_array, prev_el, current_el, i - 1, i)`

I don't really know/remember how to save the index numbers themselves, but I can make it more elegant later.

I feel like I'm really close. Home stretch here, guys.

I'm never taking a 3-month break from a course again. Yow. I feel like I should know this.

Great news, I got it working! It successfully takes the largest number (at index 0) and takes it all the way to the end.

I just need to add some condition to make it repeat the process until the entire array is sorted.

```ruby
nums_to_sort = [223, 54, 87, 29, 32, 43, 76]

# - - - - - MAIN PROGRAM FUNCTION - - - -

def bubble_sort(array_to_sort)
  unsorted_array = array_to_sort

  unsorted_array.map.with_index do |el, i|

    next if i === 0 # prevent prev_el from being nil for first element

    prev_el = unsorted_array[i - 1]
    current_el = unsorted_array[i]

    p " "
    p p "BUBBLE SORT FUNCTION LOOP:"
    p "unsorted array (index - 1) ---- #{i - 1} --- prev el: #{prev_el}"
    p "unsorted array (index) -------- #{i} --- curr el: #{current_el}"

    p "array progress: #{unsorted_array}"

    if prev_el > current_el
      p "#{prev_el} > #{current_el}"
      swap_elems_at_indices(unsorted_array, prev_el, current_el, i - 1, i)
    else
      next
    end

  end
end

# - - - - - HELPER FUNCTION: SWAP ELEMENTS - - - -

def swap_elems_at_indices(list, el_prev, el_current, prev_index, current_index)
  p " "
  p "HELPER FUNCTION:"
  p "list: #{list}"
  p "el_prev: #{[el_prev]}"
  buffer = el_prev # returns 223 on first loop :)
  p "buffer: #{buffer}"
  list[prev_index] = el_current
  list[current_index] = buffer
end

# - - - - - RUN / TEST PROGRAM - - - -
bubble_sort(nums_to_sort)

p 'sorted array:'
p nums_to_sort
```
