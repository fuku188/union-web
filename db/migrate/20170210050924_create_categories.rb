class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.timestamps null: false
      t.string :name
    end
  end
end
