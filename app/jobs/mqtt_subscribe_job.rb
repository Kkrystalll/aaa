class MqttSubscribeJob < ApplicationJob
  def perform
    mqtt_service = MqttService.new
    mqtt_service.subscribe('test')
  end
end