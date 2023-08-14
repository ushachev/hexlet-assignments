# frozen_string_literal: true

require 'test_helper'

class PostCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @post_comment = post_comments(:one)
  end

  test 'should create post_comment' do
    assert_difference('PostComment.count') do
      post post_post_comments_url(@post), params: { post_comment: { body: @post_comment.body } }
    end

    assert_redirected_to post_url(@post)
  end

  test 'should get edit' do
    get edit_post_post_comment_url(@post, @post_comment)
    assert_response :success
  end

  test 'should update post_comment' do
    patch post_post_comment_url(@post, @post_comment), params: { post_comment: { body: @post_comment.body } }
    assert_redirected_to post_url(@post)
  end

  test 'should destroy post_comment' do
    assert_difference('PostComment.count', -1) do
      delete post_post_comment_url(@post, @post_comment)
    end

    assert_redirected_to post_url(@post)
  end
end
