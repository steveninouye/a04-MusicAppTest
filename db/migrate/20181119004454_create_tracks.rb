class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :name
      t.integer :album_id
      t.integer :ord
      t.boolean :bonus
      t.text :lyrics

      t.timestamps
    end
  end
end
