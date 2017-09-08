class Admin::ProductsController < AdminController
  def index
    @page_properties = { :selected_menu => 'product_menu', :menu_title => 'List of Product' }
    session[:per_page] = ( params[:per_page] ||= session[:per_page] || "30" )
    component_pagination('products/index', SrComponent.find_component_by_name('ProductList'), 'product_list')  #(render_template,partial_template,replace_html_div)
  end

  def new_product
    @page_properties={:selected_menu=>'product_menu',:menu_title=>'Create Product'}
    @teaser_types = TeaserType.find(:all)
    @product = Product.new
    render :template=>'admin/products/new_product'
  end

  def save_product
    @page_properties={:selected_menu=>'product_menu',:menu_title=>'List of Product'}
    @product = Product.new(params[:product])
    @product.site_id = @site.id
    @product.teaser_type_ids = params[:teaser_type][:id] if params[:teaser_type]
    @product.asset_group_ids=[]
    if @product.save
      redirect_to :controller=>"admin/products",:action=>"index"
    else
      @page_properties={:selected_menu=>'product_menu',:menu_title=>'Create Product'}
      @teaser_types = TeaserType.find(:all)
      asset_group_ids=@site.asset_conditions.collect{|asset_cond| asset_cond.asset_group_id}
      @asset_group = AssetGroup.find(:all, :conditions => ["id in(?)", asset_group_ids])
      render :action => 'new_product'
    end
  end

  def edit_product
    @page_properties={:selected_menu=>'product_menu',:menu_title=>'Edit Product'}
    @product = Product.find(params[:id])
    @teaser_types = TeaserType.find(:all)
    render :template=>'admin/products/edit_product'
  end

  def update_product
    @page_properties={:selected_menu=>'product_menu',:menu_title=>'Edit Product'}
    @product = Product.find(params[:id])
    @product.asset_group_ids=[]
    @product.update_attributes(params[:product])
    @product.update_attributes(:site_id=>@site.id)
    @teaser_types = TeaserType.find(:all)
    if @product.save(:validate=>false)
      redirect_to :controller=>"admin/products",:action=>"index"
    else
      asset_group_ids=@site.asset_conditions.collect{|asset_cond| asset_cond.asset_group_id}
      @asset_group = AssetGroup.find(:all,:conditions=>["id in(?)",asset_group_ids])
      render :template=>'admin/products/edit_product'
    end
  end

  

end
