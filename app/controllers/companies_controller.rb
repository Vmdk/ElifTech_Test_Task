require 'pry'
class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.where nesting_level: 0
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    # binding.pry
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end


  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)
    if @company.master_company_id
        @company.nesting_level = Company.find(@company.master_company_id)['nesting_level'] + 1
    else @company.nesting_level = 0
    end

    respond_to do |format|
      if @company.nesting_level < 5
        if @company.save
          format.html { redirect_to @company, notice: 'Company was successfully created.' }
          format.json { render :show, status: :created, location: @company }
        else
          format.html { render :new }
          format.json { render json: @company.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: {"error" => "company nesting level should be less than 5"}, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :earnings, :nesting_level, :master_company_id)
    end
end
