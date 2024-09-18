class CreateShortenedUrls < ActiveRecord::Migration[7.2]
  def change
    create_table :shortened_urls do |t|
      t.string :origin
      t.string :short

      t.timestamps
    end
  end
end
