# == Schema Information
#
# Table name: comments
#
#  id                :bigint(8)        not null, primary key
#  content           :string           not null
#  author_id         :integer          not null
#  post_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_comment_id :integer
#

class Comment < ApplicationRecord

    validates :content, :author_id, :post_id, presence: true
    # validates :parent_comment, :child_comments, optional: true

    belongs_to :author,
    class_name: :User,
    foreign_key: :author_id

    belongs_to :post

    belongs_to(
        :parent_comment,
        foreign_key: :parent_comment_id,
        class_name: 'Comment',
        optional: true
    )

    has_many :child_comments,
    foreign_key: :parent_comment_id,
    class_name: :Comment

end
