class CreateTemps < ActiveRecord::Migration[7.1]
  def change
    create_table :temps do |t|
      t.string :message
      t.string :slug

      t.timestamps
    end
  end
end
