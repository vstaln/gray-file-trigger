<p align="center">
  <img src="assets/gray-logo.svg" alt="gray" width="96">
</p>
<h1 align="center">gray-file-trigger</h1>
<p align="center">Per-glob reminder messages appended to write/edit tool results.</p>
<p align="center">
  <a href="https://github.com/vstaln/gray-file-trigger/blob/main/LICENSE"><img alt="MIT License" src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
  <img alt="gray plugin" src="https://img.shields.io/badge/gray-plugin-7aa2f7.svg">
  <img alt="rust" src="https://img.shields.io/badge/built%20with-rust-orange.svg">
</p>

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

---
Part of the [gray](https://github.com/vstaln/gray) plugin ecosystem —
the open-source AI agent harness. <https://gray.alignment.id>
