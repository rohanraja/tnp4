class DatapagesController < ApplicationController
  before_action :set_datapage, only: [:show, :edit, :update, :destroy]

  # GET /datapages
  # GET /datapages.json
  def index
    @datapages = Datapage.all
  end

  # GET /datapages/1
  # GET /datapages/1.json
  def show
  end

  # GET /datapages/new
  def new
    @datapage = Datapage.new
  end

  # GET /datapages/1/edit
  def edit
  end

  # POST /datapages
  # POST /datapages.json
  def create
    @datapage = Datapage.new(datapage_params)

    respond_to do |format|
      if @datapage.save
        format.html { redirect_to @datapage, notice: 'Datapage was successfully created.' }
        format.json { render action: 'show', status: :created, location: @datapage }
      else
        format.html { render action: 'new' }
        format.json { render json: @datapage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /datapages/1
  # PATCH/PUT /datapages/1.json
  def update
    respond_to do |format|
      if @datapage.update(datapage_params)
        format.html { redirect_to @datapage, notice: 'Datapage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @datapage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datapages/1
  # DELETE /datapages/1.json
  def destroy
    @datapage.destroy
    respond_to do |format|
      format.html { redirect_to datapages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_datapage
      @datapage = Datapage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def datapage_params
      params.require(:datapage).permit(:url, :html)
    end
end
