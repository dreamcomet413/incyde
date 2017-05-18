class FileUploadersController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:destroy]

  def index
    @archives = Archive.all
    @archive = Archive.new
  end

  def create
    @archive = current_user.archives.new(archive_params)

    if @archive.save
      render json: { message: "success", fileID: @archive.id }, :status => 200
    else
      render json: { error: @archive.errors.full_messages.join(',')}, :status => 400
    end
  end

  def destroy
    @archive = current_user.archives.find(params[:id])
    @archive.destroy
    #@upload = Upload.find(params[:id])
    #if @upload.destroy
    #  render json: { message: "File deleted from server" }
    #else
    #  render json: { message: @upload.errors.full_messages.join(',') }
    #end

  end


  private

  def archive_params
    params.require(:archive).permit(:upload)
  end

end
