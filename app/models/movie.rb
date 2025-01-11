class Movie < ApplicationRecord
  has_many :bookmarks

  valdiates :title, presence: true, uniqueness: true
  valdiates :overview, presence: true, uniqueness: true

  before_destroy :check_for_bookmarks

  private

  def check_for_bookmarks
    if bookmarks.count.positive?
      errors.add(:base, "Cannot delete movie while it has bookmarks")
      throw :abort
    end
  end
end
