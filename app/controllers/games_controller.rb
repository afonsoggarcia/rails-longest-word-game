require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @word = params[:word].split("")
    @letters = params[:letters]
    array = []
    @word.each do |letter|
      array << @letters.slice!(letter)
    end
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    response = URI.open(url).read
    json = JSON.parse(response)
    check = json['found']
    if array == @word
      check == true ? @result = 'Word is valid' : @result = 'Word is not valid'
    else
      @result = 'Sorry'
    end
  end
end
