#James Kim
# CECS424
# Array Partitioner

# create an array
narray=[28,26,25,11,16,12,24,29,6,10]
#create text value
x=17

puts "Given: " +narray.join(" ")

#variable at first  and last index
low=0
high=narray.size-1

#loop till low and high meet
while(low<high)
  #find a variable to switch
  while(narray[low]<=x)
    low+=1
  end
  #find a variable to switch
  while(narray[high]>x)
    high-=1
  end
  #swap
  if(low<high)
    temp=narray[low]
    narray[low]=narray[high]
    narray[high]=temp
  end
end
puts "Result: " + narray.join(" ")
puts "Partition Index: " + (low-1).to_s


