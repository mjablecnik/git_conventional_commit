# git-conventional-commit
Simple command for create your conventional commits.


## Install
Run command: `bin/build-and-install.sh`


## Usage:
```
-t, --type        Commit type.
-m, --message     Commit message.
-s, --scope       Commit scope.
-b, --breaking    Set commit as breaking change.
    --amend       Change last commit.
-h, --help        Print this usage information.
-V, --verbose     Show additional command output.
-v, --version     Print the tool version.
```


## Example
```
dart lib/main.dart -t feat -m "Add new feature" -b -s '#1234'
```
or
```
dart lib/main.dart -m "Add new feature"
```


## Special thanks

 - [Dart](https://dart.dev/): Client-optimized language for fast apps on any platform.


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.


## Author

👤 **Martin Jablečník**

* Website: [martin-jablecnik.cz](https://www.martin-jablecnik.cz)
* Github: [@mjablecnik](https://github.com/mjablecnik)
* Blog: [dev.to/mjablecnik](https://dev.to/mjablecnik)


## Show your support

Give a ⭐️ if this project helped you!

<a href="https://www.patreon.com/mjablecnik">
  <img src="https://c5.patreon.com/external/logo/become_a_patron_button@2x.png" width="160">
</a>


## 📝 License

Copyright © 2024 [Martin Jablečník](https://github.com/mjablecnik).<br />
This project is [GNU GPLv3 License](https://choosealicense.com/licenses/gpl-3.0/) licensed.


