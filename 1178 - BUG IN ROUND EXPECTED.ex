#https://www.beecrowd.com.br/judge/pt/problems/view/1179

defmodule BcParse do
  def str_to_float(str) do
    str
    |> Float.parse()
    |> elem(0)
  end

  def str_to_integer(str) do
    str
    |> Integer.parse()
    |> elem(0)
  end

  def float_to_str(number, precision \\ 2) do
    :erlang.float_to_binary(number, [decimals: precision])
  end

  def float_frac(number) do
    round((number - trunc(number)) * 100) / 100
  end

  def number_to_str(number) do
    if ((round(number * 100)) / 100) |> float_frac() == 0 do
      trunc((round(number * 100)) / 100)
    else
      float_to_str(number, 1)
    end
  end
end

defmodule BcInput do
  def input_as_float() do
    IO.gets("") |> BcParse.str_to_float
  end

  def input_as_integer() do
    IO.gets("") |> BcParse.str_to_integer
  end

  def input_as_float_array() do
    IO.gets("")
    |> String.split
    |> Enum.map(&(BcParse.str_to_float/1))
  end

  def input_as_integer_array() do
    IO.gets("")
    |> String.split
    |> Enum.map(&(BcParse.str_to_integer/1))
  end

  def input_n_integers(n_times) do
    do_input_n_integers(n_times, [])
    |> Enum.reverse()
  end

  defp do_input_n_integers(0, list), do: list
  defp do_input_n_integers(n_times, list) do
    input = BcInput.input_as_integer()
    do_input_n_integers(n_times - 1, [input | list])
  end

  def input_n_floats(n_times) do
    do_input_n_floats(n_times, [])
    |> Enum.reverse()
  end

  defp do_input_n_floats(0, list), do: list
  defp do_input_n_floats(n_times, list) do
    input = BcInput.input_as_float()
    do_input_n_floats(n_times - 1, [input | list])
  end
end

defmodule BcEnumAux do
  def is_in_range(value, {min, max}) when min > max, do: is_in_range(value, {max, min})
  def is_in_range(value, {min, max}), do: (value >= min) and (value <= max)
end

input = BcInput.input_as_float

Stream.iterate(input, & &1 / 2)
|> Enum.take(100)
|> Enum.with_index()
|> Enum.each(fn x -> IO.puts("N[#{elem(x, 1)}] = #{elem(x, 0) |> BcParse.float_to_str(4)}") end)


# Result in an error, some numbers not go as expected example test with 200.0000 the N[8] expected
# to be 0.7812 but correct is 0.7813
