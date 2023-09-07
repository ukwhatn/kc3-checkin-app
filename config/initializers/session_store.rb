secure = Rails.env.production?
key = Rails.env.production? ? "_app_session" : "_app_session_#{Rails.env}"
domain = ENV.fetch("APP_HOST", "localhost")

Rails.application.config.session_store :redis_store,
                                       servers: %w(redis://redis:6379/0/session),
                                       expire_in: 12.hours,
                                       key:,
                                       domain:,
                                       secure:,
                                       httponly: true
