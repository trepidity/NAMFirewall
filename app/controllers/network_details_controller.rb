class NetworkDetailsController < ApplicationController

  def create
    rule_model = RuleModel.find_or_create_by!(:session_id => session[:session_hex])
    @network_detail = NetworkDetail.find_or_create_by(:rule_model_id => rule_model.id)

    @network_detail.rule_model = rule_model unless @network_detail.new_record?

    # update any changes for the IDP config
    @network_detail.fw_separates_idp = params[:network_detail][:fw_separates_idp]

    # update any changes for AG config
    @network_detail.fw_separates_ag = params[:network_detail][:fw_separates_ag]

    # update any changes for AC config
    @network_detail.fw_separates_ac = params[:network_detail][:fw_separates_ac]

    if @network_detail.save!
      respond_to do |format|
        flash[:info] = 'Success!'
        format.json  { render json: {status: 200, statusText: "Success!" } }
      end
    else
      respond_to do |format|
        flash[:info] = 'Change failed'
        format.json  { render json: {status: unprocessable_entity, statusText: @network_detail.errors } }
      end
    end
  end

end
