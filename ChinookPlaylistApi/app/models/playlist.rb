#https://www.coffeepowered.net/2009/01/23/mass-inserting-data-in-rails-without-killing-your-performance/

class Playlist < ActiveRecord::Base
  self.table_name = 'Playlist'
  self.primary_key = 'PlaylistId'

  has_many :playlist_track, :foreign_key => :PlaylistId, :dependent => :destroy
  has_many :track, through: :playlist_track, :foreign_key => :TrackId
  belongs_to :api_key, :foreign_key => :id


  def sync_tracks(data)
    unless data.empty? || data['Tracks'].nil? || data['Tracks'].empty?
      @hash = JSON.parse(data['Tracks'])
      self.playlist_track.delete_all
      ActiveRecord::Base.transaction do #single db transaction for inserts
        self.playlist_track.create(@hash)
      end
    end
  end

  def to_json(options={})
    options[:except] ||= [:ApiKey_id]
    super(options)
  end
end
