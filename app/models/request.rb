class Request < ApplicationRecord
    belongs_to :user
    has_many_attached :images
    has_many_attached :some_files

    # separators - ', ' ' ' '\r\n'
    def parse(links_of_request)
        if (check_string(links_of_request))
            self.links = links_of_request.split("\r\n").map { |string| string.split(', ') }
                .map { |string| string.map { |string| string.split } }
                .reduce(:+).reduce(:+)
                .select { |string| string.match?(/\A(https?|ftp):\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&\/=]*)\z/) }
        end
    end

    private
    def check_string(links_of_request)
        if links_of_request.empty?
            return false
        end
        a = links_of_request.split("\r\n").map { |string| string.split(', ') }
                                          .map { |string| string.map { |string| string.split } }
                                          .reduce(:+).reduce(:+)
        a.map { |string| string.match?(/(https?|ftp):\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&\/=]*)/) }
         .reduce(:|)
    end
end