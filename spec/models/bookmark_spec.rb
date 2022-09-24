require 'rails_helper'

RSpec.describe 'モデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { bookmark.valid? }

    let!(:other_bookmark) { create(:bookmark) }
    let(:bookmark) { build(:bookmark) }

    context '1User 1Book 1いいね' do
      it 'あるUserが同じPostをブックマーク出来ないこと' do
        bookmark.user = other_bookmark.user
        bookmark.post = other_bookmark.post
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Bookmark.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(Bookmark.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end