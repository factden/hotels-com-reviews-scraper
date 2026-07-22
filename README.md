# Hotels.com Reviews Scraper

> Scrape **Hotels.com hotel reviews** at scale — guest **ratings**, full **review text**, six category **sub‑ratings**, **stay dates**, **traveler type**, **language**, and **hotel owner responses** — plus a per‑review **LLM‑ready markdown** block. **No login, no Hotels.com API key.** Runs on [Apify](https://apify.com/factden/hotels-com-reviews-scraper?fpr=factden).

[![Run on Apify](https://img.shields.io/badge/Run%20on-Apify-00b04f?logo=apify&logoColor=white)](https://apify.com/factden/hotels-com-reviews-scraper?fpr=factden)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)

This repo is the **developer entry point** for the Hotels.com Reviews Scraper actor: the output shape, copy‑paste API snippets, a full [field dictionary](./FIELDS.md), and a short [how‑to](./HOWTO.md). The actor itself runs on Apify — no login, no Hotels.com API key, no proxy or anti‑bot setup required.

**▶ [Run it on Apify →](https://apify.com/factden/hotels-com-reviews-scraper?fpr=factden)**

<p align="center">
  <a href="https://apify.com/factden/hotels-com-reviews-scraper?fpr=factden" rel="sponsored noopener">
    <img src="https://raw.githubusercontent.com/factden/apify-actor-assets/main/hotels-com-reviews-scraper/02-reviews-overview.png" alt="Hotels.com Reviews Scraper — one structured row per guest review" width="900">
  </a>
</p>

---

## What it extracts

Paste a Hotels.com `/ho<id>/` URL, a bare Hotels.com property ID, or any Expedia Group hotel URL, and get two structured datasets:

- **Reviews** — one row per guest review: the overall **/10 rating**, full **review text**, six category **sub‑ratings** (cleanliness, service, room comfort, hotel condition, amenities, eco‑friendliness), **stay dates**, **traveler type**, **language**, **review photos**, any **hotel owner response**, and an LLM‑ready `markdownContent` block.
- **Hotels** — one summary row per hotel: average rating, recency‑weighted rating, total review count, the full **1–5 rating distribution**, and per‑language / per‑traveler‑type counts.

### Two things you won't find in other Hotels.com scrapers

🏨 **Native Hotels.com input, plus the whole Expedia Group** — paste Hotels.com `/ho<id>/` links or bare IDs (resolved automatically), and Expedia, Travelocity, Orbitz, Wotif, CheapTickets & ebookers URLs work too, with the **same output schema**.

🤖 **LLM‑ready `markdownContent` per review** — a self‑contained markdown block, ready for direct vector‑DB / RAG ingestion with zero formatting work.

|  |  |
|---|---|
| ![Hotel aggregate — one row per hotel](https://raw.githubusercontent.com/factden/apify-actor-assets/main/hotels-com-reviews-scraper/04-hotel-overview.png) | ![LLM-ready markdown field](https://raw.githubusercontent.com/factden/apify-actor-assets/main/hotels-com-reviews-scraper/03-reviews-ai-ingest.png) |
| Hotel aggregate — ratings, distribution, counts | LLM‑ready `markdownContent` field |

---

## Quick start (API)

```python
from apify_client import ApifyClient

client = ApifyClient("<YOUR_APIFY_TOKEN>")
run = client.actor("factden/hotels-com-reviews-scraper").call(run_input={
    "hotelUrls": ["https://www.hotels.com/ho119566/", "242128"],
    "maxReviewsPerHotel": 100,
    "sortBy": "newest",
})
for row in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(row["hotelName"], row["overallRating"])
```

More: **[Python](./snippets/run_actor.py)** · **[Node](./snippets/run_actor.js)** · **[curl](./snippets/run_actor.sh)**

<p align="center">
  <img src="https://raw.githubusercontent.com/factden/apify-actor-assets/main/hotels-com-reviews-scraper/01-input-form.png" alt="Hotels.com Reviews Scraper input form on Apify Console — hotel URLs plus filters and limits" width="720">
</p>

---

## Output

Real sample output lives in **[`examples/`](./examples)**:

- [`examples/reviews-sample.csv`](./examples/reviews-sample.csv) — **100 real review rows** — browse it right in GitHub's table view
- [`examples/reviews-output.sample.json`](./examples/reviews-output.sample.json) — 3 review rows showing the full field shape (incl. `markdownContent`)
- [`examples/input.json`](./examples/input.json) — a ready‑to‑run input

Every field is documented in **[`FIELDS.md`](./FIELDS.md)**. Ratings are shown on the **/10 scale** to match Hotels.com's public display. From Apify you can download results as **JSON, CSV, Excel, or HTML**.

---

## Use cases

- **Reputation & sentiment analysis** — track guest sentiment for your own or competitor hotels over time.
- **Competitor benchmarking** — rating distributions, category sub‑scores and review volume per property.
- **Market research** — traveler types, languages, and what guests praise or complain about across a market.
- **AI / RAG pipelines** — drop each review's `markdownContent` straight into a vector DB.

---

## How much does it cost?

Pay‑per‑event on Apify: a **per‑review fee with no per‑run start fee** — lower **Max reviews per hotel** to cap cost. New Apify accounts get **$5 in free credit**. See the [actor page](https://apify.com/factden/hotels-com-reviews-scraper?fpr=factden) for current pricing.

---

## FAQ

**Is scraping Hotels.com reviews legal?** The actor collects only **publicly available** review data. As with any scraping, review Hotels.com's Terms of Service and your local regulations, and use the data responsibly.

**Do I need a Hotels.com account or API key?** No. Everything runs inside the actor on Apify's infrastructure — no login, no key, no proxy setup.

**Can I paste other Expedia Group brands?** Yes. Hotels.com `/ho<id>/` links and bare IDs resolve automatically, and Expedia, Travelocity, Orbitz, Wotif, CheapTickets and ebookers URLs return the same schema. Use **Review sources** to keep only certain brands' reviews.

**Found a bug or want a field added?** Open an issue here, or use the **Issues** tab on the [Apify actor page](https://apify.com/factden/hotels-com-reviews-scraper?fpr=factden).

---

## Other scrapers by FactDen

- [Google Hotels Scraper](https://apify.com/factden/google-hotels-scraper?fpr=factden)
  ([docs](https://github.com/factden/google-hotels-scraper))
- [Expedia Reviews Scraper](https://apify.com/factden/expedia-hotel-reviews-scraper?fpr=factden)
  ([docs](https://github.com/factden/expedia-hotel-reviews-scraper))
- [Trip.com & Ctrip Reviews Scraper](https://apify.com/factden/ctrip-trip-reviews-scraper?fpr=factden)
  ([docs](https://github.com/factden/ctrip-trip-reviews-scraper))
- [G2 Reviews Scraper](https://apify.com/factden/g2-reviews-scraper?fpr=factden)
  ([docs](https://github.com/factden/g2-reviews-scraper))
- [Indeed Jobs Scraper](https://apify.com/factden/indeed-jobs-scraper?fpr=factden)
  ([docs](https://github.com/factden/indeed-jobs-scraper))
- [All FactDen actors →](https://apify.com/factden?fpr=factden)

**Docs & guides:**

- [How to scrape Hotels.com reviews](https://factden.com/blog/how-to-scrape-hotels-com-reviews)
- [factden.com](https://factden.com)

---

_The sample data in this repo is real public Hotels.com review data, collected with the actor and provided for documentation/evaluation. Run the actor on Apify to pull data for any hotel, at any scale._

_Found this useful? A star on this repo helps other people find it._
