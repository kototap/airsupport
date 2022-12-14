# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Posts", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @tag = FactoryBot.create(:tag)
    sign_in @user
  end

  describe "Public/Postのテスト" do
    let!(:post) {
      create(
        :post,
        title: "hoge",
        body: "hogehoge",
        airport: "fuga",
        user_id: @user.id,
        tag_id: @tag.id
      )
    }

    describe "新規投稿画面(new_post_path)のテスト" do
      before do
        visit new_post_path
      end
      context "リンクとフォームの表示の確認" do
        it 'new_post_pathが"/posts/new"であるか' do
          expect(current_path).to eq("/posts/new")
        end
        it "投稿フォームが正しく表示されているか" do
          expect(page).to have_field "post[post_image]"
          expect(page).to have_field "post[title]"
          expect(page).to have_field "post[body]"
          expect(page).to have_field "post[airport]"
          expect(page).to have_unchecked_field
          expect(page).to have_field "post[address]"
          expect(page).to have_button "投稿する"
          expect(page).to have_button "下書きに保存"
        end
      end
      context "投稿処理に関するテスト" do
        it "投稿に成功しサクセスメッセージが表示されるか" do
          fill_in "post[title]", with: Faker::Lorem.characters(number: 5)
          fill_in "post[body]", with: Faker::Lorem.characters(number: 10)
          fill_in "post[airport]", with: Faker::Lorem.characters(number: 5)
          fill_in "post[address]", with: Faker::Address.full_address
          click_button "投稿する"
          expect(page).to have_content "投稿しました。"
          expect(current_path).to eq(post_path(Post.last))
        end
        it "投稿に失敗した時" do
          click_button "投稿する"
          expect(page).to have_content "エラーが発生しました"
          expect(current_path).to eq(posts_path)
        end
        it "下書き保存に成功しサクセスメッセージが表示されるか" do
          click_button "下書きに保存"
          expect(page).to have_content "下書きを保存しました。"
          expect(current_path).to eq(user_path(@user))
        end
      end
    end


    describe "投稿一覧画面(posts_path)のテスト" do
      before do
        visit posts_path
      end
      context "リンクと一覧の表示の確認" do
        it 'posts_pathが"/posts"であるか' do
          expect(current_path).to eq("/posts")
        end
        it "新しい順に並び替えるリンクが表示されている" do
          expect(page).to have_link "新しい順", href: posts_path(latest: "true")
        end
        it "ブックマーク順に並び替えるリンクが表示されている" do
          expect(page).to have_link "ブックマーク順", href: posts_path(popular: "true")
        end
        it "投稿の情報、リンクが表示されているか" do
          expect(page).to have_link "hoge", href: post_path(post)
          expect(page).to have_link "hogehoge", href: post_path(post)
          expect(page).to have_link "fuga", href: posts_path(airport: "fuga")
          expect(page).to have_link post.user.name, href: user_path(post.user)
        end
      end
    end

    describe "投稿詳細画面のテスト" do
      before do
        visit post_path(post)
      end
      context "投稿の詳細情報、リンクの確認" do
        it 'post_pathが"/posts/Post.id"であるか' do
          expect(current_path).to eq("/posts/#{post.id}")
        end
        it "投稿の内容、リンクが反映されているか" do
          expect(page).to have_content "hoge"
          expect(page).to have_content "hogehoge"
          expect(page).to have_link "fuga", href: posts_path(airport: "fuga")
          expect(page).to have_link post.user.name, href: user_path(post.user)
        end
      end
      context "コメントの確認" do
        it "コメントフォームがあるか" do
          expect(page).to have_field "post_comment[comment]"
          expect(page).to have_button "送信する"
        end
        it "コメントがない時の表示" do
          unless post.post_comments.presence
            expect(page).to have_content "まだコメントがありません。"
          end
        end
      end
      context "ブックマークの確認" do
        it "ブックマークの件数が表示されているか" do
          expect(page).to have_link "#{post.bookmarks.count}"
        end
      end
    end

    describe "下書きのテスト" do
      before do
        post.update(is_draft: true)
      end
      context "下書きの一覧画面のテスト" do
        before do
          visit draft_index_posts_path
        end
        it 'draft_index_postsが"/posts/draft_index"であるか' do
          expect(current_path).to eq("/posts/draft_index")
        end
        it "下書きの投稿が表示されていて、リンクが正しいか" do
          post.update(is_draft: true)
          visit draft_index_posts_path
          expect(page).to have_content "hoge"
          expect(page).to have_content "hogehoge"
          expect(page).to have_link "fuga", href: posts_path(airport: "fuga")
          expect(page).to have_link post.user.name, href: user_path(post.user)
        end
      end
    end

    describe "編集画面のテスト" do
      before do
        visit edit_post_path(post.id)
      end
      context "表示の確認" do
        it 'edit_post_pathが"/posts/:id/edit"である' do
          expect(current_path).to eq("/posts/#{post.id}/edit")
        end
        it "投稿者とログインユーザーが異なる時のリダイレクト先が正しいか" do
          unless @user = post.user
            expect(current_path).to eq("/posts")
          end
        end
        it "編集前の投稿の内容がフォームにセットされている" do
          expect(page).to have_field "post[post_image]"
          expect(page).to have_field "post[title]", with: post.title
          expect(page).to have_field "post[body]", with: post.body
          expect(page).to have_field "post[airport]", with: post.airport
          expect(page).to have_field "post[address]", with: post.address
        end
        it "公開されている投稿の場合のボタンとリンク" do
          expect(page).to have_button "更新"
          expect(page).to have_link "戻る", href: post_path(post)
        end
        it "下書き投稿の場合、下書きを公開ボタンが表示される" do
          post.update(is_draft: true)
          visit edit_post_path(post.id)
          expect(page).to have_button "下書きを公開"
          expect(page).to have_button "下書きのまま更新"
        end
      end
      context "更新処理に関するテスト" do
        it "公開されている投稿の更新後のリダイレクト先が投稿詳細ページか" do
          fill_in "post[title]", with: Faker::Lorem.characters(number: 5)
          click_button "更新"
          expect(current_path).to eq(post_path(post))
        end
        it "下書き投稿を下書きのまま更新した場合のリダイレクト先が投稿詳細ページか" do
          post.update(is_draft: true)
          visit edit_post_path(post.id)
          click_button "下書きのまま更新"
          expect(current_path).to eq(post_path(post))
        end
        it "下書きを公開した時のリダイレクト先が投稿詳細ページか" do
          post.update(is_draft: true)
          visit edit_post_path(post.id)
          click_button "下書きを公開"
          expect(current_path).to eq(post_path(post))
        end
      end
    end
  end
end
