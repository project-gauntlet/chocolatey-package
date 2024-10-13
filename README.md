# Publishing new version

## Make changes
- Update versions in both places
- Update sha256

## Build
https://docs.chocolatey.org/en-us/create/create-packages/#build-your-package
```
choco pack
```

## Test
https://docs.chocolatey.org/en-us/create/create-packages/#testing-your-package
```
choco install gauntlet --debug --verbose --source . --force
choco uninstall gauntlet
```

## Publish
https://docs.chocolatey.org/en-us/create/create-packages/#push-your-package
```
choco apikey --api-key [API_KEY_HERE] -source https://push.chocolatey.org/
choco push gauntlet.[VERSION_HERE].0.0.nupkg --source https://push.chocolatey.org/
```