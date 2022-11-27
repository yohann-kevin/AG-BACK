class StatusController < ApplicationController
  skip_before_action :authorized, only: %i[status]

  def status
    begin
      puts "ActiveRecord version: #{ActiveRecord::Migrator.current_version}"
      render json: { message: 'connection ok !' }
    rescue => exception
      render :status => 500
    end
  end
end
