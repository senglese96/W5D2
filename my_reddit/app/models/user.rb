# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord

    validates :password, length: { minimum: 6, allow_nil: true }
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true

    after_initialize :ensure_session_token
    attr_reader :password

    has_many :subs,
    foreign_key: :moderator_id,
    class_name: :Sub

    has_many(
        :authored_posts,
        class_name: 'Post',
        foreign_key: :author_id
    )
    
    has_many :comments,
    foreign_key: :author_id,
    class_name: :Comment
    
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def valid_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def generate_session_token
        SecureRandom.urlsafe_base64
    end

    def ensure_session_token
        self.session_token ||= generate_session_token
    end

    def reset_session_token!
        self.session_token = generate_session_token
        self.save!
        self.session_token
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && user.valid_password?(password)
            user
        else
            nil
        end
    end

end
