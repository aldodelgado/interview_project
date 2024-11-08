class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :publication_year
      t.string :isbn

      t.timestamps
    end

    add_index :books, :title
    add_index :books, :author
    add_index :books, :isbn, unique: true
  end
end
