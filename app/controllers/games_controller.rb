class GamesController < ApplicationController
  def new
    @letters = []
    alphabet = ('A'..'Z').to_a
    10.times { @letters.push << alphabet[rand(26)] }
    @letters = @letters.join
  end

  def score
    raise
    @attempt = params[:attempt]
    @letters = params[:letters].split('')
    if not_valid?(@attempt, @letters)
      @response = 'Those letters are not in the grid!'
    else
      url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
      serialized = open(url).read
      dict = JSON.parse(serialized)
      @response = dict['found'] ? 'Well Done!' : "That's not an english word!"
    end
  end

  def not_valid?(attempt, grid)
    attempt.chars do |letter|
      return true unless grid.include?(letter.upcase)

      index = grid.index(letter.upcase)
      grid.delete_at(index)
    end
    false
  end
end
