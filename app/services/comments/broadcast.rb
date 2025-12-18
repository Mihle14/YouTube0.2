# Handles broadcasting the comment creation and deletion updates for the posts

module Comments
  class Broadcast
    def self.created(comment)
      comment.broadcast_append_to [comment.post, :comments], target: "comments"
    end

    def self.deleted(comment)
      comment.broadcast_remove_to [comment.post, :comments]
    end
  end
end
