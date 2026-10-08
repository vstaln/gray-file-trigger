# gray-file-trigger

Per-path reminders appended to write/edit results — a gray sidecar plugin
named after pi's `file-trigger` extension (the semantics follow the port
spec: glob rules, not pi's watched-file injection).

Rules live in `~/.gray/file-trigger/rules.json` (honors `$GRAY_HOME`):

```json
[{"glob": "**/*.rs", "message": "ran cargo fmt check yourself"}]
```

`tool/after` doesn't carry call args, so `tool/before` stashes the
write's path per `(session, tool)`; `tool/after` matches it against the
globs and appends each matching message to the tool result. Write-shaped
tools: `write`, `edit`, `patch`, `write_file`, `apply_patch`,
`multi_edit`, `notebook_edit` (path read from `path`, `file_path`, or the
first `*path*` arg).

Entries with a missing `glob`/`message` or an invalid glob are skipped
(`/trigger list` flags invalid globs).

## Commands

- `/trigger list` — show loaded rules
- `/trigger reload` — re-read `rules.json` without restarting

## Wire methods used

- `plugin/manifest`, `plugin/shutdown`
- `tool/before` (hook) — stashes the write's path (always `allow`)
- `tool/after` (hook) — appends matching messages to result content
- `command/run` — `/trigger`

## Install

```sh
gray plugin install file-trigger
```

## Develop

```sh
cargo test
cargo build --release
gray account check
```
