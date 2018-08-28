require_relative('../models/user.rb')
require_relative('../models/merchant.rb')
require_relative('../models/transaction.rb')
require_relative('../models/tag.rb')

require('pry-byebug')


Tag.delete_all()
Merchant.delete_all()
User.delete_all()
Transaction.delete_all()

tag1 = Tag.new({"name" => "Groceries"})
tag1.save()

tag2 = Tag.new({"name" => "Entertainment"})
tag2.save()

tag3 = Tag.new({"name" => "Bills"})
tag3.save()

merchant1 = Merchant.new({"name" => "Waitrose"})
merchant1.save()

merchant2 = Merchant.new({"name" => "Dominion"})
merchant2.save()

merchant3 = Merchant.new({"name" => "Footlights"})
merchant3.save()

merchant4 = Merchant.new({"name" => "Ovo"})
merchant4.save()

user1 = User.new({"name" => "Current", "owner_first_name" => "Lucy",
"owner_last_name" => "Grace", "weekly_budget" => "350.00"})
user1.save()

transaction1 = Transaction.new({"amount" => 24.50, "description" => "2 x Cinema Tickets and Popcorn",
  "merchant_id" => merchant2.id, "tag_id" => tag2.id, "user_id" => user1.id,
  "time_stamp" => "2018-06-25" })
transaction1.save()

transaction2 = Transaction.new({"amount" => 15.00, "description" => "Round of Drinks",
  "merchant_id" => merchant3.id, "tag_id" => tag2.id, "user_id" => user1.id,
  "time_stamp" => "2018-08-25"})
transaction2.save()

transaction3 = Transaction.new({"amount" => 52.50, "description" => "Weekly Shop",
  "merchant_id" => merchant1.id, "tag_id" => tag1.id, "user_id" => user1.id,
  "time_stamp" => "2018-08-26"})
transaction3.save()

transaction4 = Transaction.new({"amount" => 12.50, "description" => "Burger",
  "merchant_id" => merchant3.id, "tag_id" => tag2.id, "user_id" => user1.id,
  "time_stamp" => "2018-08-26"})
transaction4.save()

tags = Tag.all()
transactions= Transaction.all()
merchants = Merchant.all()
users = User.all()

binding.pry
nil
