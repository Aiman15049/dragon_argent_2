# rubocop:disable LineLength
module Cms
  class DynamicPanelsController < CmsController
    skip_before_action :verify_authenticity_token,
                       only: %i[move_higher
                                move_lower
                                move_to_bottom
                                move_to_top]

    expose(:dynamic_panels) { @dynamic_panels }
    expose(:dynamic_panel) { @dynamic_panel }

    def create
      @dynamic_panel = dynamic_page.dynamic_panels.new params_dynamic_panel
      if @dynamic_panel.save
        create_success_redirect
      else
        flash[:error] = record_not_saved
        return render :new
      end
    end

    def destroy
      return not_found_redirect(cms_dynamic_page_dynamic_panels_path(dynamic_page)) unless dynamic_panel
      if dynamic_panel.destroy
        flash[:notice] = record_destroyed
      else
        flash[:error] = record_not_destroyed
      end
      redirect_to(cms_dynamic_page_dynamic_panels_path(dynamic_page))
    end

    def dynamic_panel
      @dynamic_panel ||= DynamicPanel.find_by(id: params[:dynamic_panel_id])
    end

    def dynamic_panels
      DynamicPanel.where(dynamic_page: dynamic_page)
    end

    def edit
      return not_found_redirect(cms_dynamic_page_dynamic_panels_path(dynamic_page)) unless dynamic_panel
    end

    def index; end

    def move_higher
      dynamic_panel&.move_higher
      render 'cms/dynamic_panels/move'
    end

    def move_lower
      dynamic_panel&.move_lower
      render 'cms/dynamic_panels/move'
    end

    def move_to_bottom
      dynamic_panel&.move_to_bottom
      render 'cms/dynamic_panels/move'
    end

    def move_to_top
      dynamic_panel&.move_to_top
      render 'cms/dynamic_panels/move'
    end

    def new
      @dynamic_panel = dynamic_page.dynamic_panels.new
    end

    def update
      return not_found_redirect(cms_dynamic_page_dynamic_panels_path(dynamic_page)) unless dynamic_panel
      if dynamic_panel.update_attributes params_dynamic_panel
        update_success_redirect
      else
        flash[:error] = record_not_saved
        render :edit
      end
    end

    private

    def create_mappable
      d = DynamicPanelType.find_by(id: params[:dynamic_panel][:dynamic_panel_type_id])
      d.title.downcase.include? 'map' if d
    end

    def create_success_redirect
      flash[:notice] = record_saved
      if create_mappable
        redirect_to(edit_cms_dynamic_page_dynamic_panel_path(dynamic_panel.dynamic_page, dynamic_panel))
      else
        redirect_to(cms_dynamic_page_dynamic_panels_path(dynamic_panel.dynamic_page))
      end
    end

    def params_dynamic_panel
      params.require(:dynamic_panel).permit(:title, :text, :youtube_url,
                                            :dynamic_panel_type_id,
                                            :asset_attachment, :enquiry_link,
                                            :headline, :position,
                                            :column_2,
                                            mappable_category_ids: [])
    end

    def update_success_redirect
      flash[:notice] = record_saved
      redirect_to(cms_dynamic_page_dynamic_panels_path(dynamic_panel.dynamic_page))
    end
  end
end
