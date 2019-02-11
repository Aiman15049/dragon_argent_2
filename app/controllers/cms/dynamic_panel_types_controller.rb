module Cms
  class DynamicPanelTypesController < CmsController
    skip_before_action :verify_authenticity_token,
                       only: %i[move_higher
                                move_lower
                                move_to_bottom
                                move_to_top]

    expose(:dynamic_panel_types) { @dynamic_panel_types }
    expose(:dynamic_panel_type) { @dynamic_panel_type }

    def create
      @dynamic_panel_type = DynamicPanelType.new params_dynamic_panel_type
      if @dynamic_panel_type.save
        flash[:notice] = record_saved
        return redirect_to(cms_dynamic_panel_types_path)
      else
        flash[:error] = record_not_saved
        return render :new
      end
    end

    def destroy
      return not_found_redirect(cms_dynamic_panel_types_path) unless dynamic_panel_type
      if dynamic_panel_type.destroy
        flash[:notice] = record_destroyed
      else
        flash[:error] = record_not_destroyed
      end
      redirect_to(cms_dynamic_panel_types_path)
    end

    def dynamic_panel_type
      @dynamic_panel_type ||= DynamicPanelType.find_by(id: params[:dynamic_panel_type_id])
    end

    def dynamic_panel_types
      DynamicPanelType.all
    end

    def edit
      return not_found_redirect(cms_dynamic_panel_types_path) unless dynamic_panel_type
    end

    def index; end

    def move_higher
      dynamic_panel_type&.move_higher
      render 'cms/dynamic_panel_types/move'
    end

    def move_lower
      dynamic_panel_type&.move_lower
      render 'cms/dynamic_panel_types/move'
    end

    def move_to_bottom
      dynamic_panel_type&.move_to_bottom
      render 'cms/dynamic_panel_types/move'
    end

    def move_to_top
      dynamic_panel_type&.move_to_top
      render 'cms/dynamic_panel_types/move'
    end

    def new
      @dynamic_panel_type = DynamicPanelType.new
    end

    def update
      return not_found_redirect(cms_dynamic_panel_types_path) unless dynamic_panel_type
      if dynamic_panel_type.update_attributes params_dynamic_panel_type
        flash[:notice] = record_saved
        redirect_to(cms_dynamic_panel_types_path)
      else
        flash[:error] = record_not_saved
        render :edit
      end
    end

    private

    def params_dynamic_panel_type
      params.require(:dynamic_panel_type).permit(:title, :cms_name, :position)
    end
  end
end
