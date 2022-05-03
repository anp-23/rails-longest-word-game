require 'open-uri'

class GamesController < ApplicationController
  def new
    array = ['A', 'E', 'I', 'O', 'U']
    @letters = Array.new(2) { array.sample }
    @letters += ('A'..'Z').to_a.sample(8)
    @letters.shuffle!
  end

  def score
    @letters = params[:letters]
    @ask = params[:ask].upcase
    @english_word = english_word?(@ask)
    @arrayincluded = arrayincluded?(@ask, @letters)
  end

  private

  def english_word?(word)
    url = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    parse = JSON.parse(url.read)
    parse["found"]
  end

  def arrayincluded?(word, letters)
    word.split.all? { |p| word.count(p) <= letters.count(p)}
  end
end
