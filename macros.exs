defmodule Unless do
  def fun_unless(clause, expression) do
    if(!clause, do: expression)
  end

  defmacro macro_unless(clause, expression) do
    quote do
      if(!unquote(clause), do: unquote(expression))
    end
  end
end

defmodule TestCase do
  defmacro __using__(_opts) do
    quote do
      import TestCase
      @tests []

      @before_compile TestCase
    end
  end

  defmacro test(message, do: block) do
    function_name = String.to_atom("test " <> message)
    quote do
      @tests [unquote(function_name)|@tests]
      def unquote(function_name)(), do: unquote(block)
    end
  end

  defmacro __before_compile__(env) do
    quote do
      def run do
        Enum.each @tests, fn test ->
          IO.puts "Running #{test}"
          apply(__MODULE__, test, [])
        end
      end
    end
  end
end
