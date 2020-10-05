defmodule Progress.Policy do
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
        contact: [
            firstname: "John",
            lastname: "Doe",
            email: "john.doe@mail.com",
            company: "Some Company"
        ]
    ]

    defmodule Spec do
        @callback request() :: any
        
    end
end