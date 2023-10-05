## This repository is a template for slide creation.

### Getting Started

1. Add `stylelint / prettier / marp` extensions in vscode
2. Run `yarn install`

#### If you want to make new markdown file

- `yarn run new ${filename}`<br>
  or
- `yarn run new`

#### If you want to make markdown to pdf

- `yarn run pdf ${relative path}`

#### If you want to make markdown to pptx

- `yarn run pptx ${relative path}`

#### If you want to edit theme

1. you can edit `/style/scss/*.scss`
2. then run `yarn run css`
3. then fix `"markdown.marp.themes"` in `.vscode/settings.json`
