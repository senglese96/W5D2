class Vote < ApplicationRecord
    validates :value, inclusion: {in: [1, -1]}, presence: true
    
    belongs_to :votable, polymorphic: true
end
