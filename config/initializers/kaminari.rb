Kaminari.configure do |config|
  config.default_per_page = 25 # デフォルトの表示件数
  # config.window = 4          # 現在のページの両側に表示するページ数
  # config.outer_window = 0    # 最初と最後のページの両側に表示するページ数
  # config.left = 0            # 最初のページの左側に表示するページ数
  # config.right = 0           # 最後のページの右側に表示するページ数
  # config.page_method_name = :page # ページ番号を指定するメソッド名 (デフォルトは :page)
  # config.param_name = :page        # ページ番号を渡すパラメータ名 (デフォルトは :page)
end
