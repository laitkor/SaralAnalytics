class FunnelsController < ApplicationController

  before_filter :login_required
  
  # GET /funnels
  # GET /funnels.json
  def index
    @funnels = Funnel.list

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @funnels }
    end
  end

  # GET /funnels/1
  # GET /funnels/1.json
  def show
    funnels = current_project.funnels
    if funnels.include?(params[:id])
      @funnel = Funnel.find(params[:id])
      graph_data = []
      @funnel.pages.each do |p|
        pageonecount = BrowserDetail.search_by(domain: p.url).count
        key = p.url.scan(/(?<=\/)\w+/).last.capitalize || p.url
        graph_data << {name: key, y: pageonecount}
      end

      respond_to do |format|
        format.html # show.html.erb
        format.js { render json: graph_data }
      end
    else
      redirect_to new_funnel_path
    end
  end

  # GET /funnels/new
  # GET /funnels/new.json
  def new
    @funnel = Funnel.new
  end

  # GET /funnels/1/edit
  def edit
    @funnel = Funnel.find(params[:id])
  end

  # POST /funnels
  # POST /funnels.json
  def create
    @funnel = Funnel.new(params[:funnel].merge(project_id:@project.key))

    respond_to do |format|
      if @funnel.save
        format.html { redirect_to @funnel, notice: 'Funnel was successfully created.' }
        format.json { render json: @funnel, status: :created, location: @funnel }
      else
        format.html { render action: "new" }
        format.json { render json: @funnel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /funnels/1
  # PUT /funnels/1.json
  def update
    @funnel = Funnel.find(params[:id])

    respond_to do |format|
      if @funnel.update_attributes(params[:funnel])
        format.html { redirect_to @funnel, notice: 'Funnel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @funnel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /funnels/1
  # DELETE /funnels/1.json
  def destroy
    @funnel = Funnel.find(params[:id])
    @funnel.destroy
    respond_to do |format|
      format.html { redirect_to new_funnel_path }
      format.json { head :no_content }
    end
  end
end
