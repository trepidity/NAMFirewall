class NamComponentsController < ApplicationController

  def create
    hex = session[:session_hex]
    rule_session = RuleModel.find_by_session_id(hex)
    @component = rule_session.nam_components.create(component_params)
    if rule_session.save!
      respond_to do |format|
        logger.info 'Added successfully'
        flash[:notice] = 'Added successfully'
        format.js { render :partial =>  'nam_components/nam_component', :locals => {:component => @component} }
      end
    else
      logger.error(@component.errors.full_messages)
      format.js { flash[:error] = 'Failed to create component'}
    end
  end

  def update
    @component = NamComponent.find(params[:id])
    respond_to do |format|
      if @component.update_attributes(component_params)
        flash[:notice] = 'Update successful.'
        format.html { redirect_to root_url }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def edit
    @edit_component = NamComponent.find(params[:id])
  end

  def destroy
    component = NamComponent.find(params[:id])
    respond_to do |format|
      if component.destroy
        flash[:success] = 'Deleted successfully'
        format.js { render 'nam_components/destroy', :locals => {:id => params[:id]}}
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def index
    hex = session[:session_hex]
    @components = RuleModel.find_by_session_id(hex).nam_components
  rescue
    respond_to do |format|
      format.html { render :partial => 'share/no_components_found' }
    end
  end

  def show
    @component = NamComponent.find(params[:id])
    @component = NamComponent.new if @component.nil?
  end

  private
  def component_params
    params.require(:nam_component).permit(:name, :ipaddress, :component_type, :dmz)
  end
end
