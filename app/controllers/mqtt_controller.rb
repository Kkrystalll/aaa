class MqttController < ApplicationController
  def subscribe
    
    MQTT::Client.connect('mqtt://localhost:1883') do |client|
      client.subscribe('test')
      
      client.get('test') do |topic, message|
        
        utf8_message = message.force_encoding('UTF-8')
        
        # 使用 Turbo Streams 更新前端
        render turbo_stream: turbo_stream.append('mqtt-messages', partial: 'mqtt/message', locals: { message: message })
        return
      end
    end

    render plain: 'Subscribed to MQTT topic'
  end
end
