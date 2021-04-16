class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus do |t|
    	t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
