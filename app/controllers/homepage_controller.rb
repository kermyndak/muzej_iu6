class HomepageController < ApplicationController
  def home
    @images = ActiveStorage::Blob.all.select { |f| f.content_type.include?('image/') && f.success}
  end
end
