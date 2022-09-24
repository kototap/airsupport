# frozen_string_literal: true

require "rails_helper"

RSpec.describe PostComment, "モデルに関するテスト", type: :model do
  describe "実際に投稿してみる" do
    it "有効な内容な場合は投稿されるか" do
      expect(FactoryBot.build(:post_comment)).to be_valid
    end
  end
  context "バリデーションチェック" do
    it "コメントが空白の時" do
      post_comment = PostComment.new(
        comment: ""
      )
      if post_comment.save
        expect(post_comment).to be_invalid
        expect(post_comment.errors[:comment]).to include("コメントを入力してください")
      end
    end
    it "コメントが30文字以上の時" do
      post_comment = PostComment.new(
        comment: "hogehogehogehogehogehogehogehoge"
      )
      if post_comment.save
        expect(post_comment).to be_invalid
        expect(post_comment.errors[:comment]).to include("コメントは30文字以内で入力してください")
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(PostComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(PostComment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end