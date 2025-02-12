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
