require 'test_helper'

class RecurringTasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recurring_task = recurring_tasks(:one)
  end

  test "should get index" do
    get recurring_tasks_url
    assert_response :success
  end

  test "should get new" do
    get new_recurring_task_url
    assert_response :success
  end

  test "should create recurring_task" do
    assert_difference('RecurringTask.count') do
      post recurring_tasks_url, params: { recurring_task: { completed_at: @recurring_task.completed_at, name: @recurring_task.name } }
    end

    assert_redirected_to recurring_task_url(RecurringTask.last)
  end

  test "should show recurring_task" do
    get recurring_task_url(@recurring_task)
    assert_response :success
  end

  test "should get edit" do
    get edit_recurring_task_url(@recurring_task)
    assert_response :success
  end

  test "should update recurring_task" do
    patch recurring_task_url(@recurring_task), params: { recurring_task: { completed_at: @recurring_task.completed_at, name: @recurring_task.name } }
    assert_redirected_to recurring_task_url(@recurring_task)
  end

  test "should destroy recurring_task" do
    assert_difference('RecurringTask.count', -1) do
      delete recurring_task_url(@recurring_task)
    end

    assert_redirected_to recurring_tasks_url
  end
end
