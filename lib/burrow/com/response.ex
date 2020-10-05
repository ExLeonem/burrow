defmodule Burrow.Com.Response do
    @moduledoc false

    defstruct [
        status_code: nil,
        headers: [],
        body: "",
        complete: false,
        size: 0
    ]

    @type t :: Burrow.Com.Response
end