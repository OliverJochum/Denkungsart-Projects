require 'csv'
require 'time'
require 'date'

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)
 
times = Hash.new
weekdays = {sunday:0,monday:0,tuesday:0,wednesday:0,thursday:0,friday:0,saturday:0}
# Assignment 1 phone numbers
contents.each do |row|
  name = row[:first_name]
  phone = row[:homephone]


  # If the phone number is less than 10 digits, assume that it is a bad number
  if phone.length >= 10 && phone.length <= 11 || !(phone.length == 11 && phone[0] != 1)
    if phone.length == 11 && phone[0] == 1
      phone = phone[1..10]
    end
  end

  puts "#{name}, #{phone}"
  # If the phone number is 10 digits, assume that it is good
  # If the phone number is 11 digits and the first number is 1, trim the 1 and use the remaining 10 digits
  # If the phone number is 11 digits and the first number is not 1, then it is a bad number
  # If the phone number is more than 11 digits, assume that it is a bad number


  # Assignment 2 Time targeting
  regdate = row[:regdate]
  
  time = Time.strptime(regdate, "%m/%d/%Y %k:%M")

  hour = time.hour


  if times.key?(hour)
    times[hour] += 1
  else
    times[hour] = 1
  end

  # Assignment 3 What day of the week?
  

  day = Date.strptime(regdate,"%m/%d/%Y %k:%M").wday

  case day
  when 0
    weekdays[:sunday] += 1
  when 1
    weekdays[:monday] += 1
  when 2
    weekdays[:tuesday] += 1
  when 3
    weekdays[:wednesday] += 1
  when 4
    weekdays[:thursday] += 1
  when 5
    weekdays[:friday] += 1
  when 6
    weekdays[:saturday] += 1
  end

end


puts "Hour: #{times.key(times.values.max)}"
puts "Frequency: #{times.values.max}"

puts "Day: #{weekdays.key(weekdays.values.max)}"
puts "Frequency: #{weekdays.values.max}"