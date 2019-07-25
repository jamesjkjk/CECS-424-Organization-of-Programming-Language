#James Kim
# CECS424
# Coin Arranger
# Start with  5 heads and 5 tails. User can only move 2 coins at a time. End with no two sides next to each other using less than 5 turns

#Initialize the first turn and create coins
turn = 1
status=false
coins = ['H', 'H', 'H', 'H', 'H', 'T', 'T', 'T', 'T', 'T']

# This method moves the two selected coins around the array
def turn(pos1, pos2, coins)
  #check if the user adds coins to the beginning or the end of the array
  if pos2==0 || pos2==10
    temp1=coins[pos1]
    temp2=coins[pos1+1]
    coins[pos1] = "-"
    coins[pos1 + 1] = "-"
    coins.insert(pos2,temp1)
    coins.insert(pos2 + 1,temp2)
  #check if user adds coins from anywhere else
  else
    temp1=coins[pos1]
    temp2=coins[pos1+1]
    coins.delete('-')
    coins[pos1] = "-"
    coins[pos1 + 1] = "-"
    coins.insert(pos2,temp1)
    coins.insert(pos2 + 1,temp2)
  end

  #remove any - from the beginning and end of the array
  if (coins[0] == '-') || (coins[11] == '-')
    coins.delete('-')
  end
end

#loop until game ends in 5 turns
while turn < 6 && status==false
  print('Turn ', turn, "\n")

  #create a string of the coin array to print
  coinString = coins.join
  puts coinString
  puts 'Index of coins to move'
  valid = false
  #loop until valid initial pos is found
  while(!valid)
    initialpos = gets.to_i
    #initial position cannot be from a null space or the last index
    if coins[initialpos] == (nil || '-') || coins[initialpos+1] == (nil || '-') || initialpos >= coins.size-1
      puts "Not a valid move. Try again."
    else
      valid = true
    end
  end
  
  valid = false
  #loop until valid destination pos is found
  while(!valid)
    puts coinString
    valid = false
    if coins.size == 10
      puts 'Front or Back'
# checks when there are null spaces and if at index 0
    elsif coins.size == 12 && initialpos == 0
      puts 'Gap or Back'
# checks when there are null spaces and if at index 0
    elsif coins.size == 12 && initialpos == 10
      puts 'Front or Gap'
    else
      puts 'Gap'
    end

    endpos = gets.to_i
    # check if ending position is valid
    if ((coins[endpos]=='-' && coins[endpos+1]=='-') || endpos==0 || endpos==10) && initialpos!=endpos
      # checks for when there are no null spaces
      if coins.size == 10
        if endpos == 0 || endpos == 10
          valid = true
        end
      # checks when there are null spaces and if at index 0
      elsif coins.size == 12 && initialpos == 0
        if (coins[endpos] == '-' && coins[endpos + 1] == '-' ) || endpos == 10
          valid = true
        end
      # checks when there are null spaces and if at index 10
      elsif coins.size == 12 && initialpos == 10
        if endpos == 0 || coins[endpos] == '-' && coins[endpos + 1] == '-'
          valid = true
        end
      #check if initial position is at anywhere else
      elsif coins.size == 12 && (initialpos != 10 || initialpos != 0)
        valid = true
      end

    else
      puts "Not a valid move. Try again."
    end
  end
  turn(initialpos,endpos,coins)

  #check everyturn if user wins or loses
  if coinString == ('HTHTHTHTHT' || 'THTHTHTHTH')
    status = true
  end
  turn += 1
end

#win and lose
if status == true
  puts "\nYou won"
else
  puts "\nYou lost"
end

