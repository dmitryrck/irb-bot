require './boot'
require 'cinch'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.freenode.net'
    c.channels = Channel.all.map(&:name)
    c.nick = ENV['NICK']
    c.password = ENV['PASSWORD']
  end

  on :channel do |message|
    Message.create :nick => message.user.nick, :message => message.message, :channel => message.channel.name
  end
end

bot.start
