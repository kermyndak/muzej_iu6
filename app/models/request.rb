class Request < ApplicationRecord
    belongs_to :user
    has_many_attached :images
    has_many_attached :some_files
end
