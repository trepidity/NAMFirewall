class NamComponentsController < ApplicationController
  def new
    @component = NamComponent.create(component_params)

    respond_to do |format|
      format.js {}
    end
  end

  def create
    puts "received request for #{request.session_options[:id]}"
    @component = NamComponent.create(component_params)
    respond_to do |format|
      format.js {}
    end
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
  end

  def show
    @component = NamComponent.find(params[:id])
    @component = NamComponent.new if @component.nil?
  end

  private
  def component_params
    params.permit(:name, :ipaddress, :component_type)
  end
end
