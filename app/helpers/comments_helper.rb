module CommentsHelper
  def comment_name(comment)
    if comment.member.facilitator.name
      comment.member.facilitator.name
    else
      comment.member.email
    end
  end
end
