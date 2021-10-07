@students = [] # an empty array accessible to all methods

def input_students
  # Months array for the cohorts
  months = ["january","february","march","april","may","june","july","august","september","october","november","december"]
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  cohort = ""
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # ask for cohort while user inputs correct input
    while !months.include? cohort
      puts "Enter cohort: "
      cohort = gets.downcase.chomp
    end
    # convert a string into symbol
    cohort = cohort.to_sym
    # Get mmore info about the student
    puts "Enter hobbies: "
    hobbies = gets.chomp
    puts "Enter your country of birth: "
    country = gets.chomp
    puts "Enter your mother language: "
    language = gets.chomp
    # add the student hash to the array
    @students << {name: name, cohort: cohort, hobbies: hobbies, country: country, language: language }
    # Use singular form when appropriate and plural form otherwise
    if @students.count == 1
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} students"
    end
    # get another name from the user
    puts "Enter a name or hit return to finnish."
    name = STDIN.gets.chomp
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list
  @students.each_with_index { |student, index| puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort), hobbies: #{student[:hobbies]}, country of birth: #{student[:country]}, mother language: #{student[:language]}" }
end

def print_footer
  # Add if/else statement to get particulart output depending on the number of students
  if @students.count == 0
    puts "No students in the list"
  elsif @students.count == 1
    puts "Overall, we have #{@students.count} great student"
  else
    puts "Overall, we have #{@students.count} great students"
  end
end

def print_by_letter
  puts "Give me a letter that I could print the names starting with this specific letter: "
  letter = gets.chomp
  # Prints you all the names from the list starting with the letter user gave us
  @students.each { |student| puts "#{student[:name]} (#{student[:cohort]} cohort), hobbies: #{student[:hobbies]}, country of birth: #{student[:country]}, mother language: #{student[:language]}" if student[:name][0].downcase == letter }
end

# Prints all the names which length is less than 12
def print_by_length
  @students.each { |student| puts student[:name] if student[:name].length < 12 }
end

# Prints students using while loop, no each iterator
def print_using_loop
  acc = 0
  while acc < @students.length do
    puts "#{acc + 1}. #{students[acc][:name]} (#{students[acc][:cohort]} cohort), hobbies: #{student[:hobbies]}, country of birth: #{student[:country]}, mother language: #{student[:language]}"
    acc += 1   
  end    
end

# Prints all students beautifully aligned
def align_students
  cen = 0
  # work out which has the longest name
  @students.each do |name|
    cen = name[:name].length if name[:name].length > cen
  end
  # Centre the names
  @students.each do |name|
    puts name[:name].center(cen)
  end
end

# Prints all students names from particular cohort
def display_grouped_by_cohorts
#Create new students list grouped by the cohorts
  cohorts_list = {}
  
  @students.each do |student|
    cohort = student[:cohort]
    name = student[:name]

    if cohorts_list[cohort] == nil
      cohorts_list[cohort] = [name]
    else 
      cohorts_list[cohort] << name
    end
  end
# Ask user which cohort students he would like to see  
  puts "Which cohort students do you want to print?"
  user_input = gets.chomp
# Iterate through cohort list grouped by the cohort and print only students that user wants to see  
  cohorts_list.each do |key, value| 
    puts value if user_input.downcase== key.to_s
  end
end

#nothing happens until we call the methods
# students = input_students
# print_header
# print(students)
# print_by_letter(students)
# print_by_length(students)
# print_using_loop(students)
# align_students(students)
# display_grouped_by_cohorts(students)
# print_footer(students)

def interactive_menu
  loop do
  # 1. print the menu and ask the user what to do
    print_menu
  # 2. read the input and save it into a variable
    process(STDIN.gets.chomp)
  # 3. do what the user has asked
  end  
end

# Extracting methods from interactive_methdod to shorten the code

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items  
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end


def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
  @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

try_load_students
interactive_menu
