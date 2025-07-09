class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.references :event, null: false, foreign_key: true
      t.string :name
      t.string :category
      t.string :status

      t.timestamps
    end
  end
end
