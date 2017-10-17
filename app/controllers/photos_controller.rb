class PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :owned_photo, only: [:edit, :update, :destroy]
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
    puts "current_user is: #{current_user.inspect}"
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo_comments = Photo.find(params[:id]).comments
  end

  # GET /photos/new
  def new
    @photo = current_user.photos.build

    # @photo = Photo.new
    # @user = current_user

  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = current_user.photos.build(photo_params)

    # @photo = Photo.new(photo_params)
    # @photo.user = current_user  #for current user create - apply on devise method

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update

    respond_to do |format|
      if is_liking?
        @photo.toggle_liked_by(current_user)
        format.html { redirect_to @photo }
        format.json { render :show, status: :ok, location: @photo }

        #  @photo = Photo.find(params[:id])
        #  if @photo.update_attributes(photo_params)
        #    flash[:success] = 'Photo edited!'
        #    redirect_to photos_path

      elsif @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.'}
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end

      # respond_to do |format|
      #   if @photo.update(photo_params)
      #     format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
      #     format.json { render :show, status: :ok, location: @photo }
      #   else
      #     format.html { render :edit }
      #     format.json { render json: @photo.errors, status: :unprocessable_entity }
      #   end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 def owned_photo
   unless current_user == @photo.user
     flash[:alert] = "That photo does not belong to you!"
     redirect_to root_path
   else
     redirect_to @photo
   end
 end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:image, :user_id, :caption)
    end

    def is_liking?
      params.require(:photo)[:liked].present?
    end
end
