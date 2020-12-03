#require 'pry'

class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def self.find_or_create_by_name(name_of_song)
    self.find_by_name(name_of_song) || self.create_by_name(name_of_song)
  end

  def self.find_by_name(name_of_song)
    @@all.detect {|c| c.name == name_of_song}
  end

  def self.create_by_name(name_of_song)
    song = self.create
    song.name = name_of_song
    song.save
  end

  def self.new_by_name(name_of_song)
    song = self.new
    song.name = name_of_song
    song
  end

  def self.create
    song = self.new
    song.save
  end

  def save
    @@all << self
    self
  end

  def self.alphabetical
    @@all.uniq.sort_by{|song| song.name}
  end

  def self.new_from_filename(file_name)
    data = file_name.split(" - ")
    artist_name = data[0]
    more_data = data[1].to_s.split(".")
    name = more_data[0]
    song = self.new
    song.name = name
    song.artist_name = artist_name 
    song.save
  end

  def self.create_from_filename(file_name)
    song = self.new_from_filename(file_name)
    song.save
  end

  def self.destroy_all
    @@all.clear
  end
#binding.pry
end
