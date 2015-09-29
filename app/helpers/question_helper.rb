module QuestionHelper

  def any_votes? question
    votes = false

    question.choices.each do |choice|
      votes = true if choice.votes.any?
    end

    votes
  end

  def total_votes question
    vote_count = 0
    question.choices.each do |choice|
      vote_count += choice.votes.count
    end
    vote_count
  end
end
