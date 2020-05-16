alias MarsExploration.Core

{:ok, highland} = Core.create_highland(5, 5)

{:ok, probe1} = Core.create_probe(1, 2, "N")
{:ok, probe2} = Core.create_probe(3, 3, "E")

{:ok, highland} = Core.set_probe_in_highland(highland, probe1)
{:ok, highland} = Core.set_probe_in_highland(highland, probe2)

{:ok, %{probes: [probe1, _probe2]} = highland} = Core.perform_action(highland, probe1, "L")

{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_action(highland, probe2, "M")

{:ok, %{probes: [probe1, _probe2]} = highland} = Core.perform_action(highland, probe1, "M")

{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_action(highland, probe2, "M")

{:ok, %{probes: [probe1, _probe2]} = highland} = Core.perform_action(highland, probe1, "L")

{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_action(highland, probe2, "R")

{:ok, %{probes: [probe1, _probe2]} = highland} = Core.perform_action(highland, probe1, "M")

{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_action(highland, probe2, "M")

{:ok, %{probes: [probe1, _probe2]} = highland} = Core.perform_action(highland, probe1, "L")

{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_action(highland, probe2, "M")

{:ok, %{probes: [probe1, _probe2]} = highland} = Core.perform_action(highland, probe1, "M")

{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_action(highland, probe2, "R")

{:ok, %{probes: [probe1, _probe2]} = highland} = Core.perform_action(highland, probe1, "L")

{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_action(highland, probe2, "M")

{:ok, %{probes: [probe1, _probe2]} = highland} = Core.perform_action(highland, probe1, "M")

{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_action(highland, probe2, "R")

{:ok, %{probes: [probe1, _probe2]} = highland} = Core.perform_action(highland, probe1, "M")

{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_action(highland, probe2, "R")

{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_action(highland, probe2, "M")

IO.inspect highland
