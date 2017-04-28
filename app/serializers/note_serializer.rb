class NoteSerializer < ActiveModel::Serializer
  attributes :id, :note_title, :note_detail, :favorite
  has_one :user
end
