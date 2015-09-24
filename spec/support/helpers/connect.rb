module ConnectHelpers
  def connect
    # page.driver.block_unknown_urls

    visit "/"

    Timeout.timeout(5) do
      state = nil

      until state == "connected"
        state = page.evaluate_script("Pusher.instance.connection.state")
      end
    end
  end

  def connect_as(name)
    using_session(name) do
      connect
    end
  end
end

RSpec.configure do |config|
  config.include(ConnectHelpers)
end
