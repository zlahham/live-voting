require 'rails_helper'

describe 'Errors Features' do
	describe 'not found page' do
	  it 'should respond with 404 page' do
	    visit '/foo'
	    expect(page).to have_content('Houston we have a problem')
	  end
	end
end