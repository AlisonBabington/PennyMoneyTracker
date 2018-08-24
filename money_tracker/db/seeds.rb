require_relative('../models/accounts.rb')
require_relative('../models/merchants.rb')
require_relative('../models/transactions.rb')
require_relative('../models/tags.rb')

require('pry-byebug')


Tag.delete_all()
Merchant.delete_all()
Account.delete_all()
Transaction.delete_all()

tags = Tag.all()
transactions= Transaction.all()
merchants = Merchant.all()
accounts = Account.all()

tag1 = Tag.new({"name" => "Groceries"})
tag1.save()

tag2 = Tag.new({"name" => "Entertainment"})
tag2.save()

merchant1 = Merchant.new({"name" => "Waitrose"})
merchant1.save()

merchant2 = Merchant.new({"name" => "Dominion"})
merchant2.save()

merchant3 = Merchant.new({"name" => "Footlights"})
merchant3.save()

account1 = Account.new({"name" => "Current", "balance" => "3332.25"})

transaction1 = Transaction.new({"amount" => 24.50, "description" => "2 x cinema tickets and popcorn",
  "merchant_id" => merchant2.id, "tag_id" => tag2.id })
transaction1.save()

binding.pry
nil
