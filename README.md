# Village of Potsdam Website Recovery Audit

**Team:** Nurina Darmawati, Bolatito Abolade, Sharon Ajibade

## What this project is

The Village of Potsdam lost its website and kept only screenshots of it. Our team audited those screenshots to find out what the site contained, how it was organized, and how reliably its text can be recovered. This repository holds our evidence: a content inventory in SQLite with CSV exports, a Mermaid sitemap of the whole site, the text extracted with Tesseract, our corrected versions, and a log of every OCR error we found.

## How we worked

We chose nine pages for close study, three each from Public Safety, Parks, and Boards & Committees. Many screenshots share the same templates, so these three sections cover the main kinds of content on the site: short contact listings, descriptive pages with photos, and lists of people and documents.

Nurina set up the repository first, as a "home" for the project. Her computer allowed software installation, so she could install Tesseract, Git and the other tools and build the base quickly: the folder structure, the database, the scripts, the sitemap, and a step-by-step guide for the team (TEAM_GUIDE.md). Bolatito and Sharon work on department-managed Macs, which at the start blocked them from installing Tesseract. Nurina ran OCR for Bolatito's pages on her own machine with the same settings, and Bolatito verified her pages through the GitHub website.

We then divided the nine pages, three per person, one from each section:

| Team member | Pages |
|---|---|
| Nurina Darmawati | ps-fire, parks-garner, board-rec |
| Bolatito Abolade | ps-rescue, parks-lehman, board-zoning |
| Sharon Ajibade | ps-police, parks-ives, board-fire |

Each person compared the extracted text with the original screenshot line by line, saved a corrected version, and logged every difference in their own error file.

## What we found

Tesseract read the main body text very accurately. Paragraphs, phone numbers and figures such as a park's size of ".33 acres" came out correctly. Most errors came from the page layout:

- Menu items merged into page content, for example "Phone: 315-265-3312 7 Forms", where the 7 is a menu icon.
- Some text was dropped with no warning, including the footer with the village's contact details.
- Photos and logos turned into stray characters.

We also found problems in the original site: the same offices listed in two sections, two Fire Department pages with the same title and different content, expired board terms, and a few typos.

## What we would do next time

- Crop screenshots to the main content area before running OCR, so menus and footers stay out of the text.
- Recover the shared menus and footer once, since they repeat on every page.
- Have a person check every name, number, date, email address and link, since these are where errors matter most.
- Rebuild the site around its audience, with one page per office and shared information kept in one place.

## Where to find things

| Folder or file | What it holds |
|---|---|
| database | SQLite inventory, CSV exports, and each person's error log |
| ocr/raw | Tesseract's output, unedited |
| ocr/verified | Our corrected text |
| sitemap | Mermaid source and PNG of the whole site |
| screenshots | The nine sample pages |
| TEAM_GUIDE.md | Our step-by-step workflow |
