class Event < ApplicationRecord
  has_many :items
  has_one_attached :qr_image

  after_commit :create_qr_code, on: [:create, :update], unless: :updating_qr_code_only?

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

  def updating_qr_code_only?
    # This is to avoid an infinite loop of callbacks when generating the qr code using an after_commit
    # callback.

    qr_image.attached? && previous_changes.keys == []
  end
end
