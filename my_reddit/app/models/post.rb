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
    validates :title, :subtags, :author_id, presence: true

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

end
