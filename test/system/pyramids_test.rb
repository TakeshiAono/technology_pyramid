require "application_system_test_case"

class PyramidsTest < ApplicationSystemTestCase
  setup do
    @pyramid = pyramids(:one)
  end

  test "visiting the index" do
    visit pyramids_url
    assert_selector "h1", text: "Pyramids"
  end

  test "creating a Pyramid" do
    visit pyramids_url
    click_on "New Pyramid"

    fill_in "Name", with: @pyramid.name
    check "Public flag" if @pyramid.public_flag
    fill_in "Technology", with: @pyramid.technology_id
    click_on "Create Pyramid"

    assert_text "Pyramid was successfully created"
    click_on "Back"
  end

  test "updating a Pyramid" do
    visit pyramids_url
    click_on "Edit", match: :first

    fill_in "Name", with: @pyramid.name
    check "Public flag" if @pyramid.public_flag
    fill_in "Technology", with: @pyramid.technology_id
    click_on "Update Pyramid"

    assert_text "Pyramid was successfully updated"
    click_on "Back"
  end

  test "destroying a Pyramid" do
    visit pyramids_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pyramid was successfully destroyed"
  end
end
