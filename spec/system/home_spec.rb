# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Homes", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @admin = FactoryBot.create(:admin)
  end

  describe "ログイン時トップ画面のテスト" do
    before do
      sign_in @user
      visit root_path
    end
    context "ヘッダーに必要なリンクがあるか" do
      it "検索へのリンク" do
        expect(page).to have_link "検索", href: search_path
      end
      it "マイページへのリンク" do
        expect(page).to have_link "マイページ", href: user_path(@user)
      end
      it "ログアウトへのリンク" do
        expect(page).to have_link "ログアウト", href: destroy_user_session_path
      end
    end
    context "Aboutページ、searchページへのリンクがあるか" do
      it "Aboutへのリンク" do
        expect(page).to have_link "About", href: about_path
      end
      it "Searchへのリンク" do
        expect(page).to have_link "Search", href: search_path
      end
    end
    context "ログアウト後の遷移先" do
      it "ログアウト後の遷移先がnew_user_session_path" do
        click_link "ログアウト"
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe "ログアウト時トップ画面のテスト" do
    before do
      visit root_path
    end
    context "ヘッダーに必要なリンクがあるか" do
      it "会員登録へのリンク" do
        expect(page).to have_link "会員登録", href: new_user_registration_path
      end
      it "ログインへのリンク" do
        expect(page).to have_link "ログイン", href: new_user_session_path
      end
      it "ゲストログインへのリンク" do
        expect(page).to have_link "ゲストログイン", href: public_guest_sign_in_path
      end
    end
  end

  describe "管理者側のトップ画面のテスト" do
    before do
      sign_in @admin
      visit root_path
    end
    context "ヘッダーに必要なリンクがあるか" do
      it "会員一覧へのリンク" do
        expect(page).to have_link "会員一覧", href: admin_users_path
      end
      it "投稿一覧へのリンク" do
        expect(page).to have_link "投稿一覧", href: admin_posts_path
      end
      it "タグへのリンク" do
        expect(page).to have_link "タグ", href: admin_tags_path
      end
      it "ログアウトへのリンク" do
        expect(page).to have_link "ログアウト", href: destroy_admin_session_path
      end
    end
    context "ログアウト後の遷移先" do
      it "ログアウト後の遷移先がnew_admin_session_path" do
        click_link "ログアウト"
        expect(current_path).to eq new_admin_session_path
      end
    end
  end
end
