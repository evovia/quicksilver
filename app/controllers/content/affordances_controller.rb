class Content::AffordancesController < ApplicationController
  def show
    @resource = Content::Affordance.find!(params[:id])
  end
end
