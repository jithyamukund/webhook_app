class Entry < ApplicationRecord
  validates :name, :data, presence: true
end
