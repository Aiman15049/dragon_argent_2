
module HttpAble
  extend ActiveSupport::Concern

  included do
    def default_http_protocol
      'http'
    end
  end
end
