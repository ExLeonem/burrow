defmodule Burrow.Error do
    @moduledoc false

    defstruct [:reason, :message]

    @type t :: Burrow.Error
end