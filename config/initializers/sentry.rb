if Rails.env.production?
  Raven.configure do |config|
    config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  end

  # In case you want to group the events with different ids in the
  module RackTimeoutExtensions
    def raven_context
      { fingerprint: ["{{ default }}", env["REQUEST_PATH"].gsub(/\d/, '')] }
    end
  end
end
