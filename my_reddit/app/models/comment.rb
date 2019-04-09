# == Schema Information
#
# Table name: comments
#
#  id         :bigint(8)        not null, primary key
#  content    :string           not null
#  author_id  :integer          not null
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord

    validates :content, :author_id, :post_id, presence: true
    
    belongs_to :author,
    class_name: :User,
    foreign_key: :author_id

    belongs_to :post
end
