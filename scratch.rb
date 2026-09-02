# frozen_string_literal: true

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