Lita.configure do |config|

  config.robot.adapter = :slack
  config.robot.admins = []

  config.robot.name = 'diabot'
  config.robot.locale = :en
  config.robot.log_level = :debug
  config.adapters.slack.token = ENV['SLACK_TOKEN']

  # config.adapters.slack.link_names = true
  # config.adapters.slack.parse = "full"
  config.adapters.slack.unfurl_links = false
  config.adapters.slack.unfurl_media = false

  platform = :heroku if ENV['DYNO']
  case platform
  when :heroku
    config.http.port   = ENV['PORT']
    config.redis[:url] = ENV['REDISCLOUD_URL']
  else
    config.redis[:url] = ENV['LITA_REDIS_URL'] || 'redis://127.0.0.1:6379/'
  end

  config.handlers.keepalive.url = 'http://diabot-slack.herokuapp.com'

  config.handlers.diabetes.lower_bg_bound = '20'
  config.handlers.diabetes.upper_bg_bound = '35'

end
