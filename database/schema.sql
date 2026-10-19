-- Village of Potsdam Website Recovery Audit — content inventory schema
-- Build:  sqlite3 inventory.db < schema.sql   then   sqlite3 inventory.db < seed.sql
--
-- Design rules
--   * Text is recorded EXACTLY as shown in the screenshot (typos included).
--     Problems with the original go in the `issues` table, not into the text.
--   * Long page text is NOT stored here. It lives in ocr/raw/ and ocr/verified/,
--     and the `pages` table records the file paths.
--   * verified_by is NULL until a team member has checked the row against the
--     screenshot. Rows with verified_by = NULL are drafts.

PRAGMA foreign_keys = ON;

-- One row per screenshot in the detailed sample.
CREATE TABLE pages (
    page_id            INTEGER PRIMARY KEY,
    screenshot_file    TEXT NOT NULL UNIQUE,   -- e.g. ps-fire.png
    slug               TEXT NOT NULL UNIQUE,   -- audit slug = filename stem (original URLs are not visible in the archive)
    section            TEXT NOT NULL,          -- section heading shown on the page (Public Safety, Parks, Boards & Committees)
    page_title         TEXT NOT NULL,          -- main page heading, exactly as shown
    parent_path        TEXT NOT NULL,          -- navigation path, e.g. Home > Parks > Garner Park
    level              INTEGER NOT NULL CHECK (level BETWEEN 1 AND 5),  -- 1 = Home, 2 = section list, 3 = detail page
    content_type       TEXT NOT NULL CHECK (content_type IN
                         ('home','section_list','department_listing','board_profile','park_profile','document_list','form','other')),
    page_sections      TEXT,                   -- subsections shown, in order (from "Table Of Contents" or headings)
    image_count        INTEGER NOT NULL DEFAULT 0,  -- content images only; shared banner excluded
    document_count     INTEGER NOT NULL DEFAULT 0,  -- linked files (PDFs etc.)
    assigned_to        TEXT,
    recovery_status    TEXT NOT NULL DEFAULT 'not_started' CHECK (recovery_status IN
                         ('not_started','ocr_done','verified','not_recoverable')),
    remediation_status TEXT NOT NULL DEFAULT 'undecided' CHECK (remediation_status IN
                         ('undecided','retain','revise','consolidate','replace','remove')),
    ocr_file           TEXT,                   -- ocr/raw/<slug>.txt  (never edited by hand)
    verified_file      TEXT,                   -- ocr/verified/<slug>.txt  (corrected against screenshot)
    ocr_error_count    INTEGER,                -- filled after verification (should match COUNT in ocr_errors)
    notes              TEXT,
    verified_by        TEXT
);

-- Images that appear in a page's content area (not the shared site banner).
CREATE TABLE images (
    image_id           INTEGER PRIMARY KEY,
    page_id            INTEGER NOT NULL REFERENCES pages(page_id),
    caption_as_shown   TEXT,                   -- caption exactly as shown; NULL if none
    position           TEXT NOT NULL CHECK (position IN ('feature','gallery','inline','other')),
    display_order      INTEGER NOT NULL,       -- order on the page, top-to-bottom, left-to-right
    subject_observed   TEXT,                   -- what is visibly depicted (no guessing)
    recoverable_as     TEXT NOT NULL CHECK (recoverable_as IN
                         ('screenshot_crop_usable','screenshot_crop_low_res','not_recoverable')),
    notes              TEXT,
    verified_by        TEXT
);

-- Linked files listed on a page. Only the link text is recoverable; the files are not in the archive.
CREATE TABLE documents (
    document_id        INTEGER PRIMARY KEY,
    page_id            INTEGER NOT NULL REFERENCES pages(page_id),
    link_text          TEXT NOT NULL,          -- exactly as shown
    file_type_as_shown TEXT,                   -- e.g. PDF
    file_size_as_shown TEXT,                   -- e.g. 627.2 KB
    description_as_shown TEXT,
    file_in_archive    INTEGER NOT NULL DEFAULT 0 CHECK (file_in_archive IN (0,1)),
    notes              TEXT,
    verified_by        TEXT
);

-- Board/committee members as listed. Contact details (emails, phones) are left in the
-- verified text files only, so personal data is not duplicated into a sortable table.
CREATE TABLE members (
    member_id          INTEGER PRIMARY KEY,
    page_id            INTEGER NOT NULL REFERENCES pages(page_id),
    display_order      INTEGER NOT NULL,
    name_as_shown      TEXT NOT NULL,
    role_as_shown      TEXT,
    term_as_shown      TEXT,                   -- text after "Term:", exactly as shown
    term_end_iso       TEXT,                   -- normalized date for sorting (YYYY-MM or YYYY-MM-DD); NULL if unclear
    email_listed       INTEGER NOT NULL CHECK (email_listed IN (0,1)),
    phone_listed       INTEGER NOT NULL CHECK (phone_listed IN (0,1)),
    verified_by        TEXT
);

-- Problems in the ORIGINAL content, for the remediation plan. page_id NULL = site-wide.
CREATE TABLE issues (
    issue_id           INTEGER PRIMARY KEY,
    page_id            INTEGER REFERENCES pages(page_id),
    issue_type         TEXT NOT NULL CHECK (issue_type IN
                         ('original_typo','outdated','inconsistency','duplicate','missing_content',
                          'thin_content','privacy','structure','other')),
    text_as_shown      TEXT,                   -- the exact words involved, if any
    description        TEXT NOT NULL,
    suggested_action   TEXT,                   -- remediation idea (decision is not made here)
    verified_by        TEXT
);

-- Errors that OCR introduced, found by comparing ocr/raw to ocr/verified. Filled in during Step 4.
CREATE TABLE ocr_errors (
    error_id           INTEGER PRIMARY KEY,
    page_id            INTEGER NOT NULL REFERENCES pages(page_id),
    method             TEXT NOT NULL DEFAULT 'tesseract',  -- tesseract | llm:<model name and version>
    region             TEXT NOT NULL CHECK (region IN
                         ('body','heading','sidebar_nav','top_nav','footer','image_caption','link')),
    error_type         TEXT NOT NULL CHECK (error_type IN
                         ('character_substitution','word_split_or_merge','missing_text','extra_text',
                          'number_or_date','name','email_or_url','punctuation','reading_order',
                          'heading_or_list_structure','other')),
    ocr_text           TEXT,                   -- what OCR produced
    correct_text       TEXT,                   -- what the screenshot shows
    severity           TEXT NOT NULL CHECK (severity IN ('high','medium','low')),
                         -- high = changes a name, number, date, email, link or meaning
    notes              TEXT,
    recorded_by        TEXT NOT NULL
);

-- Convenience view: one summary line per page (good for the memo).
CREATE VIEW page_summary AS
SELECT p.slug, p.section, p.page_title, p.level, p.content_type, p.assigned_to,
       p.recovery_status, p.image_count, p.document_count,
       (SELECT COUNT(*) FROM members m WHERE m.page_id = p.page_id)     AS member_count,
       (SELECT COUNT(*) FROM issues  i WHERE i.page_id = p.page_id)     AS issue_count,
       (SELECT COUNT(*) FROM ocr_errors e WHERE e.page_id = p.page_id)  AS ocr_errors_logged
FROM pages p
ORDER BY p.section, p.page_title;
