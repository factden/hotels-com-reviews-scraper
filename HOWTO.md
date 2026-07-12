# How to scrape Hotels.com hotel reviews (the easy way)

Scraping Hotels.com directly is painful: anti-bot defenses, session/cookie handling, rotating proxies, and a review
API that changes shape across Expedia Group's brands. This guide skips all of that by using the
[Hotels.com Reviews Scraper](https://apify.com/factden/hotels-com-reviews-scraper?fpr=factden) actor on Apify — no
login, no proxy setup, no anti-bot tuning.

## 1. Get an Apify token

Create a free [Apify](https://console.apify.com/sign-up?fpr=factden) account and copy your API token from
**Settings → Integrations**. New accounts include free credit.

## 2. Run it from the Console (no code)

1. Open the [actor page](https://apify.com/factden/hotels-com-reviews-scraper?fpr=factden) and click **Try for
   free**.
2. The input is pre-filled with an example hotel. Leave it or replace it with your own.
3. Click **Start**. A small run finishes in well under a minute.
4. Download results from the **Output** tab as JSON, CSV, or Excel.

## 3. Find a hotel URL

Open a hotel's page on Hotels.com and copy the URL — it contains a `/ho<number>/` segment, e.g.
`https://www.hotels.com/ho119566/`. You can paste the full URL, or just the **bare property ID** (`242128`).
Hotel-page URLs from other Expedia Group brands (Expedia, Travelocity, Orbitz, Wotif, CheapTickets, ebookers) work
too and are resolved automatically.

## 4. Run it from code

### Python

```python
from apify_client import ApifyClient

client = ApifyClient("<YOUR_APIFY_TOKEN>")
run = client.actor("factden/hotels-com-reviews-scraper").call(run_input={
    "hotelUrls": ["https://www.hotels.com/ho119566/"],
    "maxReviewsPerHotel": 200,
})
items = list(client.dataset(run["defaultDatasetId"]).iterate_items())
print(f"Got {len(items)} reviews")
```

See [`snippets/`](./snippets) for Node and curl versions.

## 5. Useful input options

| Option | What it does |
|---|---|
| `maxReviewsPerHotel` | Cap reviews per hotel (controls cost). |
| `sortBy` | `newest`, `oldest`, `highestRating`, `lowestRating`. |
| `fromDate` / `toDate` | Only reviews in a `YYYY-MM-DD` window. |
| `minRating` / `maxRating` | Filter by overall rating (1–5 input; output is shown on the /10 scale). |
| `reviewSources` | Which Expedia Group brands' reviews to return. Empty = cross-brand union. |

Full field reference: [`FIELDS.md`](./FIELDS.md). Full input format: [`examples/input.json`](./examples/input.json).

## 6. Feed it to an LLM

Each review includes a ready-to-use `markdownContent` field — no formatting needed:

```python
docs = [row["markdownContent"] for row in items]
# embed `docs` into your vector DB / RAG pipeline
```

---

**▶ [Run the Hotels.com Reviews Scraper on Apify →](https://apify.com/factden/hotels-com-reviews-scraper?fpr=factden)**
