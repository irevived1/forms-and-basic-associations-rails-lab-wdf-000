class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name=(name)
    tmp = Genre.find_or_create_by(name: name)
    self.genre = tmp 
  end

  def genre_name
    self.try(:genre).try(:name)
  end    

  def artist_name=(name)
    tmp = Artist.find_or_create_by(name: name)
    self.artist = tmp
  end

  def artist_name
    self.try(:artist).try(:name)
  end

  def note_contents=(notes)
    notes.reject(&:empty?).each do |x|
      tmp = Note.find_or_create_by(content:x)
      self.notes << tmp
    end
  end

  def note_contents
    self.notes.collect { |x| x.content }
  end

end

