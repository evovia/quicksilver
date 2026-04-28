class Content::ComponentsController < ApplicationController
  def show
    @resource = Content::Component.find!(params[:id])
  end
end
