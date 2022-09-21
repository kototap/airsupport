# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @tag = FactoryBot.create(:tag)
    sign_in @user
  end

  describe 'Postのテスト' do
    let!(:post) { create(:post, title: 'hoge', body: 'hogehoge', airport: 'fuga') }

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
  	 context '投稿処理に関するテスト' do
  	  it '投稿に成功しサクセスメッセージが表示されるか' do
  	    fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
  	    fill_in 'post[body]', with: Faker::Lorem.characters(number:10)
  	    fill_in 'post[airport]', with: Faker::Lorem.characters(number:5)
  	    find("#post_tag_id").find("option[value='1']").select_option
  	    fill_in 'post[address]', with: Faker::Address.full_address
  	    click_button '投稿する'
  	    expect(page).to have_content '投稿しました。'
  	    expect(current_path).to eq(post_path(Post.last))
  	  end
  	  it '投稿に失敗する' do
  	    click_button '投稿する'
  	    expect(page).to have_content 'エラーが発生しました'
  	    expect(current_path).to eq(posts_path)
  	  end
  	  it '下書き保存に成功しサクセスメッセージが表示されるか' do
  	    click_button '下書きに保存'
  	    expect(page).to have_content '下書きを保存しました。'
  	    expect(current_path).to eq(user_path(@user))
  	  end
  	 end
  	end


    describe '投稿一覧画面(posts_path)のテスト' do
      before do
        visit posts_path
      end
      context 'リンクと一覧の表示の確認' do
        it 'posts_pathが"/posts"であるか' do
         expect(current_path).to eq('/posts')
        end
        it  '投稿の情報、リンクが表示されているか' do
          Post.new
          expect(page).to have_link "hoge", href: post_path(Post.last)
          expect(page).to have_link "hogehoge", href: post_path(Post.last)
          expect(page).to have_link Post.last.tag.name, href: search_index_path(tag_id: Post.last.tag.id)
          expect(page).to have_link "fuga", href: search_index_path(airport: "fuga")
          expect(page).to have_link Post.last.user.name, href: user_path(Post.last.user)
        end
      end
    end

    describe '投稿詳細画面のテスト' do
      before do
        Post.new
        visit post_path(Post.last)
      end
      context '投稿の詳細情報、リンクの確認' do
        it 'post_pathが"/posts/Post.id"であるか' do
          expect(current_path).to eq("/posts/#{Post.last.id}")
        end
        it '投稿の内容、リンクが反映されているか' do
          expect(page).to have_content 'hoge'
          expect(page).to have_content 'hogehoge'
          expect(page).to have_link Post.last.tag.name, href: search_index_path(tag_id: Post.last.tag.id)
          expect(page).to have_link "fuga", href: search_index_path(airport: "fuga")
          expect(page).to have_link Post.last.user.name, href: user_path(Post.last.user)
        end
      end
      context 'コメントの確認' do
        it 'コメントフォームがあるか' do
          expect(page).to have_field 'post_comment[comment]'
          expect(page).to have_button '送信する'
        end
        it 'コメントがない時の表示' do
          post_comments = PostComment.new
          unless Post.last.post_comments.presence
            expect(page).to have_content 'まだコメントがありません。'
          end
        end
      end
      context 'ブックマークの確認' do
        it 'ブックマークの件数が表示されているか' do
          expect(page).to have_link "#{Post.last.bookmarks.count}"
        end
      end
    end

  end
end