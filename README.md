# Burrow
A framework for creation of (distributed) crawlers.

## Index

1. [Roadmap](#Roadmap)
2. [Crawling etiquette](#Crawling-etiquette)
3. [Getting started](#Getting-started)
4. [Mix Tasks](#Mix-tasks)
5. [Configuration](#Configuration)
 1. [Global](#Global)
 2. [Crawler](#Crawler)
6. [Tutorials](#Tutorials)
  1. [Create a crawler](#Create-a-crawler)
  2. Create a data sink

## Roadmap

- [ ] Configuration of Crawler (User-Agent Token, User Agent String)
- [ ] Crawling etiquette
  - [ ] Auto throttle of requests
  - [ ] Parse & Use robots.txt
  - [ ] Identify crawler admin by User-Agent
- [ ] Obscure crawling
  - [ ] Configurable proxies
  - [ ] Request rate limiting
  - [ ] Varying crawling patterns
  - [ ] Rotating user agents
  - [ ] Configurable use of webdriver like ([Hound](https://github.com/HashNuke/hound), [Wallaby](https://github.com/elixir-wallaby/wallaby))
  - [ ] Honeypot checks?
  - [ ] Captcha solving services?
  - [ ] Output a log defining which mechanism failed (Collect data on honeypots, javascript execution)?
<!-- - [ ] Middleware for crawler output -->

## Crawling etiquette
Yes, there are some rules for crawling web pages in a polite manner. Not following them will most likely get you banned from a page.

- Respect the robots.txt.
- Do not hit servers too frequently. This will degrate their performance. (~ request 6 pages per minute, equals human speed)
- Identify yourself by providing contact information in the header.



### Signs of beeing blocked by a website
How can you identify if you got banned from a website?

- Captcha pages
- Unusual content delivery delays
- Frequent response with HTTP404, 301, 50x errors

Frequent appearence of these HTTP responses also indicate blocking
- 301 Moved Temporarily
- 401 Unauthorized
- 404 Not Found
- 408 Request Timeout
- 429 Too Many Requests
- 503 Service Unavailable


<!-- ## Dependencies
Make sure following packages are installed on your system.

- elixir ~> 1.10
- erlang/OTP 23
- CMake (FastHTML binding) -->


## Getting started



## Mix tasks


| Name | Description
| --- |---
| brw.new | Create a new burrow application
| brw.gen.crawler | Create a new web crawler
| brw.gen.sink | Create a sink for data


## Configuration


### Global


| Key | Type | Description
| --- | --- | ---
| etiq | boolean() | Use complete and default etiquette settings. default: :true
| identify | boolean() | Identifying the crawler creator in the Request header, using contact information. default: false
| robots | boolean() | Using the robots.txt file to crawl the website. default: false
| [contact](#Contact-options) | keyword() | The contact informations to be used to identify the crawler creator



#### Contact options
Are used to identify the creator of the bot. Either the first name and last name should be passed or the company name.


| Key | Type | Description
| --- | ---  | ---
| firstname | String.t() | The firstname of the creator
| lastname | String.t() | The lastname of the creator
| company | String.t() | The company name
| email | String.t() | A contact e-mail


#### Example

```
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
```


#### Defaults

| Key | Value
| --- | ---
| etiq | true
| contact | [firstname: "", lastname: "", email: ""]



### Crawler
Can overwrite the global configurations




## Tutorials

### Create a burrow

```shell
$ mix brw.new <burrow-name>
```

| parameters | description
|--- |---
| --app | Application name
| --farm | 
| --plug | Create a REST API skeleton

### Create a crawler



**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `burrow` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:burrow, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/burrow](https://hexdocs.pm/burrow).

