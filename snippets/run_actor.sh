#!/usr/bin/env bash
# Run the Hotels.com Reviews Scraper on Apify with curl, then fetch the dataset.
# Docs: https://apify.com/factden/hotels-com-reviews-scraper

TOKEN="<YOUR_APIFY_TOKEN>"   # https://console.apify.com/settings/integrations

# Run the actor synchronously and get dataset items back in one call
curl -s -X POST \
  "https://api.apify.com/v2/acts/factden~hotels-com-reviews-scraper/run-sync-get-dataset-items?token=${TOKEN}" \
  -H 'Content-Type: application/json' \
  -d '{
    "hotelUrls": [
      "https://www.hotels.com/ho119566/"
    ],
    "maxReviewsPerHotel": 100,
    "sortBy": "newest"
  }'
