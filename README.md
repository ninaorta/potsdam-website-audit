# Village of Potsdam Website Recovery Audit

The Village of Potsdam lost access to its website and has an archive of screenshots of it. This repository holds our team's audit of that archive. It records what the site contained, how it was organized, how reliably its text can be recovered with OCR, and what should happen when the site is rebuilt.

**Team:** Nurina Darmawati, Bolatito Abolade, Sharon Ajibade

## What is in this repository

| Folder or file | What it holds |
|---|---|
| README.md | This file |
| screenshots/ | The 9 screenshots in our detailed sample |
| sitemap/sitemap.mmd | Mermaid source of the recovered site structure |
| sitemap/sitemap.png | Rendered sitemap |
| database/inventory.db | SQLite content inventory (authoritative record) |
| database/csv/ | CSV export of every table, regenerated from inventory.db |
| database/schema.sql | Table definitions |
| database/seed.sql | Page, image, document, member and issue records |
| database/ocr_errors_[name].sql | OCR error log, one file per team member |
| database/build_db.py | Rebuilds inventory.db from the .sql files and exports the CSVs |
| database/export_csv.py | CSV export (called by build_db.py) |
| ocr/raw/ | Unedited Tesseract output, one file per page |
| ocr/verified/ | Text corrected against the screenshot, one file per page |
| scripts/run_ocr.sh | Runs Tesseract on one or more screenshots |

## Scope and sample

We studied 9 pages in detail: three pages from each of three sections of the site.

| Section | Pages | Page type |
|---|---|---|
| Public Safety | Potsdam Rescue Squad, Potsdam Police Department, Potsdam Fire Department | Organization listing: contact block and short description |
| Parks | Lehman Park, Ives Park, Garner Park | Park profile: contact, table of contents, paragraphs, photo gallery |
| Boards & Committees | Zoning Board of Appeals, Potsdam Fire Department, Joint Recreation Committee | Board profile: members, terms, FAQs, linked documents |

How we chose them:

- **Redundancy.** Most pages in the archive are built from a few repeating templates. Pages in the same section share the same layout, and every page repeats the same banner, navigation and footer. Three pages per section show how a template behaves without repeating the same test many times.
- **Page types.** The three sections cover the main kinds of content on the site: short contact listings, longer descriptive text with images, and structured lists of people, dates and documents. Each kind tests OCR in a different way. The sample also includes a very full page (Zoning Board of Appeals) and a nearly empty one (Joint Recreation Committee).
- **Audience.** We have not yet confirmed who the site's main audience is. Public Safety, Parks and Boards & Committees are sections that residents and visitors are likely to use for contact details, places and local government information, so recovery errors there would matter most.

Conclusions about content and OCR accuracy are based on these 9 pages. Claims about the whole archive are limited to the site structure and to what appears on every page (the shared navigation, banner and footer).

## Method

