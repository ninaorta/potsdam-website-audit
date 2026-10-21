-- OCR errors for Bolatito Abolade's pages: ps-rescue (page 1), parks-lehman (page 4), board-zoning (page 7)
-- Method: Tesseract, -l eng --psm 3, full-page screenshot, no preprocessing.
-- How to fill this in: see TEAM_GUIDE.md, Part 5.
--
-- 1. Delete the "-- " at the start of the INSERT line and of each row line below.
-- 2. Copy the example row once for every error you find, and change the values.
-- 3. Every row ends with a comma, except the LAST row, which ends with a semicolon.

-- INSERT INTO ocr_errors (page_id, method, region, error_type, ocr_text, correct_text, severity, notes, recorded_by) VALUES
-- (1, 'tesseract', 'body', 'reading_order', 'what OCR wrote', 'what the screenshot shows', 'high', 'short note', 'Bolatito Abolade'),
-- (4, 'tesseract', 'footer', 'missing_text', NULL, 'what the screenshot shows', 'high', 'short note', 'Bolatito Abolade');

-- When all three pages are checked, delete the "-- " at the start of the next line:
-- UPDATE pages SET recovery_status = 'verified', verified_by = 'Bolatito Abolade', ocr_error_count = (SELECT COUNT(*) FROM ocr_errors e WHERE e.page_id = pages.page_id) WHERE page_id IN (1, 4, 7);
