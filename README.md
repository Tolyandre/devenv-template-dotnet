# devenv + .NET + VS Code template

A minimal example of a .NET 10 solution developed inside a [devenv](https://devenv.sh) environment, with VS Code wired to use the devenv-provided SDK.

## What's inside

- `devenv.nix` — .NET SDK 10 from nixpkgs, `build`/`test` shell shortcuts, `devenv test` runs the test suite
- `devenv.yaml` + `devenv.lock` — pinned inputs for reproducible environments
- `.envrc` — automatic environment activation via [direnv](https://direnv.net)
- `.vscode/` — build/test tasks, run configuration, and solution auto-open; everything uses the `dotnet` resolved from devenv
- `ConsoleApp/` + `TestProject1/` — sample console app and xunit project (net10.0)

## Getting started

Prerequisites: [devenv](https://devenv.sh/getting-started/) and [direnv](https://direnv.net/docs/installation.html) hooked into your shell.

```bash
direnv allow    # activate the environment (first time only)
devenv test     # build the solution and run tests
```

## VS Code

Extensions used: devenv (`datakurre.devenv`), direnv (`mkhl.direnv`), C# (`ms-dotnettools.csharp`), C# Dev Kit (`ms-dotnettools.csdevkit`).

- **Run/debug**: F5 → *Launch ConsoleApp* (the pre-launch build task runs devenv's `dotnet`).
- **Tasks**: default build task + `test` task, both plain `dotnet` shell tasks executed inside the activated environment.

### Note on the Testing tab

C# Dev Kit discovers tests via a design-time build inside VS Code's extension host, which only sees the environment VS Code was launched with — devenv extensions cover terminals and tasks, but not the host process itself. So launch VS Code from an activated shell: `cd` into the repo (direnv activates), then `code .`.

## Gotchas

- devenv caches its evaluated environment in `.devenv/`, which is shared across git branch switches. If tools don't match `devenv.nix` (e.g. after checking out an older branch), force a clean re-evaluation: `rm -rf .devenv && devenv shell`.
