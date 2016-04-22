require 'rails_helper'

feature 'Manage todos in the list', :js => true do
  def create_todo(title)
    visit root_path
    fill_in 'todo_title', with: title
    page.execute_script("$('form#new_todo').submit();")

  end
  scenario "We can create new tasks" do
    title = "Catch a few Capybaras"
    create_todo(title)
    expect(page).to have_content(title)
    sleep 2
  end


  scenario 'the counter updates when creating new tasks' do
    title = "Catch a few Capybaras"
    create_todo(title)
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
    sleep 2
  end

  scenario 'the completed counter updates when completing tasks' do
    title = "Catch a few Capybaras"
    create_todo(title)
    expect( page.find(:css, 'span#completed-count').text ).to eq "0"
    check 'todo-1'
    sleep 2
    expect( page.find(:css, 'span#todo-count').text ).to eq "0"
    expect( page.find(:css, 'span#completed-count').text ).to eq "1"
    sleep 2
  end

  scenario "create 3 tasks, finish 2, updates total count, completed count and todo-count " do
    title = "Catch a few Capybaras"
    create_todo(title)
    title = "Let's eat ice cream"
    create_todo(title)
    title = "clean up everyting"
    create_todo(title)
    expect( page.find(:css, 'span#completed-count').text ).to eq "0"
    check 'todo-1'
    check 'todo-2'
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
    expect( page.find(:css, 'span#total-count').text ).to eq "3"
    expect( page.find(:css, 'span#completed-count').text ).to eq "2"
    page.find("#clean-up").click
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
    expect( page.find(:css, 'span#total-count').text ).to eq "1"
    expect( page.find(:css, 'span#completed-count').text ).to eq "0"
    sleep 2
  end

end
