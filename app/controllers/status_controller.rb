class StatusController < ApplicationController
  skip_before_action :authorized, only: %i[status]

  def status
    Rails.logger.debug "ActiveRecord version: #{ActiveRecord::Migrator.current_version}"
    render json: { message: "connection ok !" }
  rescue StandardError => e
    render json: e, status: :internal_server_error
  end
end
