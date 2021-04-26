# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

# Rails.application.config.content_security_policy do |policy|
#   policy.default_src :self, :https
#   policy.font_src    :self, :https, :data
#   policy.img_src     :self, :https, :data
#   policy.object_src  :none
#   policy.script_src  :self, :https
#   policy.style_src   :self, :https
#   # If you are using webpack-dev-server then specify webpack-dev-server host
#   policy.connect_src :self, :https, "http://localhost:3035", "ws://localhost:3035" if Rails.env.development?

#   # Specify URI for violation reports
#   # policy.report_uri "/csp-violation-report-endpoint"
# end

# If you are using UJS then enable automatic nonce generation
# # Rails.application.config.content_security_policy_nonce_generator = -> request do
#   SecureRandom.base64(16)
# end

# Set the nonce only to specific directives
# Rails.application.config.content_security_policy_nonce_directives = %w(script-src)

# Report CSP violations to a specified URI
# For further information see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
# Rails.application.config.content_security_policy_report_only = true
Rails.application.config.content_security_policy do |policy|
  if Rails.env.development?
    policy.connect_src :self, :https, 'http://localhost:3035', 'ws://localhost:3035'
    policy.script_src :self, :https, :unsafe_eval, :unsafe_inline
  else
    policy.script_src :self, :https
    # google tag manager requires to enable unsafe inline:
    # https://developers.google.com/tag-manager/web/csp
    policy.connect_src :self, :https, 'https://www.google-analytics.com'
    policy.script_src :self,
      :https,
      :unsafe_inline,
      :unsafe_eval,
      'https://www.googletagmanager.com',
      'https://www.google-analytics.com',
      'https://ssl.google-analytics.com'
    policy.img_src :self, :https, 'https://www.googletagmanager.com', 'https://www.google-analytics.com'
  end
end
