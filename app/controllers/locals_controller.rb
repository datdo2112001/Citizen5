class LocalsController < ApplicationController

  include ApplicationHelper

  def new
  end

  def index
    @locals = Local.all
    @results = []
    @citizens = Citizen.all

    @locals.each do |local|
      temp = 0;
      @citizens.each do |citizen|
        if (checkcode(local.code, citizen.code) == true)
          temp += 1
        end
      end
      local.update_attribute(:count, temp)
    end
    
    @locals.each do |local|
      if (current_user.tk == "A1")
        if (local.code >= 0 && local.code <= 63)
          @results.push(local)
        end
      elsif (current_user.tk == "A2")
        if (local.code >= 0101 && local.code <= 6399 && checkcode(current_user.accountname, local.code) == true )
          @results.push(local)
        end
      elsif (current_user.tk == "A3")
        if (local.code >= 010101 && local.code <= 639999 && checkcode(current_user.accountname, local.code) == true )
          @results.push(local)
        end
      elsif (current_user.tk == "B1")
        if (local.code >= 01010101 && local.code <= 63999999 && checkcode(current_user.accountname, local.code) == true )
          @results.push(local)
        end
      end
    end
    @local = Local.new
  end

  def show
    @local = Local.find(params[:id])
  end

  def create
    @local = Local.new(local_params)

    respond_to do |format|
      if @local.save
        format.html { redirect_to @local, notice: 'Local was successfully created.' }
        format.js   {}
        format.json { render :show, status: :created, location: @local }
      else
        format.html { render :new }
        format.json { render json: @local.errors, status: :unprocessable_entity }
      end
    end
  end

  def local_params
    params.require(:local).permit(:name, :code, :status, :count)
  end

  def destroy
    Local.find(params[:id]).destroy
    flash[:success] = "Local deleted"
    respond_to do |format|
      format.html { redirect_to locals_url, notice: 'Local was successfully deleted.' }
      format.json { head :no_content }
      format.js   { render layout: false }
    end
  end

  def sublocal
    @all = Local.all
    @current_local = Local.find_by(code: params[:code])
    @current_code = params[:code]
    @locals = []
    @all.each do |local|
      if (local.code != @current_code)
        if (checkcode(@current_code, local.code) == true)
          if (@current_code.to_i >= 01 && @current_code.to_i <= 63)
            if (local.code >= 0101 && local.code <= 6399)
              @locals.push(local)
            end
          elsif (@current_code.to_i >= 0101 && @current_code.to_i <= 6399)
            if (local.code >= 010101 && local.code <= 639999)
              @locals.push(local)
            end
          elsif (@current_code.to_i >= 010101 && @current_code.to_i <= 639999)
            if (local.code >= 01010101 && local.code <= 63999999)
              @locals.push(local)
            end
          end
        end
      end
    end
  end

  def change_status
    @local = Local.find_by(code: params[:code])

    if (@local.status == "Chua hoan thanh")
      @local.update_attribute(:status, "Da hoan thanh")
    else 
      @local.update_attribute(:status, "Chua hoan thanh")
    end

    @locals1 = Local.all
    @locals2 = Local.all

    @locals1.sort_by{|e| -e[:code]}

    @locals1.each do |local1|
      if (local1.code != @local.code && checkcode(local1.code,@local.code ) == true && local1.code < 01010101)
        signal = true
        @locals2.each do |local2|
          if (local2.code != local1.code && checkcode(local1.code,local2.code ) == true && local2.status == "Chua hoan thanh")
            signal = false
          end
        end

        if (signal == true)
          local1.update_attribute(:status, "Da hoan thanh")
        else 
          local1.update_attribute(:status, "Chua hoan thanh")
        end

      end

    end



    redirect_to :controller => 'locals', :action => 'index'

  end

end
