class StatusesController < ApplicationController
  # GET /statuses
  # GET /statuses.xml
  def index
    @statuses = Status.limit(20).order("created_at DESC").where(:hash_tag_id => params[:hash_tag_id]).where("created_at > ?", Time.at(params[:most_recent].to_i/1000))
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statuses }
      format.json {render :json => @statuses }
    end
  end

  # GET /statuses/1
  # GET /statuses/1.xml
  def show
    @status = Status.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @status }
      format.json {render :json => @statuse }
    end
  end

  # GET /statuses/new
  # GET /statuses/new.xml
  def new
    @status = Status.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @status }
      format.json { render :json => @status }
    end
  end

  # GET /statuses/1/edit
  def edit
    @status = Status.find(params[:id])
  end

  # POST /statuses
  # POST /statuses.xml
  def create
    @status = Status.new(params[:status])

    respond_to do |format|
      if @status.save
        format.html { redirect_to(@status, :notice => 'Status was successfully created.') }
        format.xml  { render :xml => @status, :status => :created, :location => @status }
        format.json  { render :json => @status, :status => :created, :location => @status }        
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
        format.json  { render :json => @status.errors, :status => :unprocessable_entity }        
      end
    end
  end

  # PUT /statuses/1
  # PUT /statuses/1.xml
  def update
    @status = Status.find(params[:id])

    respond_to do |format|
      if @status.update_attributes(params[:status])
        format.html { redirect_to(@status, :notice => 'Status was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :ok }        
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
        format.json  { render :json => @status.errors, :status => :unprocessable_entity }        
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.xml
  def destroy
    @status = Status.find(params[:id])
    @status.destroy

    respond_to do |format|
      format.html { redirect_to(statuses_url) }
      format.xml  { head :ok }
      format.json  { head :ok }      
    end
  end
end
