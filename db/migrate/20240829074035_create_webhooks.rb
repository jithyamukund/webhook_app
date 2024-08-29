class CreateWebhooks < ActiveRecord::Migration[7.1]
  def change
    create_table :webhooks do |t|
      t.string :url
      t.string :secret_key
      t.boolean :enabled

      t.timestamps
    end
  end
end
