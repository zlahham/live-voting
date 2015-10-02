class ClearVotes

  def self.call(question)
    question.choices.map{ |choice| choice.votes.destroy_all }
  end

end