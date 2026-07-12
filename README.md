# Hotels.com Reviews Scraper - documentation

Public documentation and examples for the **Hotels.com Reviews Scraper** Apify actor. Scrape public Hotels.com
hotel reviews at scale - guest **ratings**, full **review text**, category **sub-ratings**, **stay dates**,
**traveler type**, **language**, and **hotel owner responses** - plus a per-review **LLM-ready markdown** block.
Export clean **JSON, CSV, Excel or via API**. No login, no Hotels.com API key.

> This repository holds **documentation and examples only** - no scraper source code. This is an initial version;
> content will be expanded and optimized over time.

## Why use it?

- **Reputation & sentiment analysis** - track guest sentiment for your own or competitor hotels over time.
- **Competitor benchmarking** - pull rating distributions, category sub-scores and review volume per property.
- **Market research** - analyze traveler types, languages and what guests praise or complain about.
- **AI / RAG pipelines** - every review ships with a self-contained `markdownContent` block ready for
  vector-DB ingestion.

## How to use

1. Open a hotel's page on Hotels.com and copy the URL (it contains a `/ho<number>/` segment, e.g.
   `https://www.hotels.com/ho119566/`).
2. Paste one or more such URLs, bare Hotels.com property IDs, or any other Expedia Group brand URL into
   **Hotel URLs**.
3. (Optional) Set **Max reviews per hotel**, a **date range**, a **rating range**, a **sort order**, or **Review
   sources**.
4. Run it and download the results as JSON, CSV, Excel, or pull them from the API.

## Input

| Field | Description |
|---|---|
| **Hotel URLs or property IDs** (`hotelUrls`) | Hotels.com `/ho<id>/` URLs, **bare Hotels.com property IDs** (`242128`), or hotel-page URLs from any of the 6 other Expedia Group brands (each with a `.h<id>.` segment). One per line. |
| **Max reviews per hotel** (`maxReviewsPerHotel`) | Cap per hotel (default 200). |
| **Sort reviews by** (`sortBy`) | `newest` (default), `oldest`, `highestRating`, `lowestRating`. |
| **From / To date** (`fromDate` / `toDate`) | Keep only reviews in a `YYYY-MM-DD` range. |
| **Min / Max rating** (`minRating` / `maxRating`) | Keep only reviews within a 1-5 rating range. |
| **Review sources** (`reviewSources`) | Which Expedia Group brands' reviews to return. Empty = all (cross-brand union). |
| **Proxy** (`proxyConfiguration`) | Datacenter is enough; use residential for very large runs. |

## Output

Two datasets: **Reviews** (the default dataset) - one row per guest review, with the hotel context merged onto
each row - and **Hotels** - one row per hotel with the aggregates. The reviews dataset also exposes an **AI
ingest** view (the LLM-ready `markdownContent` column). Ratings are presented on the **/10 scale** to match
Hotels.com's public display.

## Supported sites

Hotels.com plus the other Expedia Group brands - paste an **Expedia, Travelocity, Orbitz, Wotif, CheapTickets**
or **ebookers** hotel URL directly (Hotels.com `/ho<id>/` URLs and bare IDs are resolved automatically). Use
**Review sources** to pick which brands' reviews to return, or leave it empty for the cross-brand union.

## Pricing

Pay-per-event with **no start fee** - you pay only a per-review fee (see the Apify Console pricing panel). Lower
**Max reviews per hotel** to control cost. Your first runs are covered by Apify's free tier.

## Legal

This actor collects only **publicly available** review content. You are responsible for complying with
Hotels.com's Terms of Service and applicable laws (including data-protection rules) when using the data.

## Docs in this repo

- **[HOWTO.md](./HOWTO.md)** — step-by-step guide (Console + Python / Node / curl).
- **[FIELDS.md](./FIELDS.md)** — full output field dictionary for both the Reviews and Hotels datasets.
- **[examples/](./examples)** — a ready-to-run [input](./examples/input.json), **3 real review rows**
  ([reviews-output.sample.json](./examples/reviews-output.sample.json)) and **100 real reviews**
  ([reviews-sample.csv](./examples/reviews-sample.csv)).
- **[snippets/](./snippets)** — copy-paste run scripts: [Python](./snippets/run_actor.py) ·
  [Node](./snippets/run_actor.js) · [curl](./snippets/run_actor.sh).

## Other scrapers by FactDen

- [Expedia Reviews Scraper](https://apify.com/factden/expedia-hotel-reviews-scraper?fpr=factden)
  ([docs](https://github.com/factden/expedia-hotel-reviews-scraper))
- [Trip.com & Ctrip Hotel Reviews Scraper](https://apify.com/factden/ctrip-trip-reviews-scraper?fpr=factden)
  ([docs](https://github.com/factden/ctrip-trip-reviews-scraper))
- [G2 Reviews Scraper](https://apify.com/factden/g2-reviews-scraper?fpr=factden)
  ([docs](https://github.com/factden/g2-reviews-scraper))
- [Indeed Jobs Scraper](https://apify.com/factden/indeed-jobs-scraper?fpr=factden)
  ([docs](https://github.com/factden/indeed-jobs-scraper))
- [All FactDen actors →](https://apify.com/factden?fpr=factden)

## Links

- Apify Store listing: https://apify.com/factden/hotels-com-reviews-scraper?fpr=factden
