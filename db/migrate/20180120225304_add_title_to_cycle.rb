class AddTitleToCycle < ActiveRecord::Migration[5.1]
  def change
    add_column :cycles, :title, :string
  end
end
