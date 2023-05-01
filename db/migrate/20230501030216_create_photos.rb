class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.string :title
      t.string :uuid
      t.text :description
      t.datetime :captured_at
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
