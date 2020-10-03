import Mix.Config


# Use faster html parser
config :floki, :html_parser, Floki.HTMLParser.FastHtml


# Global configuration for crawlers
config :burrow, 
    robots: true,
    identify: true,
    auto_throttle: [
        enable: true,
        delay: 5,
        max_delay: 60, # Maximal download delay on high latency
        target_concurrency: 10
    ],
    concurrency: [
        domain: 10,
        ip: 0
    ],
    contact: [
        firstname: "John",
        lastname: "Doe"
        email: "john.doe@mail.com",
        company: "Some Company"
    ]