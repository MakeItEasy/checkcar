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
      if @station.update(station_params_edit)
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

  def edit_picture
    init_station_pictures
    add_breadcrumb I18n.t('view.action.edit_picture'), :edit_picture_back_mystation_station_path
  end

  def update_picture
    if params[:station].present?
      if @station.update(station_params_edit_picture)
        redirect_to back_mystation_station_path, notice: I18n.t('view.notice.updated')
      else
        init_station_pictures
        flash[:alert] = I18n.t('view.alert.update')
        render :edit_picture
      end
    else
      flash[:alert] = I18n.t('view.alert.pictures_blank')
      init_station_pictures
      render :edit_picture
    end
  end

  private
    def station_params_edit
      params.require(:station).permit(:telephone, :recommend, :logo)
    end

    def station_params_edit_picture
      params.require(:station).permit(pictures_attributes: [:data, :_destroy, :id])
    end

    def init_station_pictures
      (Car::Constants::STATION_PICTURES_MAX_COUNT-@station.pictures.length).times { @station.pictures.build}
    end
end
