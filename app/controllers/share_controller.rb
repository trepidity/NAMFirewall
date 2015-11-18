class ShareController < ApplicationController

  def show
    @rule_model = RuleModel.find_by!(:session_id => params[:id])
  rescue
    respond_to do |format|
      format.html { render :partial => 'share/no_rules_found' }
    end
  end

end
