defmodule Burrow.Crawler.Policy do

    @moduledoc """
        Policy regulates the crawling behavior.

        Options:
            robots: Respect the robots.txt?
            identify: Identifiy with set contact information?
            auto_throttle: Throttle options to prevent overloading of target
                delay: Delay of requests (min-delay)
                max_delay: Maximum delay of requests
                target_concurrency: 

            concurrecny: How many parallel crawlers
                domain: per domain
                ip: per ip
            
            hide: Cloaking options to hide crawling behavior
                agents: Switch user agents
                behavior: Switch up crawling behavior
                proxy: Use proxies for requests

            contact: Contact information to identifiy the crawler
                firstname: Firstname of the creator
                lastname: Last name of the creator
                email: The email of the creator
                company: The company of the creator
    """

    defstruct [
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
        hide: [
            agents: false,
            behavior: false,
            proxy: false
        ],
        contact: [
            firstname: "John",
            lastname: "Doe",
            email: "john.doe@mail.com",
            company: "Some Company"
        ]
    ]

    defmodule Spec do

        # Request made via policy
        @callback request(url :: String.t()) :: any
    end
end