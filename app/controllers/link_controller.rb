# frozen_string_literal: true

class LinkController < ApplicationController
  before_action :set_link

  def show
    ::Visitors::Operations::TrackVisit.new(link: link, request: request).run

    redirect_to link.original_url
  end

  private

  attr_reader :link

  def set_link
    @link = Links::Queries::LinkByShortUrl.new(short_url: shortened_url).run
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'link not found' }, status: :not_found
  end

  def shortened_url
    params[:shortened_url]
  end
end
