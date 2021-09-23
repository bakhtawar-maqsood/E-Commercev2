# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@user1 = User.create(name: "xyz", email: "xyz@gmail.com", cnic: "25202-2246788-9", phone_no: "0320-6666666", address: "abcdefghijklmnopqrstuvwxyz", password: "123456")
@user2 = User.create(name: "xyz", email: "abc@gmail.com", cnic: "25202-2246788-9", phone_no: "0320-6666666", address: "abcdefghijklmnopqrstuvwxyz", password: "123456")
@user3 = User.create(name: "xyz", email: "abcd@gmail.com", cnic: "25202-2246788-9", phone_no: "0320-6666666", address: "abcdefghijklmnopqrstuvwxyz", password: "123456")
@user4 = User.create(name: "xyz", email: "abcde@gmail.com", cnic: "25202-2246788-9", phone_no: "0320-6666666", address: "abcdefghijklmnopqrstuvwxyz", password: "123456")


Product.create(name: "abc", serial_no:"pk-0001001", price: 1000, description: "bghsadgjsahcfbklsdjvkgs", user_id: @user1.id)
Product.create(name: "abc", serial_no:"pk-0001002", price: 1000, description: "bghsadgjsahcfbklsdjvkgs", user_id: @user1.id)
Product.create(name: "abc", serial_no:"pk-0001003", price: 1000, description: "bghsadgjsahcfbklsdjvkgs", user_id: @user2.id)
Product.create(name: "abc", serial_no:"pk-0001004", price: 1000, description: "bghsadgjsahcfbklsdjvkgs", user_id: @user4.id)
Product.create(name: "abc", serial_no:"pk-0001005", price: 1000, description: "bghsadgjsahcfbklsdjvkgs", user_id: @user3.id)
Product.create(name: "abc", serial_no:"pk-0001006", price: 1000, description: "bghsadgjsahcfbklsdjvkgs", user_id: @user3.id)
