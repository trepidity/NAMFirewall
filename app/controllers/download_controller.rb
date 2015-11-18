class DownloadController < ApplicationController

  def show
    @rule_model = RuleModel.find_by_session_id(params[:id])
    render stream: true
  end

end
