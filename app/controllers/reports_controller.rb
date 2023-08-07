class ReportsController < ApplicationController
  def visited_urls
    user_behaviors = UserBehavior.where(user_id: current_user.id).order(:timestamp)

    @visited_urls = []

    user_behaviors.each_with_index do |behavior, index|
      url = behavior.page_name
      timestamp = behavior.timestamp

      if index > 0
        previous_timestamp = user_behaviors[index - 1].timestamp
        time_spent = (timestamp - previous_timestamp).to_i
        formatted_time_spent = format_time(time_spent)
        @visited_urls << { url: url, timestamp: timestamp, time_spent: formatted_time_spent }
      else
        @visited_urls << { url: url, timestamp: timestamp, time_spent: nil }
      end
    end
  end

  private

  def format_time(seconds)
    if seconds < 60
      "#{seconds} seconds"
    elsif seconds < 3600
      "#{seconds / 60} minutes"
    else
      "#{seconds / 3600} hours"
    end
  end
end
