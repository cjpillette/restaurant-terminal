# challenges 3 and 4 together
require 'terminal-table'

class SubmenuItem
  def initialize(name)
    @name = name
  end

  attr_accessor :name
end

class MenuItem
  def initialize(name, price, description)
    @name = name
    @price = price
    @description = description
  end

  attr_accessor :name, :price, :description
end

class Sub_menu
  def initialize(submenu, menu_items=[])
    @menu_items = menu_items
    show_submenu(submenu)
  end

  def show_submenu(submenu)
    # Display submenu
    submenu.each_with_index do |submenu_item, index|
      user_index = index + 1
      # Display item with index first, then name and price
      puts "#{user_index}. #{submenu_item.name}"
    end
    select_from_submenu
  end

  def select_from_submenu
    loop do
      puts 'Select the index of your choice'
      choice = gets.chomp.to_i
      case choice
      when 1
        main_menu = Main_menu.new(ENTREE_ITEMS)
      when 2
        main_menu = Main_menu.new(MAIN_ITEMS)
      when 3
        main_menu = Main_menu.new(DESERT_ITEMS)
      else
        break
      end
    end
  end
end

class Main_menu

  def initialize(menu_items)
    @menu_items = menu_items
    show_food_menu
  end

  def show_food_menu
    # Display menu
    @menu_items.each_with_index do |menu_item, index|
      user_index = index + 1
      # Display item with index first, then name and price
      puts "#{user_index}. #{menu_item.name}: #{menu_item.price} AUD - #{menu_item.description}"
    end
    order_items(@menu_item)
  end

  def ask_for_bill(order)
    sleep 2
    puts 'I hope you enjoyed your meal. Here is your bill:'
    puts order.bill
  end

  def order_items(menu_item)
    order = Order.new
    puts 'What would you like to order? (or press enter twice to quit)'
    loop do
    choice = gets.chomp
    # Stop looping if user pressed just enter
    break if choice == ''

    # User must choose an index number
    user_index = choice.to_i

    # If the user entered in an invalid choice
    if user_index == 0
      'Invalid choice, please try again'
      next # Loop through and ask again
    end

    index = user_index - 1 # Convert to zero-based index
    menu_item = @menu_items[index]
    # repeat menu_item back to the user like a waiter would
    puts "You've ordered #{menu_item.name}"
    # Add item to order
    order << menu_item
    puts 'Thank you'
    puts ''
    puts 'Order some more? y / n'
    order_some_more = gets.chomp
    order_some_more == 'y' ? next : ask_for_bill(order)
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
  MenuItem.new('Steak', 20, 'Juicy and tender, this is the best cut'),
  MenuItem.new('Parma', 15, 'Your traditional aussie dish'),
  MenuItem.new('Eggplant Casserole', 15, 'For the vegetarians out there'),
  MenuItem.new('Chips', 7, 'Classic bootcamp food'),
  MenuItem.new('Beer', 7, 'Classic bootcamp drink'),
  MenuItem.new('Soft drink', 3.50, 'You non-alcohol option')
]

ENTREE_ITEMS = [
  MenuItem.new('Pate', 5, 'Country style pate with Whisky'),
  MenuItem.new('Small garden salad', 7, 'Leafy salad'),
  MenuItem.new('Soup du jour', 8, 'Pumpkin and carrot soup'),
  MenuItem.new('Dips', 7, 'Selection of 3 dips'),
  MenuItem.new('Finger food', 11, 'Selection of cheeses, salami')
]

MAIN_ITEMS = [
  MenuItem.new('Steak', 20, 'Juicy and tender, this is the best cut'),
  MenuItem.new('Parma', 15, 'Your traditional aussie dish'),
  MenuItem.new('Eggplant Casserole', 15, 'For the vegetarians out there'),
  MenuItem.new('Chips', 7, 'Classic bootcamp food')
]

DESERT_ITEMS = [
  MenuItem.new('Sticky date pudding', 12, 'The best desert'),
  MenuItem.new('Ice cream', 6, '3 balls of ice cream'),
  MenuItem.new('Black forest', 13, 'Rich chocolate desert'),
  MenuItem.new('Cheese cake', 11, 'Classic New York style cheese cake')
]

SUBMENU_ITEMS = [
  SubmenuItem.new('Entree'),
  SubmenuItem.new('Main'),
  SubmenuItem.new('Desert')
]


sub_menu = Sub_menu.new(SUBMENU_ITEMS)
