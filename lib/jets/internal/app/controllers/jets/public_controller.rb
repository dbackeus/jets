require "rack/mime"

# Works for utf8 text files.
# TODO: Add support to public_controller for binary data like images.
# Tricky because API Gateway is not respecting the Accept header in the
# same way as browsers.
class Jets::PublicController < Jets::Controller::Base
  def show
    public_path = Jets.root + "public"
    catchall_path = "#{public_path}/#{params[:catchall]}"
    if File.exist?(catchall_path)
      content_type = Rack::Mime.mime_type(File.extname(catchall_path))
      render file: catchall_path, content_type: content_type
    else
      render file: "#{public_path}/404", status: 404
    end
  end
end