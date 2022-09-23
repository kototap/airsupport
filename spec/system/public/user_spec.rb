# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    visit user_path(@user)
  end
  describe 'ユーザー詳細画面のテスト' do
    context '表示の確認' do
      it 'user_pathが"/users/:id"である' do
        expect(current_path).to eq "/users/#{@user.id}"
      end
      it 'ブックマークへのリンクがあか' do
        expect(page).to have_link 'ブックマーク', href: "/users/#{@user.id}/bookmarks"
      end
      it '新規投稿へのリンクがあか' do
        expect(page).to have_link '新規投稿', href: new_post_path
      end
      it '下書きへのリンクがあか' do
        expect(page).to have_link '下書き', href: draft_index_posts_path
      end
    end
	end

	describe 'ユーザー編集画面のテスト' do
	  before do
	    visit edit_user_path(@user)
	  end
	  context '編集画面の表示' do
	    it 'edit_user_pathが"/users/:id/edit"である' do
	      expect(current_path).to eq "/users/#{@user.id}/edit"
	    end
	    it '他のユーザーの編集画面に遷移できない' do
	      unless sign_in @user
	        expect(page).to have_content 'プロフィール編集画面へは遷移できません。'
	      end
	    end
	    it '編集前の内容がフォームにセットされている' do
	      expect(page).to have_field 'user[name]', with: @user.name
        expect(page).to have_field 'user[email]', with: @user.email
        expect(page).to have_field 'user[introduction]', with: @user.introduction
	    end
	    it '更新ボタンが正しく表示されている' do
        expect(page).to have_button '更新する'
      end
      it '退会へのリンクが表示されているか' do
        expect(page).to have_link 'こちら', href: user_unsubscribe_path(@user)
      end
	  end
	  context '更新処理について' do
	    it '更新後の遷移先は正しいか' do
	      click_button '更新する'
        expect(current_path).to eq user_path(@user)
        expect(page).to have_content '更新が完了しました！'
	    end
	  end
	  context '退会処理について' do
	    before do
	      visit user_unsubscribe_path(@user)
	    end
	    it 'user_unsubscribe_path(@user)が"/users/:id/unsubscribe"であるか' do
	      expect(current_path).to eq "/users/#{@user.id}/unsubscribe"
	    end
	    it '退会した後の遷移先がroot_pathかどうか' do
	      click_link '退会する', href: user_path(@user)
	      expect(current_path).to eq root_path
	    end
	  end
	end
end