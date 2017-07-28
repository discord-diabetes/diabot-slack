Lita.configure do |config|
  config.robot.adapter = :slack
  config.robot.admins = []

  config.robot.name = 'diabot'
  config.robot.locale = :en
  config.robot.log_level = :info
  config.adapters.slack.token = ENV['SLACK_TOKEN']

  platform = :heroku if ENV['DYNO']
  case platform
  when :heroku
    config.http.port   = ENV['PORT']
    config.redis[:url] = ENV['REDISCLOUD_URL']
  else
    config.redis[:url] = ENV['LITA_REDIS_URL'] || 'redis://127.0.0.1:6379/'
  end

  config.handlers.keepalive.url = 'https://diabot-slack.herokuapp.com'

  config.handlers.diabetes.lower_bg_bound = '1'
  config.handlers.diabetes.upper_bg_bound = '35'
end
