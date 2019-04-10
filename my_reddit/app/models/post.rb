# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
    validates :title, :author_id, presence: true

    has_many :subtags, dependent: :destroy

    has_many :subs,
    through: :subtags,
    source: :sub

    belongs_to(
        :author,
        class_name: 'User',
        foreign_key: :author_id
    )

    has_many :comments

    has_many :votes, as: :votable

    def top_level_comments
        self.comments.where(parent_comment_id: nil)
    end

    def comments_by_parent_id
        comments = Hash.new { |h,k| h[k] = [] }
        self.comments.each do |comment|
            comments[comment.parent_comment_id] << comment
        end
        comments
    end
end
