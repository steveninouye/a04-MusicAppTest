class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :name
      t.integer :band_id
      t.integer :year
      t.boolean :live

      t.timestamps
    end
  end
end
