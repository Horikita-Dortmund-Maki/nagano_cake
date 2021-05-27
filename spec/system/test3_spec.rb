require 'spec_helper'

# RSpec.describe Admin, type: :model do
describe "管理者ログイン後のテスト" do
  let(:admin) { FactoryBot.build(:admin) }

  describe "ログイン画面で管理者がログインした時" do
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'Login'
    end
    it "トップ画面が表示される" do
      expect(current_path).to eq ("/admin/items/index")
    end
  end

describe "注文履歴一覧画面" do
  describe "ヘッダから注文履歴一覧へのリンクを押下した時" do
    it "注文履歴一覧画面が表示される" do
      click_link orders_link
      is_expected.to eq 'admin/order/index'
    end
  end
  before do
    visit admin_orders_path
  end
    describe "前テストでの注文の詳細表示ボタンを押下した時" do
      it "注文詳細画面が表示される" do
        click_link order_show_link
        is_expected.to eq '/admin/order/'+ order.id.to_s
      end
    end
    describe "注文ステータスを「入金確認」にした時" do
      it "注文ステータスが「入金確認」、製作ステータスが「製作待ち」に更新される" do
        click_button status('入金確認')
        expect(find_field('order_details[making_status]')).to eq ('制作待ち')
      end
    end
    describe "製作ステータスを1つ「製作中」にした時" do
      it "注文ステータスが「製作中」に更新される" do
        click_button status('製作中')
        expect(find_field('order_details[making_status]')).to eq ('製作中')
      end
    end
    describe "注文詳細画面。製作ステータスを全て「製作完了」にした時" do
      it "注文ステータスが「発送待ち」に更新される" do
        expect(page).to have_content '製作完了'
        expect(find_field('order[status]')).to eq ('発送待ち')
      end
    end
    describe "注文詳細画面。注文ステータスを「発送済」にした時" do
      it "注文ステータスが「発送済」に更新される" do
        click_button status('発送済')
        expect(find_field('order[status]')).to eq ('発送済')
      end
    end
    describe "注文詳細画面。ヘッダからログアウトボタンを押下した時" do
      it "管理者ログイン画面に遷移する" do
        click_link 'Logout'
        expext(current_path).to eq ('/admin/session')
      end
  end
end



end