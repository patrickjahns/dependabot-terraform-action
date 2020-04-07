# dependabot-terraform-action
![Build & Test &  Release](https://github.com/patrickjahns/dependabot-terraform-action/workflows/Build%20&%20Test%20&%20%20Release/badge.svg)
![license](https://img.shields.io/github/license/patrickjahns/dependabot-terraform-action)

Github action for running dependabot on terraform repositories with HCL 2.0 support

## Introduction

This action provides the functionality of [dependabot](https://github.com/dependabot/) for updating terraform files that utilize the HCL 2.0 ( terraform 0.12 ) syntax.
The github action was created, as dependabot currently [does not yet officially support HCL 2.0](https://github.com/dependabot/dependabot-core/issues/1176), however the community [already started work](https://github.com/dependabot/dependabot-core/pull/1388) on this.


## Usage

<!-- start usage -->
```yaml
- uses: patrickjahns/depedanbot-terraform-axtion@v1
  with:
    # Where to look for terraform files to check for dependency upgrades.
    # The directory is relative to the repository's root.
    # Default: "/"
    directory: ''

    # Branch to create pull requests against.
    # By default your repository's default branch is used.
    target_branch: ''

    # Auth token used to push the changes back to github and create the pull request with.
    # [Learn more about creating and using encrypted secrets](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets)
    # default: ${{ github.token }}
    token: ''

    # Auth token used for checking terraform dependencies that are from github repositories.
    # Token requires read access to all modules that you want to automatically check for updates
    # [Learn more about creating and using encrypted secrets](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets)
    # default: ${{ github.token }}
    github_dependency_token:         
```
<!-- end usage -->

## Examples

### Basic example 

In this basic example, the action will run everyday at 6 and check for dependency updates

```yaml
name: Update terraform dependencies
on:
  schedule:
    # run everyday at 6
    - cron:  '0 6 * * *'

jobs:
  dependabot-terraform:
    runs-on: ubuntu-latest
    steps:
      - name: update terraform dependencies
        uses: patrickjahns/dependabot-terraform-action@v1
        with:
          github_dependency_token: ${{ secrets.DEPENDENCY_GITHUB_TOKEN }}
```

## License

The scripts and documentation in this project are released under the [MIT License](LICENSE)