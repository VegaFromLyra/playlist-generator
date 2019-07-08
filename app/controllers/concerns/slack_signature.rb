module SlackSignature
  def authenticated?
    return false if timestamp.blank?
    return false if is_replay_attack?
    return false if expected_signature.blank?
    return false if actual_signature != expected_signature

    true
  end

  def timestamp
    request.headers["X-Slack-Request-Timestamp"].to_i
  end

  def expected_signature
    request.headers["X-Slack-Signature"]
  end

  def is_replay_attack?
    current_time = Time.current
    time_delta = (current_time - Time.at(timestamp).round) / 1.hour
    time_delta > 5.minutes
  end

  def actual_signature
    raw_signature = 'v0:' + timestamp.to_s + ':' + request.body.string
    digest = OpenSSL::HMAC::hexdigest(
      "SHA256",
      ENV.fetch("SLACK_SIGNING_SECRET"),
      raw_signature
    )
    "v0=#{digest}"
  end
end
