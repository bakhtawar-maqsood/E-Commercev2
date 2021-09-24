# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'ffaker'
5.times do |i|
  @t = User.create(name: FFaker::Name.name, email: FFaker::Internet.unique.email, cnic: "25202-2246788-9", phone_no: "0320-6666666", address: FFaker::Address.street_address, password: "123456")
  3.times do |j|
    @product = Product.new(name: FFaker::Name.name, serial_no: "pk-00#{i}000#{j}", price: 1000, user_id: @t.id)
    @product.images.attach(io: File.open('app/assets/images/logo.png'), filename: "logo.png",content_type: 'image/png')
    @product.save
  end
end
