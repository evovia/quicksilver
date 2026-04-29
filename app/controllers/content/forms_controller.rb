class Content::FormsController < ApplicationController
  def show
    @resource = Content::Form.find!(params[:id])
  end
end
