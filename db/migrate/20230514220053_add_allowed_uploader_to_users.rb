class AddAllowedUploaderToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.boolean :allowed_uploader, default: false
    end
  end
end
