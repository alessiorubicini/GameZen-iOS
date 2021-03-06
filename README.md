<h1 align="center">GameZen iOS</h1>

<div align="center" style="padding-top: 5x; padding-bottom: 30px;">
	<img width="256" height="256" src=".github/logo.png">
</div>

NOTA: questo README è disponibile anche [in Inglese](README_EN.md).

NOTE: this README is also available [in English](README_EN.md).

# Sommario

- [Contesto](#contesto)
- [Struttura repository](#struttura-repository)
- [Installazione](#installazione)
- [Licenza](#licenza)
	- [Autori/Copyright](#autori/copyright)
	- [Librerie di terze parti](#librerie-di-terze-parti)
	- [Dettagli licenza](#dettagli-licenza)


# Contesto
Questa repository contiene il codice sorgente del client iOS di GameZen, un'app iOS per un negozio online di giochi da tavolo. Questo progetto è stato realizzato dallo studente Alessio Rubicini come elaborato per l'Esame di Stato del II ciclo 2020/2021. L'applicazione è stata quindi realizzata a puro scopo didattico.

Per il documento finale dell'elaborato, consultare il file [Elaborato.pdf](./Elaborato.pdf).

Per informazioni sul prodotto in generale, consultare il file [Product.md](docs/Product.md).

Per informazioni sulle tecnologie utilizzate, consultare il file [Technology.md](docs/Technology.md).

# Struttura repository

├── api:                 Servizi backend<br>
├── app:                 Applicazione iOS<br>
├── database:            Database e relativa documentazione<br>
├── design:              Mockup, icone e assets vari<br>
├── docs:                Documentazione<br>
├── Elaborato.pdf:       Relazione finale dell'elaborato<br>
├── LICENSE:             Licenza del progetto<br>
├── README_EN.md:        File in inglese contenente informazioni sulla repository<br>
└── README.md:           File in italiano contenente informazioni sulla repository

# Installazione

Requisiti:
- macOS 11.0 o superiore
- Xcode 12.0 o superiore

```bash
git clone https://github.com/alessiorubicini/GameZen-iOS

cd GameZen-iOS/app

pod install
```

Apri il file `GameZen.xcworkspace`.


# Licenza

## Autori/Copyright

Copyright 2021 (©) Alessio Rubicini.

Controllare il file AUTHORS per un riferimento completo.


## Librerie di terze parti

| Nome                                                        | Licensa                   |
| ----------------------------------------------------------- | ------------------------- |
| [Alamofire](https://github.com/Alamofire/Alamofire)         | MIT                       |
| [SwiftUIX](https://github.com/SwiftUIX/SwiftUIX)			  | MIT                       |
| [SwiftUIComponents](https://github.com/alessiorubicini/SwiftUI-Components)                                    | MIT |
| [StatusAlert](https://github.com/LowKostKustomz/StatusAlert)			  | MIT                       |
| [Cocoapods](https://cocoapods.org/)                         | MIT                       |
| [Fastlane](https://fastlane.tools)                         | MIT                       |


## Dettagli licenza

La licenza per questa repository è [GNU Affero General Public License versione 3](https://www.gnu.org/licenses/agpl-3.0.html) (SPDX: AGPL-3.0). Si prega di consultare il file [LICENSE](LICENSE) per riferimento completo.