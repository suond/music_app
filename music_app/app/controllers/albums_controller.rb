class AlbumsController < ApplicationController
    before_action :ensure_logged_in
    def new
        if params.has_key?(:band_id)
            @album = Album.new
            @album.band_id = params[:band_id]
            render :new   
        else
            redirect_to bands_url
        end 
    end

    def create
        @album = Album.new(album_params)
        
        if @album.save
            redirect_to album_url(@album)
        else
            flash[:errors] = @album.errors.full_messages
            redirect_to new_band_album_url(@album.band_id)
        end
    end

    def show
        @album = Album.find(params[:id])
        render :show
    end

    def edit
        @album = Album.find(params[:id])
        if @album
            render :edit
        else
            flash[:errors] = ["Unable to find album"]
            redirect_to bands_url
        end
    end

    def update
        @album = Album.find(params[:id])

        if @album.update(album_params)
            redirect_to @album
        else
            flash.now[:errors]=[@album.errors.full_messages]
            render :edit
        end
    end

    def destroy
        album = Album.find(params[:id])
        band.destroy
        redirect_to bands_url
    end

    private
    def album_params
        params.require(:album).permit(:title,:year,:band_id,:live)
    end

end
