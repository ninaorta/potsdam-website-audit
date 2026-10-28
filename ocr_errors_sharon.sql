-- OCR errors for Sharon Ajibade's pages: ps-police (page 2), parks-ives (page 5), board-fire (page 8)
-- Method: Tesseract 5.3.4, leptonica 1.82.0, -l eng --psm 3, full-page screenshot, no preprocessing.
-- Provenance note: Tesseract was not installed on Sharon's computer, so the raw OCR for these three
-- pages was run with the same command (scripts/run_ocr.sh settings) by Claude (Anthropic AI assistant)
-- in a separate environment. That environment had Tesseract 5.3.4, not the 5.5.3 used for Nina's pages.
-- A test on Nina's pages showed the two versions read page text the same way but produce slightly
-- different garbage characters for icons and the footer logo.
-- The verified text was drafted with Claude from the screenshots and reviewed by Sharon Ajibade.
-- Found by comparing ocr/raw/<slug>.txt with ocr/verified/<slug>.txt and the screenshot.
-- Shared navigation and footer are verified once in ocr/verified/_site-chrome.txt, but their OCR errors are logged here.

INSERT INTO ocr_errors (page_id, method, region, error_type, ocr_text, correct_text, severity, notes, recorded_by) VALUES
-- ---------------- ps-police (page 2)
(2,'tesseract','top_nav','missing_text',NULL,'Home | Search | News | Calendars | Departments','medium',
 'White text on blue buttons was not read at all.','Sharon Ajibade'),
(2,'tesseract','sidebar_nav','reading_order','i Y Agendas & Minute / Public Safety y gendas & Minutes','Public Safety (heading) + Agendas & Minutes (nav)','medium',
 'Section heading merged with a garbled, duplicated nav item.','Sharon Ajibade'),
(2,'tesseract','heading','reading_order','Potsdam Police Department 7 Boards & Committees','Potsdam Police Department','high',
 'Page title merged with a side-nav item on the same line.','Sharon Ajibade'),
(2,'tesseract','body','reading_order','38 Main Street Educational Facilities','38 Main Street','high',
 'Street address merged with a side-nav item.','Sharon Ajibade'),
(2,'tesseract','body','reading_order','Economic Development / Address:','Address: (label above the street address)','low',
 'The Address label was placed among the nav items instead of with the address.','Sharon Ajibade'),
(2,'tesseract','heading','reading_order','Description: Y Maps','Description:','medium',
 'Subheading merged with a side-nav item.','Sharon Ajibade'),
(2,'tesseract','body','reading_order','See Department or Potsdam Police website for more information. Y Parking Tickets','See Department or Potsdam Police website for more information.','medium',
 'Nav item appended to the end of the description sentence.','Sharon Ajibade'),
(2,'tesseract','sidebar_nav','character_substitution','i, Y, y, 7, Ww','(checkmark icons)','low',
 'Icons read as letters and symbols.','Sharon Ajibade'),
(2,'tesseract','footer','missing_text',NULL,'Website Contact block (8 lines) and Website Disclaimer paragraph','high',
 'Same footer loss as ps-fire: contact name, email, address, phone and fax lost with no warning.','Sharon Ajibade'),
(2,'tesseract','footer','extra_text','Eaweke od By) / Digital / wee Bi gi 9','Powered By: Digital Towpath www.DigitalTowpath.org','low',
 'Logo read as garbage.','Sharon Ajibade'),

-- ---------------- parks-ives (page 5)
(5,'tesseract','top_nav','missing_text',NULL,'Home | Search | News | Calendars | Departments','medium',
 'White text on blue buttons was not read at all.','Sharon Ajibade'),
(5,'tesseract','heading','missing_text',NULL,'Parks','medium',
 'Section heading missing; output starts with the side-nav list.','Sharon Ajibade'),
(5,'tesseract','heading','reading_order','Boards & Committees / Ives Park / Economic Development','Ives Park (page title)','medium',
 'Page title placed in the middle of the side-nav list.','Sharon Ajibade'),
(5,'tesseract','body','missing_text',NULL,'Contact: Lori Queor','high',
 'Contact person''s name dropped entirely.','Sharon Ajibade'),
(5,'tesseract','body','missing_text',NULL,'Address:','low',
 'Address label dropped.','Sharon Ajibade'),
