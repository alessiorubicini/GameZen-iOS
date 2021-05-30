<h1 align="center">GameZen iOS</h1>

<div align="center" style="padding-top: 5x; padding-bottom: 30px;">
	<img width="256" height="256" src=".github/logo.png">
</div>

NOTE: this README is also available [in Italian](README.md).

NOTA: questo README è disponibile anche [in Italiano](README.md).

# Summary

- [Context](#context)
- [Repository structure](#repository-structure)
- [Installation](#installation)
- [License](#license)
	- [Authors/Copyright](#authors/copyright)
	- [Third-party components](#third-party-components)
	- [License details](#license-details) 


# Context
This repository contains the source code of GameZen's iOS client, an iOS app for an online table games store. This project was created by the student Alessio Rubicini as an elaborate for the 2020/2021 high school State Exam. The application was therefore created for educational purposes only.

For the final document, consult the file [Elaborato.pdf](elaborato.pdf).

For general product information, see the [Product.md](docs/Product.md) file.

For information on the used technologies, see the [Technology.md](docs/Technology.md) file.

# Repository structure


├── api:                 Backend services<br>
├── app:                 iOS application<br>
├── database:            Database and related documentation<br>
├── design:              Mockups, icons and various assets<br>
├── docs:                Documentation<br>
├── Elaborato.pdf:       Final report<br>
├── LICENSE:             Project's license<br>
├── README_EN.md:        English file containing information about the repository<br>
└── README.md:           Italian file containing information about the repository

# Installation

Requirements:
- macOS 11.0 or above
- Xcode 12.0 or above

```bash
git clone https://github.com/alessiorubicini/GameZen-iOS

cd GameZen-iOS/app

pod install
```

Then open `GameZen.xcworkspace` file.

# License

## Authors/Copyright

Copyright 2021 (©) Alessio Rubicini.

Check the AUTHORS file for extended reference.


## Third-party components

| Name                                                        | License                   |
| ----------------------------------------------------------- | ------------------------- |
| [Alamofire](https://github.com/Alamofire/Alamofire)         | MIT                       |
| [SwiftUIX](https://github.com/SwiftUIX/SwiftUIX)			  | MIT                       |
| [SwiftUIComponents](https://github.com/alessiorubicini/SwiftUI-Components)                                    | MIT |
| [StatusAlert](https://github.com/LowKostKustomz/StatusAlert)			  | MIT                       |
| [Cocoapods](https://cocoapods.org/)                         | MIT                       |
| [Fastlane](https://fastlane.tools)                         | MIT                       |


## License details

The licence for this repository is a [GNU Affero General Public Licence version 3](https://www.gnu.org/licenses/agpl-3.0.html) (SPDX: AGPL-3.0). Please see the [LICENSE](LICENSE) file for full reference.