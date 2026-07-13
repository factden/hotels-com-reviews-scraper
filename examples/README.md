# Examples

All real public review data collected with the actor (Bellagio, Las Vegas — Hotels.com `ho119566`, which resolves to
the shared Expedia Group property `140596`).

- **`input.json`** — a ready-to-run actor input (one Hotels.com `/ho<id>/<slug>/` URL).
- **`reviews-output.sample.json`** — **3 real review rows** showing the full v1 field shape: a 10/10 stay, a 6/10,
  and a critical 2/10, each with the `subRatings` array, `travelCompanions` / `travelerCategories`, and the
  LLM-ready `markdownContent` block.
- **`reviews-sample.csv`** — **100 real reviews**, browsable right in GitHub's table view. CSV-flattened:
  `subRatings` and the array columns joined into one cell, `ownerResponse` split into `ownerResponse_text` /
  `ownerResponse_date`, and `markdownContent` omitted for readability.

Ratings are shown on the **/10 scale** to match Hotels.com's public display. `hotelName` is derived from the URL slug,
so paste the full `/ho<id>/<slug>/` URL (as here) rather than a bare `/ho<id>/`. Each review's `brandType` reflects
the platform the review originated on within Expedia Group.

Run the actor for any hotel: **https://apify.com/factden/hotels-com-reviews-scraper?fpr=factden**
