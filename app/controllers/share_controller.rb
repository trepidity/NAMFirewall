class ShareController < ApplicationController

  def show
    @rule_model = RuleModel.find_by_session_id(params[:id])
  end

end
