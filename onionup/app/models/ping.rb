class Ping < ApplicationRecord
    validates_inclusion_of :status, in: [true, false]

    belongs_to :site
end
