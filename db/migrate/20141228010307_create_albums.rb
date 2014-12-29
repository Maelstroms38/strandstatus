class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :user
      t.string :references
      t.string :title

      t.timestamps
    end
  end
end
