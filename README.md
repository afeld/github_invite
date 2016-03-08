# GitHub Invite [![Build Status](https://travis-ci.org/afeld/github_invite.svg?branch=master)](https://travis-ci.org/afeld/github_invite)

App to enable GitHub users to easily add others to their organization teams.

## Running locally

Requires [Ruby](https://www.ruby-lang.org) 1.9.3+ and [PostgreSQL](http://www.postgresql.org).

### Server

1. [Create a new application](https://github.com/settings/applications/new), and grab the "Client ID" and "Client Secret".
1. Create a `.env.development` file with the following variables:

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

## See also

* https://developer.github.com/v3/orgs/teams/#add-team-member
* https://github.com/benbalter/add-to-org
* https://github.com/benbalter/squad_goals
* https://github.com/education/teachers_pet/#giving-others-access
