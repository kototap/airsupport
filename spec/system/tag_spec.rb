# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Tags", type: :request do
  before do
    @admin = FactoryBot.create(:admin)      #FactoryBotを利用してadminデータを作成
  end

  describe 'タグのテスト' do
    let!(:tag) { create(:tag, name:'hoge') }

    describe "タグ一覧画面(admin_tags_path)のテスト" do
      before do
        sign_in @admin
        visit admin_tags_path
      end

      context '表示の確認' do
        it 'admin_tags_pathが"admin/tags"であるか' do
          expect(current_path).to eq('/admin/tags')
        end
        it '追加するボタンが表示されているか' do
          expect(page).to have_button '追加する'
        end
      end

      context 'タグ追加処理のテスト' do
        it 'タグ追加後のリダイレクト先は正しいか' do
          fill_in 'tag[name]', with: Faker::Lorem.characters(number:5)
          click_button '追加する'
          expect(page).to have_current_path admin_tags_path
        end
      end

      context '表示の確認' do
        it '追加されたものが表示されているか' do
          expect(page).to have_content tag.name
          expect(page).to have_link '編集する', href: edit_admin_tag_path(tag)
        end
      end
    end

    describe 'タグ編集画面のテスト' do
      before do
        sign_in @admin
        visit edit_admin_tag_path(tag)
      end
      context '表示の確認' do
        it '編集前のタグ名がフォームに表示(セット)されている' do
          expect(page).to have_field 'tag[name]', with: tag.name
        end
        it '更新ボタンが表示される' do
          expect(page).to have_button '更新する'
        end
      end
      context '更新処理に関するテスト' do
        it '更新後のリダイレクト先は正しいか' do
          fill_in 'tag[name]', with: Faker::Lorem.characters(number:5)
          click_button '更新する'
          expect(page).to have_current_path admin_tags_path
        end
      end
    end
  end
end