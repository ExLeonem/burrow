defmodule Burrow.Com.Request do
    @moduledoc false

    defstruct [
        method: nil,
        url: nil,
        headers: [],
        body: "",
        opts: []
    ]
    
    alias Burrow.Com.{ERror, Request}

end