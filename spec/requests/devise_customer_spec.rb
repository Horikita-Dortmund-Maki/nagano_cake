require 'rails_helper'

describe 'ユーザ新規登録のテスト' do
    before do
      visit new_customer_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/sign_up'
      end
      
      it 'emailフォームが表示される' do
        expect(page).to have_field 'customer[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'customer[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'customer[password_confirmation]'
      end
      
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'customer[last_name]', with: 'aa'
        fill_in 'customer[first_name]', with: 'aa'
        fill_in 'customer[last_name_kana]', with: 'aa'
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
 