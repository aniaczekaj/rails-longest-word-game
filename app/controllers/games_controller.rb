require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = [];
    10.times do
      @letters << ("a".."z").to_a.sample
    end
  end

  def score
    @longest_word = params[:longest_word]
    @result = including(@longest_word)
  end

  def including(longest_word)
    array_longest_word = longest_word.split("")
    array_all_letters = params[:letters].split(" ")
    array_longest_word.each do |letter|
      if array_all_letters.include?(letter)
        @solution = is_an_english_word(longest_word)
      else
        @solution = "Word has to include above letters"
      end
    end
    @solution
  end

  def is_an_english_word(longest_word)
    response = open("https://wagon-dictionary.herokuapp.com/#{longest_word}")
    json = JSON.parse(response.read)
    if !json["found"]
      @msg = "Not a valid english word"
    else
      @msg = "CONGRATULATIONS! #{longest_word.capitalize} is a valid english word"
    end
    @msg
  end
end
