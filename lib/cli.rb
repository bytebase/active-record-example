class CLI
  def start
    puts "Welcome to the CLI App!"
    show_menu
  end

  private

  def show_menu
    loop do
      puts "\nPlease choose an option:"
      puts "1. List all users"
      puts "2. Create new user"
      puts "3. Exit"
      
      choice = gets.chomp
      
      case choice
      when "1"
        list_users
      when "2"
        create_user
      when "3"
        puts "Goodbye!"
        break
      else
        puts "Invalid option. Please try again."
      end
    end
  end

  def list_users
    users = User.all
    if users.empty?
      puts "No users found."
    else
      users.each do |user|
        puts "#{user.id}. #{user.name} (#{user.email})"
      end
    end
  end

  def create_user
    puts "Enter name:"
    name = gets.chomp
    
    puts "Enter email:"
    email = gets.chomp
    
    user = User.create(name: name, email: email)
    puts "User created successfully!"
  end
end 