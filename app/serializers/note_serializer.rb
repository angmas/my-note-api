class NoteSerializer < ActiveModel::Serializer
  attributes :id, :note_title, :note_detail, :favorite, :created_at, :updated_at
end
