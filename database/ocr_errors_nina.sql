-- OCR errors for Nina's pages: ps-fire (3), parks-garner (6), board-rec (9)
-- Method: Tesseract 5.5.3, leptonica 1.87.0, -l eng --psm 3, full-page screenshot, no preprocessing.
-- Found by comparing ocr/raw/<slug>.txt with ocr/verified/<slug>.txt and the screenshot.
-- Verified files hold the page-specific content only; shared navigation and footer
-- are verified once in ocr/verified/_site-chrome.txt, but their OCR errors are logged here.

INSERT INTO ocr_errors (page_id, method, region, error_type, ocr_text, correct_text, severity, notes, recorded_by) VALUES
-- ---------------- ps-fire (page 3)
(3,'tesseract','top_nav','missing_text',NULL,'Home | Search | News | Calendars | Departments','medium',
 'White text on blue buttons was not read at all.','Nina'),
(3,'tesseract','sidebar_nav','reading_order','i Y Agendas & Minut / Public Safety y gendas & Minutes','Public Safety (heading) + Agendas & Minutes (nav)',
 'medium','Section heading merged with a garbled, duplicated nav item.','Nina'),
(3,'tesseract','heading','reading_order','Potsdam Fire Department 7 Boards & Committees','Potsdam Fire Department',
 'high','Page title merged with a side-nav item on the same line.','Nina'),
(3,'tesseract','body','reading_order','42 Main Street # Educational Facilities','42 Main Street',
 'high','Street address merged with a side-nav item.','Nina'),
(3,'tesseract','body','reading_order','Phone: 315-265-3312 7 Forms','Phone: 315-265-3312',
 'high','Digits are correct, but a stray "7" (checkmark icon) follows the number and could be read as part of it.','Nina'),
(3,'tesseract','body','reading_order','Fax: 315-265-7738 Y Laws','Fax: 315-265-7738',
 'high','Fax number merged with a side-nav item.','Nina'),
(3,'tesseract','link','reading_order','Website: www.potsdamfire.org Y Links','Website: www.potsdamfire.org',
 'medium','URL itself is correct; nav item appended.','Nina'),
(3,'tesseract','sidebar_nav','character_substitution','i, Y, y, 7, #','(checkmark icons)',
 'low','Icons read as letters and symbols.','Nina'),
(3,'tesseract','sidebar_nav','reading_order','FAQ''s (after Parking Tickets)','FAQ''s (after Educational Facilities)',
 'low','Nav item placed out of order.','Nina'),
(3,'tesseract','body','extra_text','Return To List .','Return To List',
 'low','Stray period.','Nina'),
(3,'tesseract','footer','missing_text',NULL,'Website Contact block (8 lines) and Website Disclaimer paragraph',
 'high','Small dark text on blue background was dropped entirely: village contact name, email, address, phone and fax lost with no warning.','Nina'),
(3,'tesseract','footer','extra_text','DE wees Eee / Digital','Powered By: Digital Towpath www.DigitalTowpath.org',
 'low','Logo read as garbage.','Nina'),

-- ---------------- parks-garner (page 6)
(6,'tesseract','top_nav','missing_text',NULL,'Home | Search | News | Calendars | Departments','medium',
 'White text on blue buttons was not read at all.','Nina'),
(6,'tesseract','heading','missing_text',NULL,'Parks','medium',
 'Section heading missing; output starts with the page title.','Nina'),
(6,'tesseract','body','heading_or_list_structure','Information / e Facilities / e Images','• Information / • Facilities / • Images',
 'low','Bullets read as "e"; first bullet dropped.','Nina'),
(6,'tesseract','image_caption','extra_text','= oe es',NULL,
 'low','Garbage characters produced from a gallery photo.','Nina'),
(6,'tesseract','image_caption','reading_order','Garner Park 3 / Garner Park','Garner Park / Garner Park 3',
 'low','Gallery captions reversed (left image has a taller thumbnail, so its caption sits lower).','Nina'),
(6,'tesseract','body','missing_text',NULL,'Return To List','low',
 'White text on blue button not read.','Nina'),
(6,'tesseract','footer','missing_text',NULL,'Website Contact block (8 lines) and Website Disclaimer paragraph','high',
 'Same footer loss as ps-fire.','Nina'),
(6,'tesseract','footer','extra_text','Eaweke od By)','Powered By: Digital Towpath www.DigitalTowpath.org','low',
 'Logo read as garbage.','Nina'),

-- ---------------- board-rec (page 9)
(9,'tesseract','top_nav','missing_text',NULL,'Home | Search | News | Calendars | Departments','medium',
 'White text on blue buttons was not read at all.','Nina'),
(9,'tesseract','heading','reading_order','Joint Recreation Committee Boards & Committees','Joint Recreation Committee','high',
 'Page title merged with a side-nav item on the same line.','Nina'),
(9,'tesseract','heading','reading_order','? Agendas & Minutes / Boards & Committees','Boards & Committees (heading) before nav',
 'low','Section heading placed after the first nav item.','Nina'),
(9,'tesseract','sidebar_nav','missing_text',NULL,'FAQ''s','medium',
 'One of the 16 nav items is missing from the output.','Nina'),
(9,'tesseract','sidebar_nav','character_substitution','?','(checkmark icons)','low',
 'Icons read as question marks.','Nina'),
(9,'tesseract','body','missing_text',NULL,'Return To List','low',
 'White text on blue button not read.','Nina'),
(9,'tesseract','footer','missing_text',NULL,'Website Contact block (8 lines) and Website Disclaimer paragraph','high',
 'Same footer loss as ps-fire.','Nina'),
(9,'tesseract','footer','extra_text','PaWete Ey / Digital','Powered By: Digital Towpath www.DigitalTowpath.org','low',
 'Logo read as garbage.','Nina');

-- New original-content issues noticed during verification
INSERT INTO issues (page_id, issue_type, text_as_shown, description, suggested_action) VALUES
(6,'original_typo','acquired as part on',
 'Original says "part on" where "part of" is meant. OCR reproduced it correctly.','Correct during remediation, not during recovery.'),
(6,'outdated','handicap accessible',
 'Dated accessibility wording.','Revise wording during remediation (e.g. describe the accessible features).');

-- Update page status (set to 'verified' and add verified_by only after a human check)
UPDATE pages SET recovery_status = 'ocr_done',
       ocr_error_count = (SELECT COUNT(*) FROM ocr_errors e WHERE e.page_id = pages.page_id)
 WHERE page_id IN (3, 6, 9);
UPDATE pages SET recovery_status = 'verified', verified_by = 'Nurina Darmawati' WHERE page_id IN (3, 6, 9);
