<div align="center">
  <img alt="gray-file-trigger" src="assets/icon.svg" width="120" height="120" />
  <h1>gray-file-trigger</h1>
  <p><strong>Attach a message to file writes that match a glob, checked after each write.</strong></p>
  <p>
    <a href="https://gray.alignment.id">Website</a> ·
    <a href="https://gray.alignment.id/plugins/gray-file-trigger">Store</a> ·
    <a href="https://github.com/vstaln/gray-file-trigger">Source</a> ·
    <a href="https://github.com/vstaln/gray">gray</a>
  </p>
  <p>
    <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-1c1c20?style=flat-square&labelColor=0a0a0b" /></a>
    <a href="https://www.rust-lang.org"><img alt="Built with Rust" src="https://img.shields.io/badge/built%20with-rust-1c1c20?style=flat-square&labelColor=0a0a0b&logo=rust&logoColor=d4a373" /></a>
    <a href="https://gray.alignment.id/plugins/gray-file-trigger"><img alt="gray plugin" src="https://img.shields.io/badge/gray-plugin-1c1c20?style=flat-square&labelColor=0a0a0b&color=7aa2f7" /></a>
  </p>
</div>

<br/>

```bash
gray plugin install gray-file-trigger
```

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

## Tags

`gray` `plugin` `file-trigger` `rust`

---
Part of the [gray](https://github.com/vstaln/gray) plugin ecosystem —
the open-source AI agent harness. <https://gray.alignment.id>
