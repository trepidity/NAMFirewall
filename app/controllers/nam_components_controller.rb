class NamComponentsController < ApplicationController
  # def new
  #   @component = NamComponent.create(component_params)
  #
  #   respond_to do |format|
  #     format.js {}
  #   end
  # end

  def create
    hex = session[:session_hex]
    rule_session = RuleModel.find_by_session_id(hex)
    @component = rule_session.nam_components.create(component_params)
    rule_session.save

    respond_to do |format|
      format.js {}
    end
  end

  def update
    @component = NamComponent.find(params[:id])
    respond_to do |format|
      if @component.update_attributes(params[:nam_component].permit(:name, :ipaddress, :component_type))
        format.html { redirect_to root_url, notice: 'test was successfully modified.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end


  def edit
    @edit_component = NamComponent.find(params[:id])
    puts "found #{@edit_component.inspect} to edit"
  end

  def destroy
    component = NamComponent.find(params[:id])
    respond_to do |format|
      if component.destroy
        format.html { redirect_to root_url, notice: 'component was successfully deleted.' }
      else
        format.html { render action: 'edit' }
      end
    end
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
