module QuestionHelper

  COLOUR_ARRAY = [
    'progress-bar progress-bar-success',
    'progress-bar progress-bar-info',
    'progress-bar progress-bar-warning',
    'progress-bar progress-bar-danger'
  ]

  def any_votes?(question)
    votes = false
    question.choices.each do |choice|
      votes = true if choice.votes.any?
    end
    votes
  end

  def total_votes(question)
    vote_count = 0
    question.choices.each do |choice|
      vote_count += choice.votes.count
    end
    vote_count
  end

  def graph_colour
    COLOUR_ARRAY.rotate!
    COLOUR_ARRAY[0]
  end
end
