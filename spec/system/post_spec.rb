# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @tag = FactoryBot.create(:tag)
    sign_in @user
  end

  describe 'Postのテスト' do
    let!(:post) { create(:post, title: 'hoge', body: 'hogehoge', airport: 'hoge') }

    describe 'トップ画面(root_path)のテスト' do
      before do
        visit root_path
      end
      context '表示の確認' do
        it 'トップ画面(root_path)に一覧ページへのリンクが表示されているか' do
          expect(page).to have_link "投稿一覧", href: posts_path
        end
        it 'トップ画面(root_path)に新規投稿おエージへのリンクが表示されているか' do
          expect(page).to have_link "新規投稿", href: new_post_path
        end
        it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
        end
      end
  	end

  	describe '新規投稿画面(new_post_path)のテスト' do
  	 before do
  	  visit new_post_path
  	 end
  	 context 'リンクとフォームの表示の確認' do
  	  it 'new_post_pathが"/posts/new"であるか' do
  	    expect(current_path).to eq('/posts/new')
  	  end
  	  it '投稿フォームが正しく表示されているか' do
  	    expect(page).to have_field 'post[post_image]'
  	    expect(page).to have_field 'post[title]'
  	    expect(page).to have_field 'post[body]'
  	    expect(page).to have_field 'post[airport]'
  	    expect(page).to have_field 'post[tag_id]'
  	    expect(page).to have_field 'post[address]'
  	    expect(page).to have_button '投稿する'
  	    expect(page).to have_button '下書きに保存'
  	  end
  	 end
  	 context 
  	end


    describe '投稿一覧画面(posts_path)のテスト' do
      before do
        visit posts_path
      end
      context 'リンクと一覧の表示の確認' do
        it 'posts_pathが"/posts"であるか' do
         expect(current_path).to eq('/posts')
        end
      end
    end
  end
end