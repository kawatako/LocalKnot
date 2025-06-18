categories = [
  { name: '観光' },
  { name: 'グルメ' },
  { name: '体験' },
  { name: 'ショッピング' },
  { name: 'イベント' },
  { name: 'アウトドア' },
  { name: 'その他' }
]

categories.each do |category_params|
  category = Category.find_or_create_by(category_params)
  if category.errors.any?
    puts "カテゴリ「#{category_params[:name]}」の作成に失敗しました: #{category.errors.full_messages.join(', ')}"
  end
end

# 一般ユーザー (is_business = false) を2つ作成
user1 = User.find_or_create_by!(email: 'user1@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.skip_confirmation!
end

user2 = User.find_or_create_by!(email: 'user2@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.skip_confirmation!
end

# プロフィールも作成 (もしあれば)
Profile.find_or_create_by!(user: user1) do |profile|
  profile.user_name = "ユーザー1"
  # profile.introduction = "..."
  # profile.birthdate = ...
end

Profile.find_or_create_by!(user: user2) do |profile|
  profile.user_name = "ユーザー2"
  # profile.introduction = "..."
  # profile.birthdate = ...
end
