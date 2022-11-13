# Flutter Skilleos UseCase

A Skilleos usecase with Flutter using the [Rick and Morty API](https://rickandmortyapi.com/).

## Getting Started

In order to build and run the app :
- Open terminal at project location
- Run "flutter pub get" to get the packages.
- Run "flutter gen-l10n" to generate localizations files.

## Supported Features

- Drop down list with Rick and Morty characters with some infos.
- Save characters in favorites list.
- Filter alphabetically.
- Pull to refresh to get lastest data from API.
- Persistant data after app restart.
- Shimmer skeleton during data loading.
- FR and EN translations.

## App Architecture

A simple but scalable architecture based on controller-service-repository pattern.