# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Webhook.create([
                 { url: "https://jsonplaceholder.typicode.com/posts", secret_key: "secret123", enabled: true },
                 { url: "https://api2.example.com/webhook", secret_key: "secret456", enabled: true },
                 { url: "https://api3.example.com/webhook", secret_key: "secret456", enabled: false },
               ])