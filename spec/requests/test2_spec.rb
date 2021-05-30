# frozen_string_literal: true

require 'rails_helper'

describe 'トップページ' do
  before do
    visit root_path
  end
  it 'トップページに新規登録へのリンクがある' do
    expect(page).to have_link '', href: new_customer_registration_path
  end
  it '新規登録画面への変移' do
    click_link '新規登録'
    expect(current_path).to eq '/customers/sign_up'
  end
end
describe 'ユーザ新規登録のテスト' do
  before do
    visit new_customer_registration_path
  end

  context '表示内容の確認' do
    it 'URLが正しい' do
      expect(current_path).to eq '/customers/sign_up'
    end

    it 'emailフォームが表示される' do
      expect(page).to have_field 'customer[last_name]'
      expect(page).to have_field 'customer[first_name]'
      expect(page).to have_field 'customer[last_name_kana]'
      expect(page).to have_field 'customer[first_name_kana]'
      expect(page).to have_field 'customer[email]'
      expect(page).to have_field 'customer[password]'
      expect(page).to have_field 'customer[password_confirmation]'
      expect(page).to have_field 'customer[postal_code]'
      expect(page).to have_field 'customer[address]'
      expect(page).to have_field 'customer[telephone_number]'
    end
  end

  context '新規登録成功のテスト' do
    before do
      fill_in 'customer[last_name]', with: Faker::Games::Pokemon.name
      fill_in 'customer[last_name_kana]', with: 'aa'
      fill_in 'customer[first_name]', with: Faker::Games::Pokemon.name
      fill_in 'customer[first_name_kana]', with: 'aa'
      fill_in 'customer[email]', with: Faker::Internet.email
      fill_in 'customer[postal_code]', with: '1111111'
      fill_in 'customer[address]', with: 'tokyo'
      fill_in 'customer[telephone_number]', with: '11111111111'
      fill_in 'customer[password]', with: 'password'
      fill_in 'customer[password_confirmation]', with: 'password'
    end

    it '正しく新規登録される' do
      expect { click_button '新規登録' }.to change(Customer.all, :count).by(1)
    end
    it '新規登録後のリダイレクト先が、商品一覧画面になっている' do
      click_button '新規登録'
      expect(current_path).to eq '/items'
    end
  end
end
describe '会員画面テスト' do
  let!(:genre) { create(:genre, name: 'ケーキ') }
  let!(:item) { create(:item, genre_id: 1, name: 'イチゴケーキ', introduction: 'yeah', price: '1000', is_active: 'true') }
  let(:cart_item) { create(:cart_item, customer_id: 1) }
  let(:order) { create(:order, customer_id: 1, shopping_cost: 800) }
  before do
    visit new_customer_registration_path
    fill_in 'customer[last_name]', with: Faker::Games::Pokemon.name
    fill_in 'customer[last_name_kana]', with: 'aa'
    fill_in 'customer[first_name]', with: Faker::Games::Pokemon.name
    fill_in 'customer[first_name_kana]', with: 'aa'
    fill_in 'customer[email]', with: Faker::Internet.email
    fill_in 'customer[postal_code]', with: '1111111'
    fill_in 'customer[address]', with: 'tokyo'
    fill_in 'customer[telephone_number]', with: '11111111111'
    fill_in 'customer[password]', with: 'password'
    fill_in 'customer[password_confirmation]', with: 'password'
    click_button '新規登録'
  end
  it 'ホームへのリンクがあるか' do
    expect(page).to have_link '', href: root_path
  end
  it 'トップ画面の新着の画像のリンクが正しい' do
    visit root_path
    expect(page).to have_link '', href: item_path(item)
  end
  it '商品詳細画面' do
    visit item_path(item)
    expect(current_path).to eq '/items/1'
  end
  it 'カートに入れる' do
    visit item_path(item)
    select '2', from: 'cart_item[amount]'
    click_button 'カートに入れる'
    expect(current_path).to eq '/cart_items/1'
  end
  it '情報入力画面への変移' do
    visit item_path(item)
    select '2', from: 'cart_item[amount]'
    click_button 'カートに入れる'
    click_link '情報入力に進む'
    expect(current_path).to eq '/orders/new'
  end
end
