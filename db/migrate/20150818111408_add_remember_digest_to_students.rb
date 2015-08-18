class AddRememberDigestToStudents < ActiveRecord::Migration
  def change
    add_column :students, :remember_digest, :string
  end
end
