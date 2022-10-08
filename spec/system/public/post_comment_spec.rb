# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PostComment", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
    visit post_path(@post)
  end

  describe "Public/PostCommentのテスト" do
    let!(:post_comment) {
      create(
        :post_comment,
        comment: "hogehoge",
        post_id: @post.id,
        user_id: @user.id
      )
    }

    context "表示に関するテスト" do
      it "ログインしていない時のフォーム表示" do
        expect(page).to have_content "投稿をブックマークしたり"
        expect(page).to have_link "会員登録", href: new_user_registration_path
      end
      it "コメントが正しく表示されている" do
        sign_in @user
        visit post_path(@post)
        post post_post_comments_path(comment: "hogehoge", user: @user.id, post_id: @post.id), xhr: true
        expect(page).to have_content "hogehoge"
      end
    end
  end
end
