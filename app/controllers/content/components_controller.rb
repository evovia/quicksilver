class Content::ComponentsController < ApplicationController
  def index
    @resources = Content::Component.all
  end

  def show
    @resource = Content::Component.find!(params[:id])
  end
end
