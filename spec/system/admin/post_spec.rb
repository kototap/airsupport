# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @tag = FactoryBot.create(:tag)
    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end

  describe 'Admin/Postのテスト' do
    let!(:post) {
      create(
        :post,
        title: 'hoge',
        body: 'hogehoge',
        airport: 'fuga',
        user_id: @user.id
      )
    }

    describe '投稿一覧画面(admin_posts_path)のテスト' do
      before do
        visit admin_posts_path
      end
      context 'リンクと一覧の表示の確認' do
        it 'admin_posts_pathが"admin/posts"であるか' do
         expect(current_path).to eq('/admin/posts')
        end
        it  '投稿の情報、リンクが表示されているか' do
          expect(page).to have_content "#{post.user.name}"
          expect(page).to have_content "#{post.title}"
          expect(page).to have_link '詳細へ', href: admin_post_path(post)
        end
      end
    end

    describe '投稿詳細画面のテスト' do
      before do
        visit admin_post_path(post)
      end
      context '表示の確認' do
        it 'admin_post_pathが"/admin/posts/:id"であるか' do
         expect(current_path).to eq "/admin/posts/#{post.id}"
        end
        it '投稿内容が表示されているか' do
          expect(page).to have_content "#{post.title}"
          expect(page).to have_content "#{post.body}"
          expect(page).to have_content "#{post.airport}"
          expect(page).to have_content "#{post.tag.name}"
        end
        it 'adminのユーザーページへのが正しく表示されているか' do
          expect(page).to have_link "#{post.user.name}", href: admin_user_path(post.user)
        end
        it 'admin用の投稿削除リンクがあるか' do
          expect(page).to have_link "この投稿を削除する", href: admin_post_path(post)
        end
      end
    end
  end
end