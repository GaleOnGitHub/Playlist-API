class PlaylistTrack < ActiveRecord::Base
  self.table_name = 'PlaylistTrack'
  #self.primary_key = :PlaylistId #not really, only to make dependent delete work

  belongs_to :playlist, :foreign_key => :PlaylistId
  belongs_to :track, :foreign_key => :TrackId

end
