class EventsController < ApplicationController
  before_filter :find_event, :only => [ :show, :edit, :update, :destroy]
  
  def index
    @events = Event.page(params[:page]).per(5)
    
    respond_to do |format|
    format.html # index.html.erb
    format.xml { render :xml => @events.to_xml }
    format.json { render :json => @events.to_json }
    format.atom { @feed_title = "My event list" } # index.atom.builder
  end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(comment_params)
    if @event.save
      flash[:notice] = "event was successfully created"
      redirect_to events_url
    else
      render :action => :new #錯誤時回到有資料狀態
    end
  end

  def show
    respond_to do |format|
      format.html { @page_title = @event.name } # show.html.erb
      format.xml # show.xml.builder
      format.json { render :json => { id: @event.id, name: @event.name }.to_json }    
    end
  end

  def edit   
  end

  def update  
    if @event.update_attributes(comment_params)
      flash[:notice] = "event was successfully updated"
      redirect_to event_url(@event)
    else
      render :action => :edit
    end
  end

  def destroy
    @event.destroy
    flash[:alert] = "event was successfully deleted"

    redirect_to events_url
  end

  protected

  def find_event
    @event = Event.find(params[:id])
  end

  private

  def comment_params  
    params.require( :event ).permit( :name  ,  :description )  
  end  
  # Rails 4 => strong_parameters
end
