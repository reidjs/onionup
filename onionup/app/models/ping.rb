class Ping < ApplicationRecord
    validates :status, presence:true

    belongs_to :site
end
