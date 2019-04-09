# == Schema Information
#
# Table name: subs
#
#  id           :bigint(8)        not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  title        :string           not null
#  description  :string           not null
#  moderator_id :integer          not null
#

class Sub < ApplicationRecord
    
    validates :title, :description, :moderator_id, presence: true
    validates :title, uniqueness: true

    belongs_to(
        :moderator,
        class_name: 'User',
        foreign_key: :moderator_id
    )

    has_many(
        :subtags
    )
    has_many :posts,
    through: :subtags,
    source: :post
end
