class Back::Mystation::StationsController < Back::StationBaseController
  before_action :set_station


  # TODO dairg check_file_size
=begin
  before_post_process :check_file_size
  def check_file_size
    valid?
    errors[:image_file_size].blank?
  end
=end


  ## 加载权限
  load_and_authorize_resource

  ## 面包屑导航
  add_breadcrumb Station.model_name.human, :back_mystation_station_path

  # GET /stations/1
  # GET /stations/1.json
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.show'), :back_mystation_station_path
  end

  # GET /stations/1/edit
  def edit
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.edit'), :edit_back_mystation_station_path
  end

  # PATCH/PUT /stations/1
  # PATCH/PUT /stations/1.json
  def update
    respond_to do |format|
      ## TODO dairg 车检站信息更新时，是否设置状态为 待审核
      # @station.status = :waiting
      if @station.update(station_params)
        format.html { redirect_to back_mystation_station_path, notice: I18n.t('view.notice.updated') }
        format.json { render :show, status: :ok, location: @station }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.update')
          render :edit
        end
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def station_params
      params.require(:station).permit(:telephone, :recommend, :logo)
    end
end
