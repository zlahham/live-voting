require "rails_helper"

feature "Answering questions" do
  before do
    connect
  end


  scenario "A question has not been asked", js: true do
    expect(page).to have_content("No questions has been asked yet")
  end



  scenario "A question has been asked", js: true do
    trigger "event", "question", body: "Do You Like Bananas?"
    expect(page).to have_content("Do You Like Bananas?")
  end

  protected

  def trigger(channel, event, data)
    Pusher.trigger(channel, event, data)
  end
end
