require "application_system_test_case"

class RecurringTasksTest < ApplicationSystemTestCase
  setup do
    @recurring_task = recurring_tasks(:one)
  end

  test "visiting the index" do
    visit recurring_tasks_url
    assert_selector "h1", text: "Recurring Tasks"
  end

  test "creating a Recurring task" do
    visit recurring_tasks_url
    click_on "New Recurring Task"

    fill_in "Completed At", with: @recurring_task.completed_at
    fill_in "Name", with: @recurring_task.name
    click_on "Create Recurring task"

    assert_text "Recurring task was successfully created"
    click_on "Back"
  end

  test "updating a Recurring task" do
    visit recurring_tasks_url
    click_on "Edit", match: :first

    fill_in "Completed At", with: @recurring_task.completed_at
    fill_in "Name", with: @recurring_task.name
    click_on "Update Recurring task"

    assert_text "Recurring task was successfully updated"
    click_on "Back"
  end

  test "destroying a Recurring task" do
    visit recurring_tasks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Recurring task was successfully destroyed"
  end
end
