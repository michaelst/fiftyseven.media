defmodule Utils.Decimal do
  @doc "compare two Decimal values for equality"
  def left <~> right when is_number(left) or is_number(right), do: ensure(left) <~> ensure(right)

  def left <~> right do
    Decimal.cmp(left, right) == :eq
  end

  @doc "subtract two Decimal values"
  def left ||| right when is_number(left) or is_number(right), do: ensure(left) ||| ensure(right)

  def left ||| right do
    Decimal.sub(left, right)
  end

  @doc "add two Decimal values"
  def left &&& right when is_number(left) or is_number(right), do: ensure(left) &&& ensure(right)

  def left &&& right do
    Decimal.add(left, right)
  end

  @doc "divide two Decimal values"
  def left | right when is_number(left) or is_number(right), do: ensure(left) | ensure(right)

  def left | right do
    Decimal.div(left, right)
  end

  @doc "multiply two Decimal values"
  def left ^^^ right when is_number(left) or is_number(right), do: ensure(left) ^^^ ensure(right)

  def left ^^^ right do
    Decimal.mult(left, right)
  end

  @doc "simple conversions"
  def int(%{__struct__: Decimal} = decimal), do: Decimal.to_integer(decimal)
  def float(%{__struct__: Decimal} = decimal), do: Decimal.to_float(decimal)
  def decabs(%{__struct__: Decimal} = decimal), do: Decimal.abs(decimal)

  def sigil_d(number, []), do: Decimal.new(number)

  defp ensure(%{__struct__: Decimal} = decimal), do: decimal
  defp ensure(num) when is_number(num), do: Decimal.new(num)
  defp ensure(nil), do: Decimal.new(0)
end
