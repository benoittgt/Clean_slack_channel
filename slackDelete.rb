require 'json'
require 'net/http'

def get_object
  uri = URI('https://slack.com/api/channels.history?token=xoxp-YOURTOKEN-TOKEN-TOKEN-f2fcf1&channel=C02UCDA&pretty=1')
  jsonObject = JSON.parse(Net::HTTP.get(uri))
  return if jsonObject["ok"] = false
  remove_message(jsonObject["messages"].map {|elem| elem["ts"]})
  get_object
end

def remove_message(ts)
 return if ts.empty?
 first_ts, *other_ts = ts
 puts "Key is #{first_ts}"
 uri = URI("https://slack.com/api/chat.delete?token=xoxp-YOURTOKEN-TOKEN-TOKEN-f2fcf1&ts=#{first_ts}&channel=C02UCDA")
 res = Net::HTTP.get(uri)
 puts "Response is #{res.inspect["ok"]}"
 remove_message(other_ts)
end

get_object
