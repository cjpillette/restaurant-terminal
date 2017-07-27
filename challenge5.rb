# Add a drinks menu (with beers, wine, and cocktails). Research six cocktails
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
  def initialize(submenu, submenu_items)
    @submenu_items = submenu_items
    show_submenu(submenu)
  end

  def show_submenu(submenu)
    # Display submenu
    submenu.each_with_index do |submenu_item, index|
      user_index = index + 1
      # Display item with index first, then name and price
      puts "#{user_index}. #{submenu_item.name}"
    end
    select_from_submenu(submenu)
  end

  def select_from_submenu(submenu)
    loop do
      puts 'Select the index of your choice'
      choice = gets.chomp.to_i
      if choice.zero? || choice > submenu.length
        break
      else
        handle_choice(choice)
      end
    end
  end

  def handle_choice(choice)
    case choice
    when 1
      puts 'Sorry we are out of beer'
    when 2
      puts 'Sorry we are out of wine'
    when 3
      main_menu = Main_menu.new(COCKTAILS_ITEMS)
      show_food_menu
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

COCKTAILS_ITEMS = [
  MenuItem.new('Apple Martini', 20, 'An Apple Martini, or Appletini, is a trendy cocktail that has gained popularity by adding a big twist to the typical dry martini'),
  MenuItem.new('Long Island Iced Tea', 21, 'Packing quite a punch, the Long Island Iced Tea is one cocktail that never seems to go out of style, especially with men'),
  MenuItem.new('Californication', 18, 'A California twist on the Long Island Iced Tea, the Californication is a golden state version of the popular Long Island concoction'),
  MenuItem.new('Pina Colada', 17, 'The classic tropical cocktail with a distinctive look and taste would have to be the Pina Colada'),
  MenuItem.new('Margarita', 15, 'Margarita is easily the most popular cocktail in the United States made with tequila'),
  MenuItem.new('Caipirinha', 19, 'The World Cup is about to introduce the world to the fun-loving country of Brazil and one drink that Brazilians
     are always delighted to share with others is the slightly intimidating Caipirinha')
]

SUBMENU_ITEMS = [
  SubmenuItem.new('Entree'),
  SubmenuItem.new('Main'),
  SubmenuItem.new('Desert')
]

DRINKSMENU_ITEMS = [
  SubmenuItem.new('Beer'),
  SubmenuItem.new('Wine'),
  SubmenuItem.new('Cocktails')
]

sub_menu = Sub_menu.new(DRINKSMENU_ITEMS, COCKTAILS_ITEMS)
