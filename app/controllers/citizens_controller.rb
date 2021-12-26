class CitizensController < ApplicationController
  include ApplicationHelper

  def new
  end

  def index
    @all = Citizen.all
    @citizen = Citizen.new
    @citizens = []
    @all.each do |citizen|
      if (checkcode(current_user.accountname, citizen.code) == true)
          @citizens.push(citizen)
      end
    end
  end

  def show
    @citizen = Citizen.find(params[:id])
  end

  def create
    @citizen = Citizen.new(citizen_params)

    respond_to do |format|
      if @citizen.save
        format.html { redirect_to @citizen, notice: 'Citizen was successfully created.' }
        format.js   {}
        format.json { render :show, status: :created, location: @citizen }
      else
        format.html { render :new }
        format.json { render json: @citizen.errors, status: :unprocessable_entity }
      end
    end
  end

  def citizen_params
    params.require(:citizen).permit(:cmnd, :name, :birthday, :sex, :hometown, :paddress,
                                    :traddress, :religion, :edulevel, :job, :code)

  end

  def overall
    @count = Citizen.count
    @locals = []
    @all = Local.all
    @all.each do |local|
      if (local.code >= 01 && local.code <= 63)
        @locals.push(local)
      end
    end

    @people = []
    
    @citizens = Citizen.all
    @male = 0
    @female = 0

    if (current_user.tk == "A1")
      @citizens.each do |citizen|
        if (citizen.sex == "Nam")
          @male += 1
        elsif (citizen.sex == "Nu")
          @female += 1
        end
      end
    else
      @citizens.each do |citizen|
        if (checkcode(current_user.accountname, citizen.code) == true)
          if (citizen.sex == "Nam")
            @male += 1
          elsif (citizen.sex == "Nu")
            @female += 1
          end
        end
      end
    end

  end

  def destroy
    Citizen.find(params[:id]).destroy
    flash[:success] = "Citizen deleted"
    respond_to do |format|
      format.html { redirect_to citizens_url, notice: 'Citizen was successfully deleted.' }
      format.json { head :no_content }
      format.js   { render layout: false }
    end
  end

  def detail
    @citizens = Citizen.all
    @current_code = params[:code]
  end

  def edit
    @citizen = Citizen.find(params[:id])
  end

  def update
    @citizen = Citizen.find(params[:id])
    if @citizen.update(citizen_params)
      # Handle a successful update.
      redirect_to @citizen
    else
      render 'edit'
    end
  end




end
