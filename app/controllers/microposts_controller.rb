class MicropostsController < ApplicationController

    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
        @micropost = current_user.microposts.build(micropost_params)
        @micropost.image.attach(params[:micropost][:image])
        if @micropost.save
            flash[:success] = "Micropost successfully created!"
            redirect_to root_path
        else
            @feed_items = current_user.feed.paginate(page: params[:page])
            render "home/index", status: :unprocessable_entity
        end
    end

    def destroy
        @micropost.destroy
        flash[:success] = "Micropost successfully deleted"
        redirect_to request.referrer || root_path
    end

    private
    
        def micropost_params
            params.require(:micropost).permit(:content, :image)
        end

        def correct_user
            @micropost = current_user.microposts.find_by(id: params[:id])
            redirect_to root_path if @micropost.nil?
        end
end
