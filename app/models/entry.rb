class Entry < ApplicationRecord
  validates :name, :data, presence: true
  validates :name, uniqueness: true
end
