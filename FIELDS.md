# Output fields

The Hotels.com Reviews Scraper produces **two datasets**. The **Reviews** dataset (the default) has one row per
public guest review, with the hotel context merged onto each row. The **Hotels** dataset has one row per hotel with
the aggregates. Ratings are on the **/10 scale** to match Hotels.com's public display. Fields a given property
doesn't provide are `null` (or an empty array).

## Reviews dataset

Each row starts with the hotel context, then the review fields.

| Field | Type | Description |
|---|---|---|
| `hotelId` | string | Expedia Group property ID (shared across Expedia Group brands). |
| `hotelName` | string \| null | Hotel display name. |
| `hotelUrl` | string | The hotel-page URL that produced this row. |
| `source` | string | Which brand the URL resolved to (e.g. `hotels`, `expedia`). |
| `reviewId` | string | Unique review identifier. |
| `submittedAt` | string \| null | Review submission timestamp (ISO 8601). |
| `overallRating` | number \| null | Overall guest rating on the **0–10** scale. |
| `ratingLabel` | string \| null | Localized rating tier label (e.g. Exceptional, Wonderful, Good). |
| `reviewText` | string \| null | Review body. |
| `subRatings` | array | Per-review category sub-ratings as a labeled-string array (nulls omitted), e.g. `["Cleanliness: 9.0", "Staff & service: 10.0"]`. Renders as one tidy cell in CSV. |
| `verified` | boolean | Whether the stay is marked verified (`false` = flagged unverified). |
| `reviewerName` | string \| null | Reviewer display name; `null` when anonymous. |
| `reviewerLocation` | string \| null | Reviewer's self-reported location. |
| `checkInDate` | string \| null | Guest check-in date (`YYYY-MM-DD`). |
| `checkOutDate` | string \| null | Guest check-out date (`YYYY-MM-DD`). |
| `travelCompanions` | array | Who the guest travelled with (e.g. `["Business"]`, `["Family"]`). |
| `travelerCategories` | array | Traveler category labels the platform attaches to the review. |
| `language` | string \| null | ISO 639-1 code of the original review text. |
| `isMachineTranslated` | boolean | Whether the returned text was machine-translated by the platform. |
| `helpfulVotes` | integer | Helpful / "thanks" vote count on the review. |
| `imagesCount` | integer | Number of photos attached to the review. |
| `reviewPhotos` | array | URLs of photos attached to the review. |
| `ownerResponse` | object \| null | Hotel-management reply, clubbed: `{ text, date }`, or `null` when the hotel has not replied. |
| `roomTypeId` | string \| null | Identifier of the room type the guest booked. |
| `isAnonymous` | boolean | Whether the review was posted anonymously. |
| `brandType` | string \| null | The Expedia Group brand the review originated on. |
| `markdownContent` | string \| null | **LLM-ready** self-contained markdown block for the review — drop straight into a RAG pipeline. |

## Hotels dataset

One row per hotel (the aggregates). Starts with the same hotel context (`hotelId`, `hotelName`, `hotelUrl`,
`source`), then:

| Field | Type | Description |
|---|---|---|
| `brandName` | string \| null | Property brand/chain name. |
| `structureType` | string \| null | Property type (Hotel, Resort, Apartment, …). |
| `latitude` / `longitude` | number \| null | Property coordinates. |
| `avgOverallRating` | number \| null | Mean overall rating on the **0–10** scale. |
| `halfLifeRating` | number \| null | Recency-weighted ("half-life") rating on the 0–10 scale. |
| `totalReviewCount` | integer | Total public reviews reported for the property. |
| `ratingDistribution` | object \| null | Count of reviews per rating bucket. |
| `hotelSubRatings` | array | Property-level category sub-ratings (labeled-string array). |
| `categoryCounts` | object \| null | Review counts by traveler/category. |
| `languageCounts` | object \| null | Review counts by language. |
| `reviewsExtracted` | integer | How many reviews this run actually delivered for the hotel. |
| `extractedAt` | string (ISO datetime) | When the hotel row was scraped (UTC ISO 8601). |

## Dataset views

The Reviews dataset ships two pre-built views you can switch between in the Console or request via the API:

- **Overview** — the columns most users want first (hotel, rating, `subRatings`, review text, owner response).
- **AI ingest (LLM-ready)** — `markdownContent` plus the original text, language, rating and source — optimized for
  vector-DB / RAG loading.
