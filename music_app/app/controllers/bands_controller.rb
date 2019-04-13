class BandsController < ApplicationController
    before_action :ensure_logged_in
    def index
        @bands = Band.all
        render :index
    end

    def new
        @band = Band.new
        render :new
    end

    def create
        @band = Band.new(band_params)

        if @band.save
            redirect_to @band
        else
            redirect_to new_band_url
        end
    end

    def show
        #find by id
        @band = Band.find(params[:id])
        @albums = @band.albums
        render :show
    end

    def edit
        #find by id
        @band = Band.find(params[:id])
        
        if @band
            render :edit
        else
            flash[:errors] =["Couldn't find that band"]
            redirect_to bands_url
        end
    end

    def update
        #find 
        @band = Band.find(params[:id])
        if @band.update(band_params)
            redirect_to @band
        else
            flash.now[:errors]=[@band.errors.full_messages]
            render :edit
        end

    end

    def destroy
        #find by id
        #destroy
        #redirect to index
        band = Band.find(params[:id])
        band.destroy
        redirect_to bands_url
    end

    private

    def band_params
        params.require(:band).permit(:name)
    end
        
    
    
    
end
