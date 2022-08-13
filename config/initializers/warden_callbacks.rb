Warden::Manager.after_authentication do |user, auth, opts|
  if user.sign_in_count.zero?
    # 初回ログイン時のみ行いたい処理
    redirect_to top_my_pages_path
  end
end