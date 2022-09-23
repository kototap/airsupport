# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @admin = FactoryBot.create(:admin)
    sign_in @admin
    visit admin_users_path
  end

  describe 'Admin/Userのテスト' do

    context '会員一覧画面表示のテスト' do
      it 'admin_users_pathが"/admin/usersである"' do
        expect(current_path).to eq '/admin/users'
      end
      it '会員情報が表示されている' do
        expect(page).to have_content "#{@user.name}"
      end
      it '会員詳細画面へのリンクがある' do
        expect(page).to have_link "詳細へ", href: admin_user_path(@user)
      end
    end

    context '会員詳細画面のテスト' do
      before do
        click_link "詳細へ"
      end
      it 'admin_user_pathが"/admin/users/:id"である' do
        expect(current_path).to eq "/admin/users/#{@user.id}"
      end
      it '正しい情報が表示されているか' do
        expect(page).to have_content "#{@user.name}"
        expect(page).to have_content "#{@user.email}"
      end
      it 'リンクが正しく表示されているか' do
        expect(page).to have_link "#{@user.name}さんの投稿一覧", href: "/admin/users/#{@user.id}/posts"
        expect(page).to have_link "編集する", href: edit_admin_user_path(@user)
        expect(page).to have_link "このユーザーを完全に削除する", href: admin_user_path(@user)
      end
    end

    context '会員情報編集画面のテスト' do
      before do
        visit edit_admin_user_path(@user)
      end
      it 'edit_admin_user_path(@user)が"/admin/users/:id/edit"である' do
        expect(current_path).to eq "/admin/users/#{@user.id}/edit"
      end
      it '編集前の内容がフォームにセットされている' do
        expect(page).to have_field 'user[name]', with: @user.name
        expect(page).to have_field 'user[email]', with: @user.email
        expect(page).to have_field 'user[introduction]', with: @user.introduction
      end
      it '有効、利用停止のボタンがあるか' do
        expect(page).to have_checked_field '有効'
        expect(page).to have_unchecked_field '利用停止'
      end
      it '更新ボタンが正しく表示されている' do
        expect(page).to have_button '更新する'
      end
      it '更新後の遷移先が正しいか' do
        click_button '更新する'
        expect(current_path).to eq admin_user_path(@user)
      end
    end
  end
end
