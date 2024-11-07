# Clear existing data
Review.destroy_all
Book.destroy_all
User.destroy_all

# Create Users
users = [
  User.create!(email: 'user1@example.com', password: 'password'),
  User.create!(email: 'user2@example.com', password: 'password')
]

# Create Books
books = [
  Book.create!(title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', publication_year: 1925, isbn: '9780743273565'),
  Book.create!(title: 'To Kill a Mockingbird', author: 'Harper Lee', publication_year: 1960, isbn: '9780060935467'),
  Book.create!(title: '1984', author: 'George Orwell', publication_year: 1949, isbn: '9780451524935')
]

# Create Reviews
reviews = [
  Review.create!(user: users[0], book: books[0], rating: 5, content: 'An absolute classic!'),
  Review.create!(user: users[1], book: books[0], rating: 4, content: 'A great read, but a bit overhyped.'),
  Review.create!(user: users[0], book: books[1], rating: 5, content: 'A must-read for everyone.'),
  Review.create!(user: users[1], book: books[2], rating: 3, content: 'Interesting ideas, but a bit dark for my taste.')
]

puts "Seed data loaded successfully!"
puts "#{User.count} users, #{Book.count} books, and #{Review.count} reviews created."
