# app/services/mqtt_service.rb
class MqttService
  def initialize
    @client = MQTT::Client.new(host: 'localhost', port: 1883)
    @client.connect
  end

  def subscribe(topic)
    @client.subscribe(topic)
    @client.get do |topic, message|
      handle_message(topic, message)
    end
  end

  private

  def handle_message(topic, message)
    return if Temp.exists?(message: message)
    
    Temp.create(message: message)
    broadcast_new_temp_to_clients
  end

  def broadcast_new_temp_to_clients
    rendered_view = ApplicationController.render(
      partial: 'mqtt/temp',
      locals: { temp: Temp.last }
    )

    ActionCable.server.broadcast('temp-messages', rendered_view)
  end
end
