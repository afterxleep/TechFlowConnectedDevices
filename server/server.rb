require "em-websocket"

EventMachine.run do
  @channel = EM::Channel.new

  EventMachine::WebSocket.start(host: "96.126.123.134", port: 3000, debug: true) do |ws|
    ws.onopen do
      sid = @channel.subscribe { |msg| ws.send(msg) }
      @channel.push("#{sid} connected")

      ws.onmessage { |msg| @channel.push("#{msg}") }

      ws.onclose { @channel.unsubscribe(sid) }
    end
  end
end
