class Track < ActiveRecord::Base
  self.table_name = 'Track'
  self.primary_key = 'TrackId'

  has_many :playlist_track, :foreign_key => :PlaylistId
  has_many :playlist, through: :playlist_track, :foreign_key => :PlaylistId
end