### 1. Site structure
Every page in the archive shares the same top navigation (Home, Search, News, Calendars, Departments) and side navigation (16 links). The full-site structure follows the course reference sitemap (https://ericyork.github.io/eg_sitemap/), which we checked against the navigation in the screenshots. Each sample page was placed using its section heading and "Return To List" button (Homepage > Section > Page).

The result is in sitemap/. The site has 20 links from the homepage, and five of them are sections with sub-pages: Departments (13), Agendas & Minutes (4), Boards & Committees (7), Parks (5) and Public Safety (3). Dark blue boxes are the 9 pages in our sample, labeled with the title exactly as shown in the screenshot.

Two labeling notes:
- The reference sitemap lists "Garmin Park"; the screenshot title is "Garner Park", which we use.
- The side navigation in the screenshots reads "FAQ's"; we keep that spelling.

### 2. Content inventory
database/inventory.db is the authoritative record. Its tables:

| Table | One row per |
|---|---|
| pages | screenshot in the sample: title, section, navigation path, level, content type, owner, recovery and remediation status, file paths |
| images | content photo: caption as shown, position, what it shows, usable resolution |
| documents | linked file (PDF): link text, size, description; none of these files are in the archive |
| members | board or committee member: name, role, term as shown, term end as a sortable date |
| issues | problem in the original content (typo, outdated, duplicate, inconsistency, privacy, structure) |
| ocr_errors | error introduced by OCR, found during verification |
| page_summary (view) | one summary line per page |

Long page text is kept in ocr/ text files, and the database stores their paths. Text is recorded exactly as shown, including the original site's typos; problems with the original go in the issues table.

To rebuild the database after editing any .sql file, open the database folder in Terminal and run: python3 build_db.py

This recreates inventory.db and regenerates every CSV, so the CSV files always match the database. Team members edit the .sql text files and rebuild; nobody edits inventory.db by hand, which keeps Git merges clean.

### 3. Text recovery (OCR)
- Tool: **Tesseract 5.5.3** (leptonica 1.87.0), English language data, installed with Homebrew on macOS.
- Settings: -l eng --psm 3 (automatic page layout), full-page screenshots, no cropping or preprocessing.
- Command: bash scripts/run_ocr.sh screenshots/[page].png
- Output goes to ocr/raw/ and is never edited.

### 4. Verification
Each raw file was copied to ocr/verified/ and corrected line by line against the screenshot, then compared with the raw file in VS Code (Select for Compare / Compare with Selected). Every difference was logged in ocr_errors with its region of the page, error type, the OCR text, the correct text, and a severity:

- **high**: changes or hides a name, number, date, email, link or meaning
- **medium**: loses or misplaces a heading or navigation item
- **low**: stray characters, bullets, order of captions

The navigation and footer are identical on every page, so their correct text is verified once in ocr/verified/_site-chrome.txt. The page files in ocr/verified/ hold each page's own content. OCR errors in the shared areas are still logged for every page, because they show up in every page's output.

## Findings so far

*OCR results below cover the pages verified to date (Potsdam Fire Department – Public Safety, Garner Park, Joint Recreation Committee). Update this section as the remaining pages are verified.*

**OCR accuracy.** Tesseract read the body text of these pages accurately. The Garner Park description paragraph came out word for word, and all phone and fax numbers were correct. Most errors came from the page layout:

- **Navigation mixed into content.** Text in the side menu sits on the same line as page content, so OCR joins them: Phone: 315-265-3312 7 Forms. The "7" is a checkmark icon and could be mistaken for part of the number.
- **Silent loss of text.** White text on blue buttons (Home, Search, News, Calendars, Departments, Return To List) and the small dark footer text on a blue background were dropped completely. The footer holds the village's contact details and the website disclaimer.
- **Images and logos** came out as stray characters (= oe es, PaWete Ey).

28 errors were logged across the 3 pages: 8 high, 7 medium and 13 low severity. See database/csv/ocr_errors.csv.

**Content and structure.** Recorded in database/csv/issues.csv. Highlights:

- The Potsdam Fire Department has two pages with the same title and different content, one under Public Safety and one under Boards & Committees.
- The sitemap shows the same organizations in more than one section: Police (Departments and Public Safety), Fire Department (Public Safety and Boards & Committees), Recreation (Departments and Boards & Committees), and Museum and Airport (Departments and Boards & Committees). A visitor looking for one of these has to guess which section to try. Only the Fire Department pair has been compared page to page in our sample.
- Every board member term listed has expired (Fire Department officers in 2018; Zoning Board between 2021 and 2025).
- The Zoning Board page says it has 7 members and lists 6, and publishes members' home phone numbers.
- The Joint Recreation Committee page has only a title and "Number of Members: 6".
- Spelling of the river varies between "Raquette" and "Racquette".

## AI use

AI tools were used for help with the database schema, scripts and Mermaid syntax. All recovered text, inventory records and error logs were checked against the screenshots by the team member responsible for each page.
