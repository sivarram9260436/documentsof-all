class Admin::AllRedirectsController < AdminController
  require 'will_paginate/array'

  def index
    @page_properties={:selected_menu=>'all_redirect_new',:menu_title=>'All redirects List'}
  end

  def new
    @page_properties={:selected_menu=>'all_redirect_new',:menu_title=>'All redirects New'}
    @all_redirect = AllRedirect.new()
  end

  def create
    @page_properties={:selected_menu=>'all_redirect_new',:menu_title=>'All redirects New'}
    @all_redirect = AllRedirect.new(params[:all_redirect])
    if @all_redirect.save
      redirect_to :action => "index"
    else
      render :template => "/admin/all_redirects/new"
    end
  end

  def edit
    @page_properties={:selected_menu=>'all_redirect_new',:menu_title=>'All redirects Edit'}
    @all_redirect = AllRedirect.where(:id=>params[:id]).first
  end

  def update
    debugger
    @page_properties={:selected_menu=>'all_redirect_new',:menu_title=>'All redirects New'}
    @all_redirect = AllRedirect.where(:id=>params[:id]).first
    if @all_redirect.update_attributes(params[:all_redirect])
      redirect_to :action => "index"
    else
      render :template => "/admin/all_redirects/edit"
    end
  end

  def delete_redirect
    all_redirect = AllRedirect.where(:id=>params[:id]).first
    all_redirect.destroy unless all_redirect.blank?
    redirect_to :action => "index"
  end
end

