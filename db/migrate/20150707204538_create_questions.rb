class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.column :title, :string
      t.column :description, :string
      t.column :category_id, :integer
      t.column :user_id, :integer
      t.timestamps
    end
  end
end
