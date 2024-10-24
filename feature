name: METAHUB

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2
      - name: Install dependencies
        run: |
          npm install
      - name: Configure Botfront
        env:
          RASA_URL: ${{ secrets.RASA_URL }}
          RASA_TOKEN: ${{ secrets.RASA_TOKEN }}
          ENCRYPTION_KEY: ${{ secrets.ENCRYPTION_KEY }}
          ENCRYPTION_METHOD: ${{ secrets.ENCRYPTION_METHOD }}
        run: |
          echo "botfront:" > botfront.yml
          echo "  rasa:" >> botfront.yml
          echo "    url: $RASA_URL" >> botfront.yml
          echo "    token: $RASA_TOKEN" >> botfront.yml
          echo "    encryption:" >> botfront.yml
          echo "      method: $ENCRYPTION_METHOD" >> botfront.yml
          echo "      key: $ENCRYPTION_KEY" >> botfront.yml
      - name: Deploy to GitHub Pages
        uses: gh-pages/deploy@v1
