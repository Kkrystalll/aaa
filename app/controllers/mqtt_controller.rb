class MqttController < ApplicationController
  def index
    MqttSubscribeJob.perform_later
    @temps = Temp.all
  end
  def subscribe
  end
end
