## the repository for making slide

### Getting Started

1. add `stylelint prettier marp` extensions in vscode
2. Run `yarn install`

#### if you want to make new markdown file

- `yarn run new`

#### if you want to make markdown to pdf

- `yarn run pdf ${relative path}`

#### if you want to edit theme

- you can edit `/style/scss/*.scss`
- then run `yarn run css`
- then fix `"markdown.marp.themes"` in `.vscode/settings.json`
