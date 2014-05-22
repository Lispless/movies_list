require 'sinatra'
require 'csv'

def read_from_movie(csv)
	movies = []
	CSV.foreach(csv, { headers: true, header_converters: :symbol } ) do |row|
		movies << row.to_hash
	end
	movies = movies.sort_by { |movie| movie[:title] }
end

def find_movie(title)
	movies = read_from_movie('movies.csv')
	movie_to_find = nil
	movies.each do |movie|
		movie_to_find = movie if movie[:title].downcase == title.downcase
	end
	movie_to_find
end

get '/movies' do
  @movies = read_from_movie('movies.csv')
  erb :index
end

get '/movies/:title' do
  @movies = find_movie(params[:title])
  erb :show
end