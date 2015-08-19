class AddRegisterNumberToStudents < ActiveRecord::Migration
  def change
    add_column :students, :register_number, :string, unique: true
  end
end
