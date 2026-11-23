# Contributing to cxdocpkg

Thank you for your interest in contributing to the CX Document Packages! This
guide explains how to report problems, propose changes and get your work
merged.

## Table of contents

- [Ways to contribute](#ways-to-contribute)
- [Reporting bugs](#reporting-bugs)
- [Suggesting features](#suggesting-features)
- [Development setup](#development-setup)
- [Project layout](#project-layout)
- [Coding conventions](#coding-conventions)
- [Examples and testing](#examples-and-testing)
- [Versioning](#versioning)
- [Branching strategy](#branching-strategy)
- [Commits and pull requests](#commits-and-pull-requests)
- [Code review checklist](#code-review-checklist)
- [Licensing of contributions](#licensing-of-contributions)
- [Contact](#contact)

## Ways to contribute

- **Report bugs** you find when using the class or packages.
- **Suggest features** or improvements to the document style.
- **Improve documentation and examples** in `README.md` and `examples/`.
- **Contribute code** to the LaTeX class and packages in `src/`.

## Reporting bugs

Open a GitHub issue and include:

1. Your TeX distribution and engine version (output of `lualatex --version`).
2. A **minimal** `.tex` file that reproduces the problem.
3. The relevant excerpt of the `.log` file (errors or warnings).
4. What you expected to happen and what actually happened (a screenshot of
   the PDF helps).

Please search existing issues first to avoid duplicates.

## Suggesting features

Open an issue describing the use case before starting any significant work,
so the design can be discussed first. State which component the change
affects:

- `cxdoc`: document class (page layout, cover, title and back pages, headers,
  etc.).
- `cxtrace`: traceability items (requirements, tests, test results,
  checkpoints).

## Development setup

### Prerequisites

- A TeX Live installation with **LuaLaTeX** and **latexmk**.
- **GNU make**.

> A Docker image with the reference TeX toolchain is planned, to provide
> reproducible builds and to be used by CI/CD. Until then, use a local TeX
> Live installation.

### Building

```sh
make        # build every example in examples/ into build/
make clean  # remove build artifacts
```

The Makefile sets `TEXINPUTS=src//:`, so the examples pick up the class and
packages straight from `src/` without installing them.

## Project layout

| Path          | Contents                                                |
| ------------- | ------------------------------------------------------- |
| `src/<name>/` | One directory per class or package (`<name>.cls/.sty`). |
| `examples/`   | Example documents, also used to check the build.        |
| `LICENSES/`   | Full texts of the licenses used in the project.         |

See the [README](README.md#structure) for the full tree.

## Coding conventions

- Follow [`.editorconfig`](.editorconfig): UTF-8, LF line endings,
  **8-space indentation**, final newline, no trailing whitespace, lines of at
  most **80 columns**. Makefiles use tabs.
- Every new file starts with an **SPDX license identifier** matching its type
  (see [Licensing of contributions](#licensing-of-contributions)). New
  `.cls`/`.sty` files must also include the copyright notice, LPPL statement
  and maintainer block used in the existing files.
- Each class or package lives in its own directory: `src/<name>/<name>.cls`
  or `src/<name>/<name>.sty`.
- The name in `\ProvidesClass`/`\ProvidesPackage` must match the file name.
- Internal macros contain `@` and are prefixed with the package name (e.g.
  `\cxdoc@title`, `\cxtrace@id`) to avoid clashes.
- Load dependencies with `\RequirePackage` and define user-facing commands
  and environments with `\NewDocumentCommand`/`\NewDocumentEnvironment`.
- Group code using the existing section banner comments and comment anything
  non-obvious.

## Examples and testing

There is no automated test suite yet; the examples are the tests.

- Every user-facing feature must be shown in a file under `examples/` (extend
  an existing one or add a new one).
- `make` must build **all** examples without errors and without new warnings.
- Open the generated PDFs in `build/` and check the output visually.

## Versioning

The project follows [Semantic Versioning](https://semver.org/)
(`MAJOR.MINOR.PATCH`):

- **MAJOR**: breaking changes (removed or renamed options, commands or
  environments; layout changes that break existing documents).
- **MINOR**: new backwards-compatible features.
- **PATCH**: backwards-compatible fixes.

When a class or package changes behaviour, update the date (`YYYY/MM/DD`) and
version in its `\ProvidesClass`/`\ProvidesPackage` line, e.g.:

```latex
\ProvidesClass{cxdoc}[2026/11/22 v0.1.0 CX Project document class]
```

## Branching strategy

The repository uses two protected, long-lived branches. Nobody pushes to them
directly; every change goes through a pull request.

| Branch | Purpose                                             | Tags         |
| ------ | --------------------------------------------------- | ------------ |
| `dev`  | Integration branch. All work is merged here first.  | `vX.Y.Z-rcN` |
| `main` | Stable branch. Only contains approved releases.     | `vX.Y.Z`     |

Workflow:

1. Create a branch from `dev`, named `feature/<short-name>` or
   `fix/<short-name>`.
2. Before merging, rebase it onto the latest `dev`.
3. Merge into `dev` **fast-forward only**, keeping a linear history.
4. When `dev` is ready for a release, tag a release candidate on `dev`:
   `vX.Y.Z-rcN` (e.g. `v0.2.0-rc1`, `v0.2.0-rc2`, ...).
5. Once a release candidate is validated, fast-forward `main` to that commit
   and tag it as the release: `vX.Y.Z`.

```text
feature/foo     o---o
               /     \  (rebase + fast-forward)
dev  ---o-----o-------o---o---o
                          |   |
                   v0.2.0-rc1 v0.2.0-rc2
                              |  (fast-forward once approved)
main ---o---------------------o
                            v0.2.0
```

Typical commands for keeping your branch up to date:

```sh
git fetch origin
git rebase origin/dev
git push --force-with-lease
```

## Commits and pull requests

- Keep each pull request to **one logical change**, and open it against
  `dev`.
- Write commit subjects in the imperative mood, at most ~72 characters (e.g.
  `Add checkpoint environment to cxtrace`), with a body explaining *why* when
  useful.
- Keep commits small and self-contained; squash fixup commits before merging.
- Reference related issues in the pull request description (e.g.
  `Closes #12`).
- Go through the [code review checklist](#code-review-checklist) before
  requesting a review.

> GitHub issue and pull request templates (`.github/ISSUE_TEMPLATE/` and
> `.github/pull_request_template.md`) are planned and will be added in the
> future.

## Code review checklist

Authors should self-check these items before opening a pull request, and
reviewers verify them during the review.

- [ ] **Builds cleanly**: `make` succeeds with no errors and no new warnings
      (including overfull/underfull boxes and undefined references). The PDF
      output was checked visually.
- [ ] **Readable**: follows `.editorconfig`; sections and non-obvious macros
      are commented; names are meaningful.
- [ ] **Safe**: no `\write18` or `--shell-escape` requirements; no reading or
      writing files other than the document's own auxiliary files; no network
      access.
- [ ] **Namespaced**: internal macros use the package prefix and `@`; kernel
      or third-party commands are not redefined globally unless documented
      and guarded.
- [ ] **Backwards compatible**: existing documents and options keep working,
      or the breaking change is documented and comes with a MAJOR version
      bump.
- [ ] **Dependencies**: any new `\RequirePackage` is justified and available
      in a standard TeX Live installation.
- [ ] **Single responsibility**: the change belongs to the component it
      touches (`cxdoc` for layout and style, `cxtrace` for traceability
      items).
- [ ] **Documented**: `README.md` and `examples/` are updated for user-facing
      changes.
- [ ] **Licensed**: SPDX identifiers are correct; new `.cls`/`.sty` files
      include the copyright and maintainer blocks.
- [ ] **Versioned**: the `\Provides…` date and version are updated if
      behaviour changed.
- [ ] **Clean history**: the branch is rebased on `dev`, history is linear
      and commit messages describe the changes.

## Licensing of contributions

This project uses several licenses depending on the file type (see
[LICENSE.txt](LICENSE.txt) and [LICENSES/](LICENSES/)):

| Files                       | License   | SPDX identifier |
| --------------------------- | --------- | --------------- |
| LaTeX classes and packages  | LPPL 1.3c | `LPPL-1.3c`     |
| Documentation and examples  | CC BY 4.0 | `CC-BY-4.0`     |
| Everything else (build ...) | MIT       | `MIT`           |

Write the identifier as a comment on the first line of the file, e.g.
`% SPDX-License-Identifier: LPPL-1.3c` in LaTeX files or
`# SPDX-License-Identifier: MIT` in Makefiles and configuration files.

By submitting a contribution, you agree that it is licensed under the same
license as the files it modifies or adds.

## Contact

For questions that do not fit in an issue, write to <carlosmadrid@gmail.com>.
