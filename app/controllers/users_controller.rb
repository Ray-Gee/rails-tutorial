# frozen_string_literal: true

class UsersController < ApplicationController
  # include CsvImport

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render "new"
    end
  end

  def csv_import
    @errors = import(params[:file])
  end

  private
    def import(file)
      csv_header = {
        "氏名" => "name",
        "メールアドレス" => "email"
        }
      # 一括登録で使用するuser配列
      users = []
      # 画面に返すエラー
      errors = []
      # CSVを1行ずつ解析する
      CSV.foreach(file.path, headers: true, skip_blanks: true).with_index(2) do |row, row_number|
        user = User.new
        # csv_headerのキーを基に、hashに変換する
        row_hash = row.to_hash.slice(*csv_header.keys)
        user.attributes = row_hash.transform_keys(&csv_header.method(:[]))
        user.password_digest = "test"
        user.remember_digest = "test"
        logger.debug(user)

        if user.valid?
          users << user
        else
          errors.push({ row_num: row_number, messages: user.errors.full_messages })
        end
        return errors if errors.present?
      end
      # 一括登録
      User.import users
      # byebug()
      # logger.debug("usersのうえ")
      # logger.debug(users)

      # User.insert_all users
      []
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
