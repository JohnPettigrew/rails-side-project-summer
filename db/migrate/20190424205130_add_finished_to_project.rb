class AddFinishedToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :finished, :datetime
  end
end
