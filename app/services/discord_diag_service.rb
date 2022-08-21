require "discordrb/webhooks"

class DiscordDiagService
  def initialize(diag_title, message, is_error, entities = [])
    @diag_title = diag_title
    @message = message
    @is_error = is_error
    @entities = entities
    @emoji = {
      error: '❌',
      success: '✅',
    }
  end

  def send_diag_result
    url_webhook = ENV["DISCORD_WEBHOOKS"]
    client = Discordrb::Webhooks::Client.new(url: url_webhook)
    client.execute do |builder|
      builder.content = "Diag running !"
      builder.add_embed do |embed|
        embed.title = manage_message_title
        embed.description = "#{@message} \n \n"
        @entities.each do
          |entity|
          embed.description += "#{entity.attributes.to_s} \n \n"
        end
        embed.timestamp = Time.zone.now
      end
    end
  end

  private

  def manage_message_title
    if @is_error
      "#{@diag_title} #{@emoji[:error]}"
    else
      "#{@diag_title} #{@emoji[:success]}"
    end
  end
end
