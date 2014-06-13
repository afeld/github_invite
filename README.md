# GitHub Invite

App to enable GitHub users to easily add others to their organization teams.

## Running locally

Requires [Ruby](https://www.ruby-lang.org) 1.9.3+ and [PostgreSQL](http://www.postgresql.org).

### Server

1. [Create a new application](https://github.com/settings/applications/new), and grab the "Client ID" and "Client Secret".
1. Create a `.env` file with the following variables:

    ```
    GITHUB_KEY=...
    GITHUB_SECRET=...
    ```
1. Run

    ```bash
    bundle
    rails s
    ```

### Testing

```bash
bundle
# then
bundle exec rspec
# or
bundle exec guard
```
