require 'terminal-table'

class MenuItem
  def initialize(name, price)
    @name = name
    @price = price
  end

  attr_accessor :name, :price
end

class Main_menu

  def initialize(menu_items)
    @menu_items = menu_items
    show_food_menu
  end

  def show_food_menu
    # Display menu
    MENU_ITEMS.each_with_index do |menu_item, index|
      user_index = index + 1
      # Display item with index first, then name and price
      puts "#{user_index}. #{menu_item.name}: #{menu_item.price}"
    end

    loop do
      puts 'What would you like?'
      choice = gets.chomp
      # Stop looping if user pressed just enter
      break if choice == ""

      # User must choose an index number
      user_index = choice.to_i

      # If the user entered in an invalid choice
      if user_index == 0
        "Invalid choice, please try again"
        next # Loop through and ask again
      end

      index = user_index - 1 # Convert to zero-based index
      menu_item = MENU_ITEMS[index]

      # repeat menu_item back to the user like a waiter would
      puts "You've ordered #{menu_item.name}"
  end

  def order_items(order)
    # Add item to order
    order << menu_item
    puts 'Thank you'
    puts ''
  end

  def ask_for_bill(order)
    sleep 2
    puts 'I hope you enjoyed your meal. Here is your bill:'
    puts order.bill
  end
end

class Order
  def initialize()
    @items = []
  end

  def << (menu_item)
    @items << menu_item
  end

  def total
    total = 0
    @items.each do |item|
      total += item.price
    end
    "$#{total}"
  end

  def bill
    table = Terminal::Table.new headings: ['Name', 'Price'] do |t|
      @items.each do |item|
        t << [item.name, "$#{item.price}"]
      end
      t.add_separator
      t << ['TOTAL', total]
    end
    table
  end
end
end

MENU_ITEMS = [
  MenuItem.new('Steak', 20),
  MenuItem.new('Parma', 15),
  MenuItem.new('Eggplant Casserole', 15),
  MenuItem.new('Chips', 7),
  MenuItem.new('Beer', 7),
  MenuItem.new('Soft drink', 3.50)
]

main_menu = Main_menu.new(MENU_ITEMS)
