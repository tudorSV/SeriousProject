require 'pusher'
Pusher.app_id = Rails.application.secrets.PUSHER_APP_ID
Pusher.key = Rails.application.secrets.PUSHER_KEY
Pusher.secret = Rails.application.secrets.PUSHER_SECRET
Pusher.cluster = Rails.application.secrets.PUSHER_CLUSTER
Pusher.logger = Rails.logger
Pusher.encrypted = true
