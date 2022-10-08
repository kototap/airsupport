# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Bookmarks", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
    sign_in @user
  end

  describe "ブックマークのテスト" do
    before do
      visit post_path(@post)
    end
    context "表示の確認" do
      it "ブックマーク追加のボタンが表示されているか" do
        expect(page).to have_button, href: "/posts/#{@post.id}/bookmarks"
      end
      # it "ブックマーク登録" do
      #   find(".off").click
      #   expect(@post.bookmarks.count).to eq 1
      # end
    end
  end
end
