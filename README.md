# branch and build flow

```
master -> sanemat/app-base.tachikoma.io:latest
released -> sanemat/app-base.tachikoma.io:released
```

# develop

If you want to update application docker file, you can send pull request from `feature/some-update` to `master` branch.
You confirm update, then you can send pull request from `master` to `released`.
