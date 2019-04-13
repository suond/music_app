class TracksController < ApplicationController
    before_action :ensure_logged_in
    def new
        if params.has_key?(:album_id)
            @track = Track.new
            render :new   
        else
            redirect_to bands_url
        end 
    end

    def create
        @track = Track.new(track_params)
        
        if @track.save
            redirect_to track_url(@track)
        else
            flash[:errors] = @track.errors.full_messages
            redirect_to new_album_track_url(@track.album_id)
        end
    end

    def show
        @track = Track.find(params[:id])
        render :show
    end

    def edit
        @track = Track.find(params[:id])
        if @track
            render :edit
        else
            flash[:errors] = ["Unable to find track"]
            redirect_to bands_url
        end
    end

    def update
        @track = Track.find(params[:id])

        if @track.update(track_params)
            redirect_to @track
        else
            flash.now[:errors]=[@track.errors.full_messages]
            render :edit
        end
    end

    def destroy
        track = Track.find(params[:id])
        band.destroy
        redirect_to bands_url
    end

    private
    def track_params
        params.require(:track).permit(:title,:ord,:album_id,:regular,:lyrics)
    end
end
