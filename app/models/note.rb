# frozen_string_literal: true

class Note < ApplicationRecord
  default_scope { order(updated_at: :desc, created_at: :desc) }
  belongs_to :user

  validates :note_title, presence: true
end
