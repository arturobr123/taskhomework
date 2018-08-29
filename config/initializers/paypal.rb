PayPal::SDK.load("config/paypal.yml", Rails.env)
PayPal::SDK.logger = Logger.new(STDERR)

# change log level to INFO
PayPal::SDK.logger.level = Logger::INFO
