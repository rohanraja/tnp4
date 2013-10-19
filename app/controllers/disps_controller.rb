class DispsController < ApplicationController
  before_action :set_disp, only: [:show, :edit, :update, :destroy]

  # GET /disps
  # GET /disps.json
  def index
    @disps = Disp.all
  end

  # GET /disps/1
  # GET /disps/1.json
  def show
  end

  # GET /disps/new
  def new
    @disp = Disp.new
  end

  # GET /disps/1/edit
  def edit
  end

  # POST /disps
  # POST /disps.json
  def create
    @disp = Disp.new(disp_params)

    respond_to do |format|
      if @disp.save
        format.html { redirect_to @disp, notice: 'Disp was successfully created.' }
        format.json { render action: 'show', status: :created, location: @disp }
      else
        format.html { render action: 'new' }
        format.json { render json: @disp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disps/1
  # PATCH/PUT /disps/1.json
  def update
    respond_to do |format|
      if @disp.update(disp_params)
        format.html { redirect_to @disp, notice: 'Disp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @disp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disps/1
  # DELETE /disps/1.json
  def destroy
    @disp.destroy
    respond_to do |format|
      format.html { redirect_to disps_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disp
      @disp = Disp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def disp_params
      params[:disp]
    end
end
