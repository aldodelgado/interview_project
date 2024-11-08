# Clear existing data
Review.destroy_all
Book.destroy_all
User.destroy_all

# Create Users
users = []
25.times do |i|
  users << User.create!(email: "user#{i + 1}@example.com", password: 'password')
end

# Create Books
books = [
  Book.create!(title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', publication_year: 1925, isbn: '9780743273565'),
  Book.create!(title: 'To Kill a Mockingbird', author: 'Harper Lee', publication_year: 1960, isbn: '9780060935467'),
  Book.create!(title: '1984', author: 'George Orwell', publication_year: 1949, isbn: '9780451524935'),
  Book.create!(title: "The Hitchhiker's Guide to the Galaxy", author: 'Douglas Adams', publication_year: 1979, isbn: '9780345391803'),
  Book.create!(title: 'Code: The Hidden Language of Computer Hardware and Software', author: 'Charles Petzold', publication_year: 1999, isbn: '9780735611313'),
  Book.create!(title: 'Design Patterns: Elements of Reusable Object-Oriented Software', author: 'Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides', publication_year: 1994, isbn: '9780201633610'),
  Book.create!(title: 'The Cat in the Hat', author: 'Dr. Seuss', publication_year: 1957, isbn: '9780394800011'),
  Book.create!(title: 'The Catcher in the Rye', author: 'J.D. Salinger', publication_year: 1951, isbn: '9780316769488'),
  Book.create!(title: 'Of Mice and Men', author: 'John Steinbeck', publication_year: 1937, isbn: '9780140177398'),
  Book.create!(title: 'Lord of the Flies', author: 'William Golding', publication_year: 1954, isbn: '9780399501487'),
  Book.create!(title: 'The Outsiders', author: 'S.E. Hinton', publication_year: 1967, isbn: '9780142407332'),
  Book.create!(title: 'Fahrenheit 451', author: 'Ray Bradbury', publication_year: 1953, isbn: '9781451673319'),
  Book.create!(title: 'Animal Farm', author: 'George Orwell', publication_year: 1945, isbn: '9780451526342'),
  Book.create!(title: 'Brave New World', author: 'Aldous Huxley', publication_year: 1932, isbn: '9780060850524'),
  Book.create!(title: 'Rework', author: '37signals', publication_year: 2010, isbn: '9780307463746'),
  Book.create!(title: 'Accelerate: The Science of Lean Software and DevOps', author: 'Nicole Forsgren, Jez Humble, Gene Kim', publication_year: 2018, isbn: '9781942788331'),
  Book.create!(title: 'The DevOps Handbook', author: 'Gene Kim, Patrick Debois, John Willis, Jez Humble', publication_year: 2016, isbn: '9781942788003'),
  Book.create!(title: 'Pride and Prejudice', author: 'Jane Austen', publication_year: 1813, isbn: '9781503290563'),
  Book.create!(title: 'Moby Dick', author: 'Herman Melville', publication_year: 1851, isbn: '9781503280786'),
  Book.create!(title: 'War and Peace', author: 'Leo Tolstoy', publication_year: 1869, isbn: '9780199232765'),
  Book.create!(title: 'The Odyssey', author: 'Homer', publication_year: -800, isbn: '9780140268867'),
  Book.create!(title: 'The Iliad', author: 'Homer', publication_year: -750, isbn: '9780140275360'),
  Book.create!(title: 'Hamlet', author: 'William Shakespeare', publication_year: 1600, isbn: '9781451669411'),
  Book.create!(title: 'Frankenstein', author: 'Mary Shelley', publication_year: 1818, isbn: '9780486282114'),
  Book.create!(title: 'The Divine Comedy', author: 'Dante Alighieri', publication_year: 1320, isbn: '9780140448955'),
  Book.create!(title: 'Don Quixote', author: 'Miguel de Cervantes', publication_year: 1605, isbn: '9780060934347'),
  Book.create!(title: 'A Tale of Two Cities', author: 'Charles Dickens', publication_year: 1859, isbn: '9780486417769'),
  Book.create!(title: 'Meditations', author: 'Marcus Aurelius', publication_year: 180, isbn: '9780140449334'),
  Book.create!(title: 'The Pragmatic Programmer', author: 'Andrew Hunt, David Thomas', publication_year: 1999, isbn: '9780201616224'),
  Book.create!(title: 'Clean Code: A Handbook of Agile Software Craftsmanship', author: 'Robert C. Martin', publication_year: 2008, isbn: '9780132350884'),
  Book.create!(title: 'Refactoring: Improving the Design of Existing Code', author: 'Martin Fowler', publication_year: 1999, isbn: '9780201485677'),
  Book.create!(title: 'You Don’t Know JS: Scope & Closures', author: 'Kyle Simpson', publication_year: 2014, isbn: '9781449335588'),
  Book.create!(title: 'JavaScript: The Good Parts', author: 'Douglas Crockford', publication_year: 2008, isbn: '9780596517748'),
  Book.create!(title: 'Head First Design Patterns', author: 'Eric Freeman, Bert Bates', publication_year: 2004, isbn: '9780596007126'),
  Book.create!(title: 'Eloquent JavaScript', author: 'Marijn Haverbeke', publication_year: 2011, isbn: '9781593275846'),
  Book.create!(title: 'Effective Java', author: 'Joshua Bloch', publication_year: 2001, isbn: '9780134685991'),
  Book.create!(title: 'The Mythical Man-Month: Essays on Software Engineering', author: 'Frederick P. Brooks Jr.', publication_year: 1975, isbn: '9780201835953'),
  Book.create!(title: 'Introduction to Algorithms', author: 'Thomas H. Cormen, Charles E. Leiserson, Ronald L. Rivest, Clifford Stein', publication_year: 2009, isbn: '9780262033848'),
  Book.create!(title: 'Patterns of Enterprise Application Architecture', author: 'Martin Fowler', publication_year: 2002, isbn: '9780321127426'),
  Book.create!(title: 'The Art of Computer Programming, Vol. 1', author: 'Donald E. Knuth', publication_year: 1968, isbn: '9780201896831'),
  Book.create!(title: 'Don’t Make Me Think: A Common Sense Approach to Web Usability', author: 'Steve Krug', publication_year: 2000, isbn: '9780321344755'),
  Book.create!(title: 'Grokking Algorithms', author: 'Aditya Bhargava', publication_year: 2016, isbn: '9781617292231'),
  Book.create!(title: 'Soft Skills: The software developer’s life manual', author: 'John Sonmez', publication_year: 2014, isbn: '9781617292392'),
  Book.create!(title: 'The Art of War', author: 'Sun Tzu', publication_year: -500, isbn: '9781599869773')
]

# Create Reviews
reviews = []
books.each do |book|
  rand(1..6).times do
    user = users.sample
    rating = rand(1..5)
    content = [
      "An insightful read!",
      "I learned so much!",
      "A true classic.",
      "Highly recommended!",
      "Couldn’t put it down.",
      "An absolute page-turner! I couldn't put it down.",
      "Quick and fun! Perfect for a weekend read.",
      "Interesting ideas but felt a bit uneven in places.",
      "Had me in tears. Beautifully written!",
      "Hits all the right notes for fans of the genre.",
      "Surprised me! Way better than I expected.",
      "Thought-provoking and layered. Worth a deeper look.",
      "Great for getting lost in a whole new world!",
      "Realistic characters and relatable situations.",
      "Fast-paced and easy to pick up anytime.",
      "Sweet, heartfelt, and filled with memorable moments.",
      "Kept me guessing until the very last page!",
      "I wasn’t convinced at first, but it totally won me over.",
      "Edge-of-your-seat suspense. I couldn’t read fast enough.",
      "Beautiful language and poetic moments throughout.",
      "Rich in detail and true to its time period.",
      "Epic world-building! I felt like I was right there.",
      "Smart and visionary—a true sci-fi classic.",
      "Laugh-out-loud funny! Perfect for lighthearted reading.",
      "Uplifting and inspiring, left me feeling hopeful."
    ].sample
    unless Review.exists?(user: user, book: book)
      reviews << Review.create!(user: user, book: book, rating: rating, content: content)
    end
  end
end

puts "Seed data loaded successfully!"
puts "#{User.count} users, #{Book.count} books, and #{Review.count} reviews created."
