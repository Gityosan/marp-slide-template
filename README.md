## This repository provides a template for slide creation.

### Getting Started

1. Install the `stylelint`, `prettier`, and `marp` extensions in VSCode.
2. Execute `npm install`.

### Instructions

1.  To create a new markdown file:

    - Use `npm run new ${filename}`
      or
    - Simply run `npm run new`.

2.  To convert markdown to PDF:

    - Use `npm run pdf ${relative path}`.
    - Use `npm run pdf -h ${relative path}`. (If use HTML)

3.  To convert markdown to PPTX:

    - Use `npm run pptx ${relative path}`.
    - Use `npm run pptx -h ${relative path}`. (If use HTML)

4.  To modify the theme:

    1. Edit the files in `/style/scss/*.scss`.
    2. Then, run `npm run css`.
    3. Afterwards, adjust the `"markdown.marp.themes"` value in `.vscode/settings.json`.

5.  If you wish to use the DeepL API to translate the title before uploading to SlideShare:
    1. Copy the example environment file with `cp .env.example .env`.
    2. Set your `DEEPL_API_KEY` in the `.env` file.
    3. Execute the `pdf/pptx` command using the `-d` option.
