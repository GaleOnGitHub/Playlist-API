class AddApiKeyReferenceToPlaylist < ActiveRecord::Migration
  def change
    add_reference :playlist, :ApiKey, index: true, foreign_key: true
  end
end
