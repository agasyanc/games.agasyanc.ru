class SwitcherChannel < ApplicationCable::Channel
  def subscribed
    stream_from "SwitcherChannel"

  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
