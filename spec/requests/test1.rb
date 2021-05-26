require 'rails_helper'

describe 'ログインのテスト' do
  let(:admin) { create(:admin) }

  before do
    visit new_admin_session_path
    sign_in admin
  end

  context '表示内容の確認' do
    it 'URLが正しい' do
      expect(current_path).to eq '/admins/sign_in'
    end
    it 'メールのフォームがある' do
      expect(page).to have_field 'admin[email]'
    end
    it 'パスワードのフォームがある' do
      expect(page).to have_field 'admin[password]'
    end
  end

  context 'ログインのテスト' do
    it 'ログインの成功' do
      fill_in 'admin[email]', with: 'test21@test.com'
      fill_in 'admin[password]', with: 'testtes'
      click_button 'Login'
      expect(current_path).to eq '/admin/items'
    end
  end
end
describe 'ログインのテスト' do
  let(:admin) { create(:admin) }

  before do
    visit new_admin_session_path
    sign_in admin
    fill_in 'admin[email]', with: 'test21@test.com'
    fill_in 'admin[password]', with: 'testtes'
    click_button 'Login'
  end

  context 'ジャンルへの変移' do
    it 'URLが正しい' do
      expect(current_path).to eq '/admin/items'
    end
    it 'ジャンルへのリンクが存在する' do
      expect(page).to have_link "", href: admin_genres_path
    end
    it 'ジャンルへの変移' do
      click_link 'ジャンル一覧'
      expect(current_path).to eq '/admin/genres'
    end
  end
end
describe 'ジャンルの機能' do
  let(:admin) { create(:admin) }

  before do
    visit new_admin_session_path
    sign_in admin
    fill_in 'admin[email]', with: 'test21@test.com'
    fill_in 'admin[password]', with: 'testtes'
    click_button 'Login'
    visit admin_genres_path
  end

  it 'ジャンルのURL' do
    expect(current_path).to eq '/admin/genres'
  end
  it 'ジャンルにフォームがあるか' do
    expect(page).to have_field 'genre[name]'
  end
  it 'ジャンルの新規登録' do
    fill_in 'genre[name]', with: Faker::Lorem.characters(number: 4)
    expect { click_button 'Submit'}.to change( Genre, :count).by(1)
  end
  it '商品一覧へのリンクがある' do
    expect(page).to have_link'', href:admin_items_path
  end
  it '商品一覧への変移' do
    click_link '商品一覧'
    expect(current_path).to eq '/admin/items'
  end
end
describe '商品一覧機能から新規登録へのリンク' do
  let(:admin) { create(:admin) }

  before do
    visit new_admin_session_path
    sign_in admin
    fill_in 'admin[email]', with: 'test21@test.com'
    fill_in 'admin[password]', with: 'testtes'
    click_button 'Login'
  end
  it '商品新規登録へのリンクが存在するか' do
    expect(page). to have_link'', href:new_admin_item_path
  end
  it '商品新規登録画面へのリンク' do
    click_link '+'
    expect(current_path).to eq '/admin/items/new'
  end
end




describe '商品登録画面' do
  let(:admin) { create(:admin) }
  let!(:genre) { create(:genre, name:'ケーキ') }
  let!(:item) { create(:item, genre_id:1, introduction:'yeah', price:'1000', is_active:'true') }
  before do
    visit new_admin_session_path
    sign_in admin
    fill_in 'admin[email]', with: 'test21@test.com'
    fill_in 'admin[password]', with: 'testtes'
    click_button 'Login'
    visit new_admin_item_path
  end
  context '商品登録機能' do
    it '新規登録のためのフォームがあるか' do
      expect(page).to have_field 'item[name]'
      expect(page).to have_field 'item[introduction]'
      expect(page).to have_field 'item[image]'
      expect(page).to have_field 'item[genre_id]'
      expect(page).to have_field 'item[price]'
      expect(page).to have_field 'item[is_active]'
    end
    it '商品の新規登録が行えるか' do
      fill_in 'item[name]', with: 'test'
      fill_in 'item[introduction]', with: 'test'
      select 'ケーキ', from: 'item[genre_id]'
      fill_in 'item[price]', with: '1000'
      choose '販売中'
      expect { click_button 'Submit' }.to change( Item, :count).by(1)
    end
    it '新規登録後に詳細画面に変移するか' do
      fill_in 'item[name]', with: 'test'
      fill_in 'item[introduction]', with: 'test'
      select 'ケーキ', from: 'item[genre_id]'
      fill_in 'item[price]', with: '1000'
      choose '販売中'
      click_button 'Submit'
      expect(current_path).to eq '/admin/items/' + Item.last.id.to_s
    end
    it '新規投稿が商品一覧に表示されているか' do
      fill_in 'item[name]', with: 'umaicake'
      fill_in 'item[introduction]', with: 'test'
      select 'ケーキ', from: 'item[genre_id]'
      fill_in 'item[price]', with: '1000'
      choose '販売中'
      click_button 'Submit'
      visit admin_items_path
      expect(page).to have_content 'umaicake'
    end
  end
end
describe '新規作成2回目' do
  let(:admin) { create(:admin) }
  let!(:genre) { create(:genre, name:'ケーキ') }
  let!(:item) { create(:item, genre_id:1, introduction:'yeah', price:'1000', is_active:'true') }
  
  before do
    visit new_admin_session_path
    sign_in admin
    fill_in 'admin[email]', with: 'test21@test.com'
    fill_in 'admin[password]', with: 'testtes'
    click_button 'Login'
    visit new_admin_item_path
    fill_in 'item[name]', with: 'umaicake'
    fill_in 'item[introduction]', with: 'test'
    select 'ケーキ', from: 'item[genre_id]'
    fill_in 'item[price]', with: '1000'
    choose '販売中'
    click_button 'Submit'
    visit new_admin_item_path
  end
  context '商品登録機能' do
    it '新規登録のためのフォームがあるか' do
      expect(page).to have_field 'item[name]'
      expect(page).to have_field 'item[introduction]'
      expect(page).to have_field 'item[image]'
      expect(page).to have_field 'item[genre_id]'
      expect(page).to have_field 'item[price]'
      expect(page).to have_field 'item[is_active]'
    end
    it '商品の新規登録が行えるか' do
      fill_in 'item[name]', with: 'test'
      fill_in 'item[introduction]', with: 'test'
      select 'ケーキ', from: 'item[genre_id]'
      fill_in 'item[price]', with: '1000'
      choose '販売中'
      expect { click_button 'Submit' }.to change( Item, :count).by(1)
    end
    it '新規登録後に詳細画面に変移するか' do
      fill_in 'item[name]', with: 'test'
      fill_in 'item[introduction]', with: 'test'
      select 'ケーキ', from: 'item[genre_id]'
      fill_in 'item[price]', with: '1000'
      choose '販売中'
      click_button 'Submit'
      expect(current_path).to eq '/admin/items/' + Item.last.id.to_s
    end
    it '新規投稿が商品一覧に表示されているか' do
      fill_in 'item[name]', with: 'oisiicake'
      fill_in 'item[introduction]', with: 'test'
      select 'ケーキ', from: 'item[genre_id]'
      fill_in 'item[price]', with: '1000'
      choose '販売中'
      click_button 'Submit'
      visit admin_items_path
      expect(page).to have_content 'umaicake'
    end
  end
end