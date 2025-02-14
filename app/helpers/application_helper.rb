module ApplicationHelper
  def liked_by?(answer)
    current_user&.likes.exists?(answer_id: answer.id)
  end
end
