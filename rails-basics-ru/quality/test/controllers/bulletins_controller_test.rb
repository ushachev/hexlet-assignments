# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get bulletins_url

    assert_response :success
    assert_select 'h1', 'Bulletins'
  end

  test 'should open one bulletin page' do
    bulletin = bulletins(:bulletin1)
    get bulletin_url(bulletin)

    assert_response :success
    assert_select 'h1', 'Bulletin page'
    assert_select 'h4', bulletin.title
    assert_select 'p', bulletin.body
  end
end
