
# AWSPEC

## How to run
# Simple Test with AWSpec

How to run a test from the compliance agents

```bash
cd tests directory
bundle install
TF_VAR_AWS_account_id=112131 bundle exec rspec
```

## Structure
```bash
tests
├── Gemfile (just copy paste)
├── Gemfile.lock (just copy paste, this pins the local versions to match the agents)
├── README.md (just copy paste)
└── spec
    ├── roles_spec.rb (your tests - can be multiple files)
    └── spec_helper.rb (just copy paste)
```
## Docs

Need some help - have a look at the [resource types](https://github.com/k1LoW/awspec/blob/master/doc/resource_types.md)
