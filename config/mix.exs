import Config

config :burrow,
    rate_limit: 100, process_count: 10,
    obscure: [proxy: true, agents: true, behavior: true]