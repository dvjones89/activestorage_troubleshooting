class VlogsController < ApplicationController
  before_action :set_vlog, only: [:show, :edit, :update, :destroy]

  # GET /vlogs
  # GET /vlogs.json
  def index
    @vlogs = Vlog.all
  end

  # GET /vlogs/1
  # GET /vlogs/1.json
  def show
  end

  # GET /vlogs/new
  def new
    @vlog = Vlog.new
  end

  # GET /vlogs/1/edit
  def edit
  end

  # POST /vlogs
  # POST /vlogs.json
  def create
    @vlog = Vlog.new(vlog_params)

    respond_to do |format|
      if @vlog.save
        format.html { redirect_to @vlog, notice: 'Vlog was successfully created.' }
        format.json { render :show, status: :created, location: @vlog }
      else
        format.html { render :new }
        format.json { render json: @vlog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vlogs/1
  # PATCH/PUT /vlogs/1.json
  def update
    respond_to do |format|
      if @vlog.update(vlog_params)
        format.html { redirect_to @vlog, notice: 'Vlog was successfully updated.' }
        format.json { render :show, status: :ok, location: @vlog }
      else
        format.html { render :edit }
        format.json { render json: @vlog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vlogs/1
  # DELETE /vlogs/1.json
  def destroy
    @vlog.destroy
    respond_to do |format|
      format.html { redirect_to vlogs_url, notice: 'Vlog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vlog
      @vlog = Vlog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vlog_params
      params.require(:vlog).permit(:title, :dated_on, files: [])
    end
end
