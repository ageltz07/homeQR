class Event < ApplicationRecord
  has_many :items
  has_one_attached :qr_image

  after_commit :create_qr_code, on: [ :create ]

  private

  def create_qr_code
    # https://github.com/whomwah/rqrcode
    require "rqrcode"

    qr_code = RQRCode::QRCode.new(Rails.application.routes.url_helpers.event_url(self, host: "localhost:3000"))
    qr_png = qr_code.as_png
    qr_image.attach(
      io: StringIO.new(qr_png.to_s),
      filename: "event_#{id}_qr.png",
      content_type: "image/png"
    )
  end

  # TODO: Create a need_to_update_qr_code? method in rare case that it may need
  # regenerated.

  # TODO: Create a cleanup callback for after deleting an event to destroy directories
  # left behind after deleting qr_image on local disk storage.
end
