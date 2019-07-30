def select(array)
  new_array = []
  count = 0

  while count < array.size
    result = yield(array[count])
    new_array << array[count] if result
    count += 1
  end

  new_array
end

array = [1, 2, 3, 4, 5]

array.select { |num| num.odd? }
array.select { |num| puts num }
array.select { |num| num + 1 }