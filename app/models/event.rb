class Event < ApplicationRecord
  has_many :items


  private

  def create_qr_code
    # https://github.com/whomwah/rqrcode
    require "rqrcode"

    qr = RQRCode::QRCode.new(Rails.application.routes.url_helpers.event_url(self, host: 'localhost:3000'))
  end
end
