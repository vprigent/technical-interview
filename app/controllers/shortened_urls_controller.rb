class ShortenedUrlsController < ApplicationController

  before_action :load_shortened_url, only: :show

  def new
    @shortened_url = ShortenedUrl.new
  end

  def create
    @shortened_url = ShortenedUrl.new shortened_params

    if @shortened_url.valid?
      @shortened_url.save
      flash.notice = "Your shortened URL is #{helpers.generate_from_short(@shortened_url)}".html_safe
      redirect_to action: :new
    else
      # @shortened_url.

      render :new
    end
  end

  def show
    if @shortened_url.present?
      redirect_to @shortened_url.origin, allow_other_host: true
    else
      flash.alert = "This short does not exist or is no longer valid"
      render :new
    end
  end

  private

  def load_shortened_url
    @shortened_url = ShortenedUrl.active.find_by(short: params[:id])
  end

  def shortened_params
    params.require(:shortened_url).permit(:origin)
  end
end
