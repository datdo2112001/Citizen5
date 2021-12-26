class AddCountToLocals < ActiveRecord::Migration[6.1]
  def change
    add_column :locals, :count, :integer
  end
end
