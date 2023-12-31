class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.text :message
      t.text :links, array: true, default: []
      t.boolean :read, default: false
      t.belongs_to :user

      t.timestamps
    end
  end
end
