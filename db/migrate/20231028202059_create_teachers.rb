class CreateTeachers < ActiveRecord::Migration[7.0]
  def change
    create_table :teachers do |t|
      t.text :fio
      t.text :job_title
      t.json :additional_information, default: ''
      t.timestamps
    end
  end
end
