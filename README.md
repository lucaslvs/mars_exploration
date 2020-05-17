# MarsExploration

An executable to perform mars exploration with probes.

## Setup

- ### Requiriments
   make sure that you have elixir 1.8 or higher installed in your machine. If you don't have elixir installed in your machine, check [elixir documentation](https://elixir-lang.org/install.html) to install.

- ### Compiling the project and generate executable
  After you configure your machine with elixir, you have to compile the project and generate the executable. to do so, you can run:
  ```sh
  $ mix escript.build
  ```

## Running tests
  To running the application tests you can run in your terminal:
  ```sh
  $ mix test --trace
  ```

## Usage
  To perform probe exploration instructions, you can pass the file path to arguments of the executable. just running:
  ```sh
  $ ./mars_exploration /path/to/file.csv
  ```
