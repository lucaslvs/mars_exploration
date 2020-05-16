alias MarsExploration.Core

{:ok, highland} = Core.create_highland(5, 5)

{:ok, probe1} = Core.create_probe(1, 2, "N", ["L", "M", "L", "M", "L", "M", "L", "M", "M"])
{:ok, probe2} = Core.create_probe(3, 3, "E", ["M", "M","R", "M", "M", "R", "M", "R", "R", "M"])

{:ok, highland} = Core.set_probe_in_highland(highland, probe1)
{:ok, highland} = Core.set_probe_in_highland(highland, probe2)


{:ok, %{probes: [probe1, _probe2]} = highland} = Core.perform_next_action(highland, probe1)
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_next_action(highland, probe2)
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
{:ok, %{probes: [probe1, _probe2]} = highland} = Core.perform_next_action(highland, probe1)
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_next_action(highland, probe2)
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
{:ok, %{probes: [probe1, _probe2]} = highland} = Core.perform_next_action(highland, probe1)
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_next_action(highland, probe2)
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
{:ok, %{probes: [probe1, _probe2]} = highland} = Core.perform_next_action(highland, probe1)
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_next_action(highland, probe2)
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
{:ok, %{probes: [probe1, _probe2]} = highland} = Core.perform_next_action(highland, probe1)
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_next_action(highland, probe2)
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
{:ok, %{probes: [probe1, _probe2]} = highland} = Core.perform_next_action(highland, probe1)
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_next_action(highland, probe2)
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
{:ok, %{probes: [probe1, _probe2]} = highland} = Core.perform_next_action(highland, probe1)
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_next_action(highland, probe2)
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
{:ok, %{probes: [probe1, _probe2]} = highland} = Core.perform_next_action(highland, probe1)
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_next_action(highland, probe2)
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
{:ok, %{probes: [probe1, _probe2]} = highland} = Core.perform_next_action(highland, probe1)
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_next_action(highland, probe2)
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
{:ok, %{probes: [_probe1, probe2]} = highland} = Core.perform_next_action(highland, probe2)

IO.inspect highland
IO.inspect Core.all_probe_actions_have_been_completed?(highland), label: "all_probe_actions_have_been_completed?"
