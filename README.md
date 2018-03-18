# Rename Receipts

This renames receipts of Electronic Transfers to give them a searchable and meaningful name.

### Setup

Add the following to your `.bashrc`, `.profile` or `.zshrc`.

```bash
alias rename="elixir ~/code/elixir/rename-receipts/rename_receipts.exs"
```
Run the following to let it take effect (you could also restart).

```
source path_to_the_file_you_created_the_alias
```

From now on you can run the program by just typing `rename` at the command line.

