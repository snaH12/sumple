# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]
  
  def after_sign_in_path_for(resource)
   root_path
  end

  def after_sign_out_path_for(resource)
   new_customer_session_path
  end
  
  private
  
  def customer_params
    #カスタマーの情報は、姓・名・セイ・メイ・メールアドレス・郵便番号・住所・電話番号・会員ステータス
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :post_code, :address, :phone_number, :is_deleted)
  end

  
  protected
　# 退会しているかを判断するメソッド
  def customer_state
    #find_by:IDをもとに検索を行うfind メソッドに対し、ID 以外のカラムからも検索を行い該当する1件を取得するメソッド
    ##入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@customer
    #取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    #volid_password:特定のアカウントのパスワードと入力されたパスワードが一致しているかを確認するためのDeviseが用意しているメソッド
    #特定したアカウントの会員ステータスがtrue(退会済み)と等しい
    if @customer.valid_password?(params[:customer][:password]) && (@customer.is_deleted == true)
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
      #新規会員登録画面へ
       redirect_to new_customer_registration_path
    end
  end


end
