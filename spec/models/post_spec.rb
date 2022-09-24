# frozen_string_literal: true

require "rails_helper"

RSpec.describe Post, "モデルに関するテスト", type: :model do
  describe "実際に保存してみる" do
    it "有効な内容の場合は保存されるか" do
      expect(FactoryBot.build(:post)).to be_valid
    end
  end
  context "空白のバリデーションチェック" do
    it "タイトルが空白のバリデーションチェック" do
      post = Post.new(
        title: "",
        body: "hogehoge",
        airport: "hoge",
      )
      if post.save
        expect(post).to be_invalid
        byebug
        expect(post.errors[:title]).to include("タイトルを入力してください")
      end
    end
    it "コメントが空白のバリデーション" do
      post = Post.new(
        title: "hoge",
        body: "",
        airport: "hoge",
      )
      if post.save
        expect(post).to be_invalid
        byebug
        expect(post.errors[:body]).to include("コメントを入力してください")
      end
    end
    it "空港が空白のバリデーション" do
      post = Post.new(
        title: "hoge",
        body: "hogehoge",
        airport: "",
      )
      if post.save
        expect(post).to be_invalid
        byebug
        expect(post.errors[:airport]).to include("空港名を入力してください")
      end
    end
    it "タグが空白のバリデーション" do
      post = Post.new(
        title: "hoge",
        body: "hogehoge",
        airport: "hoge",
        tag_id: nil
      )
      if post.save
        expect(post).to be_invalid
        byebug
        expect(post.errors[:tag]).to include("タグを入力してください")
      end
    end
  end
  context "文字数のバリデーション" do
    it "タイトルが20字以上のバリデーション" do
      post = Post.new(
        title: "hogehogehogehogehoge",
        body: "hogehoge",
        airport: "hoge"
      )
      if post.save
        expect(post).to be_invalid
        expect(post.errors[:title]).to include("タイトルは20文字以内で入力してください")
      end
    end
    it "コメントが80字以上のバリデーション" do
      post = Post.new(
        title: "hoge",
        body: "hogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehoge",
        airport: "hoge"
      )
      if post.save
        expect(post).to be_invalid
        expect(post.errors[:body]).to include("コメントは80文字以内で入力してください")
      end
    end
  end
end
