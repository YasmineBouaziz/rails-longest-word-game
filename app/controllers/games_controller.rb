class GamesController < ApplicationController
  def new
    @letters = Array.new(15) { ('A'..'Z').to_a.sample }
  end

  def score
    @guess = params[:guess]
    @letters = params[:letters].split
    @guess_array = @guess.upcase.chars
    letters_match = @guess_array.all? { |l| @guess_array.count(l) <= @letters.count(l) }
    if letters_match
      url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
      api_call = JSON.parse(URI.open(url).read)
      if api_call['found']
        @score = api_call['length']
        @message = 'well done!'
      else
        @score = 0
        @message = "sorry, #{guess} is the wrong answer"
      end
    else
      @score = 0
      @message = 'Sorry the characters are not in the word list'
    end
  end
end
