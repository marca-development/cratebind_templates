class Api::ResourceController < Api::BaseController
  before_action :set_klass
  before_action :set_resource, only: [:show, :update, :destroy]

  def index
    if params[:all]
      @resources = @klass.all.accessible_by(current_ability)
    else
      @q = @klass.ransack(params[:q])
      if request.format.csv?
        @resources = @q.result.includes(includes_array).accessible_by(current_ability)
      else
        @resources = @q.result.includes(includes_array).accessible_by(current_ability).page(params[:page]).to_a.uniq
      end
      build_page_count_headers(@q.result.count)
    end
    respond_to do |format|
      format.json { render :index }
      format.csv { send_data build_csv, filename: "#{@klass.to_s}-#{Date.today.to_s}.csv" }
    end    
  end

  def show
  end

  def create
    @resource = @klass.new(resource_params)
    @resource.user = current_user if set_current_user
    if @resource.save
      render :show, status: :created
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  def update
    if @resource.update(resource_params)
      render :show, status: :ok
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @resource.destroy
    head :no_content
  end

  private

    def build_csv
      CSV.generate do |csv|
        csv << @klass.csv_columns
        @resources.each { |record| csv << record.to_csv }
      end
    end

    def includes_array
      []
    end

    def set_resource
      @resource = @klass.accessible_by(current_ability).find(params[:id])
    end
end
