# Privacy

Add in env.yml any connection settings that you don't want to expose on Git or SVN
```
defaults: &defaults
  email: default@example.com

development:
  <<: *defaults
  email: development@example.com

test:
  <<: *defaults
  email: test@example.com

staging:
  <<: *defaults

production:
  <<: *defaults
```
And use them in your scripts as: Env.email