require IEx

defmodule Rename do
  @downloads Path.expand("~/Downloads") <> "/"
  @source_path @downloads
  @destination_path @downloads

  def receipts do
    (@source_path <> "*")
    |> Path.wildcard()
    |> Enum.map(&parse_name/1)
    |> Enum.each(&decide/1)
  end

  def decide(filename) do
    input =
      IO.gets("Do you want to rename #{filename} ?")
      |> String.trim()
      |> String.downcase()

    execute(input, filename)
  end

  def execute("y", filename) do
    rename(filename)
  end

  def execute("n", filename) do
    IO.puts("Skipping #{filename}")
  end

  def rename(filename) do
    newname_arr = [date(), "Blomerus", payee(filename), "$" <> amount(filename)]

    old_fullname = @source_path <> filename
    new_fullname = @destination_path <> Enum.join(newname_arr, " | ") <> extension(filename)
    File.rename(old_fullname, new_fullname)
  end

  def date do
    DateTime.utc_now() |> Date.to_string()
  end

  def payee(filename) do
    IO.gets("Enter Payee Name for #{filename}\n") |> String.trim()
  end

  def amount(filename) do
    IO.gets("Enter amount for #{filename}\n") |> String.trim()
  end

  def extension(filename) do
    letters =
      String.split(filename, ".")
      |> List.last()

    "." <> letters
  end

  def parse_name(fullname) do
    @source_path <> name = fullname
    name
  end
end

Rename.receipts()
