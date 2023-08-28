class HomepageController < ApplicationController
  def home
    @images = ActiveStorage::Blob.all.select { |f| f.image? && f.success}
  end
end
