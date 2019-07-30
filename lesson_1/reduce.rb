def reduce(array, acc = 0)
  count = 0
  while count < array.size
    acc = yield(acc, array[count])
    count += 1
  end

  acc
end

array = [1, 2, 3, 4, 5]

reduce(array) { |acc, num| acc + num }
reduce(array, 10) { |acc, num| acc + num }
reduce(array) { |acc, num| acc + num if num.odd? }

#Extra Challenge-modify for non-numeric values

def reduce(array, acc = nil)
  if acc.is_a?(Integer)
    acc = 0 if acc.nil?
    array.each { |n| acc = yield(acc, n) }
  else
    acc = array[0]
    array[1..-1].each { |el| acc = yield(acc, el) }
  end

  acc
end

reduce(['a', 'b', 'c']) { |acc, value| acc += value }
reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value }
