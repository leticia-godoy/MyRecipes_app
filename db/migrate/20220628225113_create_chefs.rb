class CreateChefs < ActiveRecord::Migration[7.0]
  def change
    create_table :chefs do |t|
      t.string :chefs_name
      t.string :email
      t.timestamps
    end
  end
end
