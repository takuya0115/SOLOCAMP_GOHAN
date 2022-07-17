class ApplicationController < ActionController::Base
  # ここのログインチェックは管理者にも影響を及ぼす！
  # よってusersフォルダ以下の各種コントラーで実装するとよい！
  #before_action :authenticate_user!, except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    root_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
