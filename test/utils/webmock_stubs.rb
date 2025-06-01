# frozen_string_literal: true

# Stubs for webmock
module WebmockStubs
  def stub_turnstile_site_verify(
    response_body: {
      "success" => true,
      "error-codes" => [],
      "challenge_ts" => "2025-06-01T22:58:13.759Z",
      "hostname" => "example.com",
      "metadata" => {
        "result_with_testing_key" => true
      }
    },
    request_secret: ENV.fetch("TURNSTILE_SECRET_KEY"),
    request_response: "XXXX.DUMMY.TOKEN.XXXX"
  )
    request_body = {
      secret: request_secret,
      response: request_response
    }

    stub_request(:post, "https://challenges.cloudflare.com/turnstile/v0/siteverify")
      .with(
        body: request_body.to_json,
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding" => "gzip, deflate",
          "Content-Type" => "application/json; charset=utf-8"
        }
      )
      .to_return(
        status: 200,
        body: response_body.to_json,
        headers:
          { "date" => "Sun, 01 Jun 2025 23:14:11 GMT",
            "content-type" => "application/json",
            "vary" => "Accept-Encoding",
            "server" => "cloudflare",
            "cf-ray" => "949267e47e1421b4-GDL",
            "content-encoding" => "gzip",
            "alt-svc" => "h3=\":443\"; ma=86400" }
      )
  end
end
