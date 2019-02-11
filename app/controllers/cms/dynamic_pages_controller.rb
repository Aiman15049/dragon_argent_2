module Cms
  class DynamicPagesController < CmsController
    skip_before_action :verify_authenticity_token,
                       only: %i[move_higher
                                move_lower
                                move_to_bottom
                                move_to_top
                                toggle_publish]


    def create
      dynamic_page = DynamicPage.new params_dynamic_page
      if dynamic_page.save
        flash[:notice] = "record saved"
        redirect_to cms_dynamic_pages_path
      else
        flash[:error] = "record not saved"
        return render :new
      end
    end

    def destroy
      dynamic_page = DynamicPage.find(params[:dynamic_page_id])
      return not_found_redirect(cms_dynamic_pages_path) unless dynamic_page
      if dynamic_page.destroy
        flash[:notice] = "record destroyed"
      else
        flash[:error] = "record not destroyed"
      end
      redirect_to(cms_dynamic_pages_path)
    end

    def dynamic_pages
      super.roots
    end

    def edit
      @dynamic_page = DynamicPage.find(params[:dynamic_page_id])
      return not_found_redirect(cms_dynamic_pages_path) unless @dynamic_page
    end

    def index
      @dynamic_pages = DynamicPage.all
    end

    def new
      @dynamic_page = DynamicPage.new
    end

    def new_child
      return not_found_redirect(cms_dynamic_pages_path) unless dynamic_page
      @dynamic_page = project.dynamic_pages.new(parent: dynamic_page)
      render :new
    end


    def update
      @dynamic_page = DynamicPage.find(params[:dynamic_page_id])
      return not_found_redirect(cms_dynamic_pages_path) unless @dynamic_page
      if @dynamic_page.update_attributes params_dynamic_page
        flash[:notice] = "record saved"
        redirect_to cms_dynamic_pages_path
      else
        flash[:error] = "record not saved"
        render :edit
      end
    end

    private

    def params_dynamic_page # rubocop:disable MethodLength
      params.require(:dynamic_page).permit!
    end

    def update_success_redirect
      if params[:dynamic_page][:page_type].present?
        redirect_to(edit_cms_dynamic_page_path(dynamic_page))
      else
        redirect_to(cms_dynamic_pages_path)
      end
    end
  end
end
