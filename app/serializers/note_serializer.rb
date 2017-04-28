class NoteSerializer < ActiveModel::Serializer
  attributes :id, :note_title, :note_detail, :favorite, :editable

  def editable
    scope == object.user
  end
end
