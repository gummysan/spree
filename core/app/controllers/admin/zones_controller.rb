class Admin::ZonesController < Admin::ResourceController
  before_filter :load_data, :except => [:index]
  
  def new
    @zone.zone_members.build
  end
  
  protected

  def collection
    params[:search] ||= {}
    params[:search][:meta_sort] ||= "ascend_by_name"
    @search = super.metasearch(params[:search])
    @zones = @search.paginate(:per_page => Spree::Config[:orders_per_page], :page => params[:page])
  end

  def load_data
    @countries = Country.order(:name)
    @states = State.order(:name)
    @zones = Zone.order(:name)
  end
end