(5,'tesseract','body','reading_order','3 Riverview Drive 3 @ FAQ''s','3 Riverview Drive','high',
 'Street address merged with a stray "3" and a side-nav item; could be misread as part of the address.','Sharon Ajibade'),
(5,'tesseract','link','email_or_url','|queor@vi.potsdam.ny.us','lqueor@vi.potsdam.ny.us','high',
 'Lowercase l read as a vertical bar, so the email address is wrong.','Sharon Ajibade'),
(5,'tesseract','heading','reading_order','Table Of Contents: @ Links','Table Of Contents:','medium',
 'Subheading merged with a side-nav item.','Sharon Ajibade'),
(5,'tesseract','image_caption','extra_text','Ives Park Gazebo 4','Ives Park Gazebo','low',
 'Stray "4" added after the caption.','Sharon Ajibade'),
(5,'tesseract','body','heading_or_list_structure','« Information ” Maps / ¢ Facilities w Parking Tickets / « Reservations / e Images','• Information / • Facilities / • Reservations / • Images','low',
 'Bullets read as symbols, and two list items merged with side-nav items.','Sharon Ajibade'),
(5,'tesseract','heading','reading_order','Information: ef Trash and Recycling','Information:','medium',
 'Subheading merged with a side-nav item.','Sharon Ajibade'),
(5,'tesseract','body','reading_order','The Park can be w Village Tax Payments / Potsdam Farmer''s w Water / Sewer Payments','The Park can be / Potsdam Farmer''s','medium',
 'Nav items inserted into the middle of the Information paragraph.','Sharon Ajibade'),
(5,'tesseract','body','punctuation','accessed via .','accessed via','low',
 'Stray period at the end of a paragraph line.','Sharon Ajibade'),
(5,'tesseract','body','heading_or_list_structure','¢ Gazebo / ¢ Benches / Picnic Tables / ¢ Canoe/Kayak Launch','• Gazebo / • Benches / • Picnic Tables / • Canoe/Kayak Launch','low',
 'Bullets read as "¢"; one bullet dropped.','Sharon Ajibade'),
(5,'tesseract','sidebar_nav','character_substitution','@, w, ef, ”','(checkmark icons)','low',
 'Icons read as letters and symbols.','Sharon Ajibade'),
(5,'tesseract','image_caption','missing_text',NULL,'Ives Park','low',
 'Gallery caption under the thumbnail not read.','Sharon Ajibade'),
(5,'tesseract','body','missing_text',NULL,'Return To List','low',
 'White text on blue button not read.','Sharon Ajibade'),
(5,'tesseract','footer','missing_text',NULL,'Website Contact block (8 lines), Website Disclaimer paragraph and Powered By: Digital Towpath logo','high',
 'Same footer loss as ps-fire; logo text also missing.','Sharon Ajibade'),

-- ---------------- board-fire (page 8)
(8,'tesseract','body','heading_or_list_structure','¢ Members / ¢ FAQs','• Members / • FAQs','low',
 'Bullets read as "¢".','Sharon Ajibade'),
(8,'tesseract','link','email_or_url','(dmrose@potsdamfire.o','(dmrose@potsdamfire.org)','high',
 'Email address cut off; the rest of the line was dropped.','Sharon Ajibade'),
(8,'tesseract','top_nav','reading_order','Home / Search / News / Calendars / Departments (after Return To List)','Home / Search / News / Calendars / Departments (top of page)','low',
 'Top navigation read correctly but placed after the page content.','Sharon Ajibade'),
(8,'tesseract','sidebar_nav','character_substitution','@, BS SS SS SS SS SS','(checkmark icons)','low',
 'Icons read as symbols; one line of pure garbage.','Sharon Ajibade'),
(8,'tesseract','footer','missing_text',NULL,'Website Contact block (8 lines) and Website Disclaimer paragraph','high',
 'Same footer loss as ps-fire.','Sharon Ajibade'),
(8,'tesseract','footer','extra_text','PBWere o By','Powered By: Digital Towpath www.DigitalTowpath.org','low',
 'Logo read as garbage.','Sharon Ajibade');

-- When all three pages are checked, delete the "-- " at the start of the next line:
UPDATE pages SET recovery_status = 'verified', verified_by = 'Sharon Ajibade', ocr_error_count = (SELECT COUNT(*) FROM ocr_errors e WHERE e.page_id = pages.page_id) WHERE page_id IN (2, 5, 8);
