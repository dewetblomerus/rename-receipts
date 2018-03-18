require IEx

defmodule Rename do
  @source_path "/Users/dewetblomerus/Downloads/"
  @destination_path "/Users/dewetblomerus/Downloads/"

  def receipts do
    @source_path <> "*"
    |> Path.wildcard
    |> recurse
  end

  def recurse([head | tail]) do
    parse(head)
    |> decide
    recurse(tail)
  end

  def recurse([]) do
  end

  def decide(filename) do
    cond do
      Regex.match?(~r/paymentNotification|Standard/, filename) -> rename(filename)
      true -> IO.puts("Skipping #{filename}")
    end
  end

  def rename(filename) do
    newname_arr = [date(), "Blomerus", payee(filename), "R" <> amount(filename)]

    old_fullname = @source_path <> filename
    new_fullname = @destination_path <> Enum.join(newname_arr, " | ") <> extension(filename)
    File.rename(old_fullname, new_fullname)
  end

  def date do
    DateTime.utc_now |> Date.to_string
  end

  def payee(filename) do
    String.trim(IO.gets "Enter Payee Name for #{filename}\n")
  end

  def amount(filename) do
    String.trim(IO.gets "Enter amount for #{filename}\n")
  end

  def extension(filename) do
    letters =
      String.split(filename, ".")
      |> List.last

    "." <> letters
  end

  def parse(fullname) do
    @source_path <> name = fullname
    name
  end
end

Rename.receipts

