class Content::ContentsController < ApplicationController
  def show
    @resource = Content::Content.find!(params[:id])
  end
end
