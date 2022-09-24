# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tag, "モデルに関するテスト", type: :model do
  describe "実際に保存してみる" do
    it "有効な内容の場合は追加されるか" do
      expect(FactoryBot.build(:tag)).to be_valid
    end
  end
  context "バリデーションチェック" do
    it "空白のバリデーションチェック" do
      tag = Tag.new(name: "")
      expect(tag).to be_invalid
      expect(tag.errors[:name]).to include("を入力してください")
    end
    it "10字以上の時のバリデーション" do
      tag = Tag.new(name: "hogehogehoge")
      expect(tag).to be_invalid
      expect(tag.errors[:name]).to include("は10文字以内で入力してください")
    end
  end
end
