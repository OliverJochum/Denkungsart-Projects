require 'csv'
require 'time'
puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)
 
times = Hash.new
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
end

puts times.key(times.values.max)
puts times.values.max