require "application_system_test_case"

class MyPagesTest < ApplicationSystemTestCase
  setup do
    @my_page = my_pages(:one)
  end

  test "visiting the index" do
    visit my_pages_url
    assert_selector "h1", text: "My Pages"
  end

  test "creating a My page" do
    visit my_pages_url
    click_on "New My Page"

    click_on "Create My page"

    assert_text "My page was successfully created"
    click_on "Back"
  end

  test "updating a My page" do
    visit my_pages_url
    click_on "Edit", match: :first

    click_on "Update My page"

    assert_text "My page was successfully updated"
    click_on "Back"
  end

  test "destroying a My page" do
    visit my_pages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "My page was successfully destroyed"
  end
end
