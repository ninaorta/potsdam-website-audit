-- Initial inventory data for the 9-page detailed sample.
-- Entered from the screenshots on 2026-10-19.
-- Every row has verified_by = NULL: each owner must check their rows against
-- the screenshot and then set verified_by to their name.

PRAGMA foreign_keys = ON;

-- ---------------------------------------------------------------- pages
INSERT INTO pages (page_id, screenshot_file, slug, section, page_title, parent_path, level, content_type,
                   page_sections, image_count, document_count, assigned_to, ocr_file, verified_file, notes)
VALUES
(1,'ps-rescue.png','ps-rescue','Public Safety','Potsdam Rescue Squad',
 'Home > Public Safety > Potsdam Rescue Squad',3,'department_listing',
 'Description',0,0,'Tito','ocr/raw/ps-rescue.txt','ocr/verified/ps-rescue.txt',
 'Contact block (address, two station phone numbers, website link) followed by a Description paragraph.'),

(2,'ps-police.png','ps-police','Public Safety','Potsdam Police Department',
 'Home > Public Safety > Potsdam Police Department',3,'department_listing',
 'Description',0,0,'Sharon','ocr/raw/ps-police.txt','ocr/verified/ps-police.txt',
 'Contact block (address, phone, fax, website link) and a one-sentence Description.'),

(3,'ps-fire.png','ps-fire','Public Safety','Potsdam Fire Department',
 'Home > Public Safety > Potsdam Fire Department',3,'department_listing',
 NULL,0,0,'Nina','ocr/raw/ps-fire.txt','ocr/verified/ps-fire.txt',
 'Contact block only (address with P.O. Box, phone, fax, website link). No Description section.'),

(4,'parks-lehman.png','parks-lehman','Parks','Lehman Park',
 'Home > Parks > Lehman Park',3,'park_profile',
 'Information | Images',4,0,'Tito','ocr/raw/parks-lehman.txt','ocr/verified/parks-lehman.txt',
 'Address only; no contact name or phone, unlike the other two park pages.'),

(5,'parks-ives.png','parks-ives','Parks','Ives Park',
 'Home > Parks > Ives Park',3,'park_profile',
 'Information | Facilities | Reservations | Images',2,0,'Sharon','ocr/raw/parks-ives.txt','ocr/verified/parks-ives.txt',
 'Contact person, address, phone with extension, email link. Facilities shown as a bulleted list.'),

(6,'parks-garner.png','parks-garner','Parks','Garner Park',
 'Home > Parks > Garner Park',3,'park_profile',
 'Information | Facilities | Images',3,0,'Nina','ocr/raw/parks-garner.txt','ocr/verified/parks-garner.txt',
 'Contact is an office (Village of Potsdam Offices), not a person. Facilities shown as one sentence.'),

(7,'board-zoning.png','board-zoning','Boards & Committees','Zoning Board of Appeals',
 'Home > Boards & Committees > Zoning Board of Appeals',3,'board_profile',
 'Duties | Members | FAQs | Documents',0,3,'Tito','ocr/raw/board-zoning.txt','ocr/verified/board-zoning.txt',
 'Longest page in the sample. Duties cites Village of Potsdam Code 180-33 and 180-34 D. Numbered FAQ list.'),

(8,'board-fire.png','board-fire','Boards & Committees','Potsdam Fire Department',
 'Home > Boards & Committees > Potsdam Fire Department',3,'board_profile',
 'Members | FAQs',0,0,'Sharon','ocr/raw/board-fire.txt','ocr/verified/board-fire.txt',
 'Same title as ps-fire.png but different content: officers, terms and meeting FAQs.'),

(9,'board-rec.png','board-rec','Boards & Committees','Joint Recreation Committee',
 'Home > Boards & Committees > Joint Recreation Committee',3,'board_profile',
 NULL,0,0,'Nina','ocr/raw/board-rec.txt','ocr/verified/board-rec.txt',
 'Only the title and "Number of Members: 6" are shown. No table of contents, members or FAQs.');

-- ---------------------------------------------------------------- images
INSERT INTO images (page_id, caption_as_shown, position, display_order, subject_observed, recoverable_as, notes) VALUES
(4,'Lehman Park 4','feature',1,'Paved loop with boulders and grass, trees behind','screenshot_crop_usable',NULL),
(4,'Lehman Park','gallery',2,'Paved area with trees','screenshot_crop_low_res','Gallery thumbnail'),
(4,'Lehman Park 2','gallery',3,'Paved area with water and trees in distance','screenshot_crop_low_res','Gallery thumbnail'),
(4,'Lehman Park 3','gallery',4,'Wide panoramic strip of shoreline','screenshot_crop_low_res','Very thin thumbnail; little detail'),
(5,'Ives Park Gazebo','feature',1,'Gazebo on a lawn with trees','screenshot_crop_usable',NULL),
(5,'Ives Park','gallery',2,'Wide panoramic strip of trees and lawn','screenshot_crop_low_res','Very thin thumbnail; little detail'),
(6,'Garner Park 2','feature',1,'Tree on riverbank lawn, picnic table at right','screenshot_crop_usable',NULL),
(6,'Garner Park','gallery',2,'Lawn and path beside the river','screenshot_crop_low_res','Gallery thumbnail'),
(6,'Garner Park 3','gallery',3,'Wide panoramic strip of riverbank','screenshot_crop_low_res','Very thin thumbnail; little detail');

-- ---------------------------------------------------------------- documents
INSERT INTO documents (page_id, link_text, file_type_as_shown, file_size_as_shown, description_as_shown, notes) VALUES
(7,'Application to the Zoning Board of Appeals','PDF','627.2 KB',
 'Use this form to apply to the Zoning Board of Appeals for any kind of variance such as an area or use variance, or to apply for an appeal from a formal decision made by the Code Enforcement, Planning Board, or Village Board. For additional information contact the Code Enforcement Office. | $50 application fee.',
 'Fee amount must be confirmed by the village before republishing.'),
(7,'Guide To Planning and Zoning Laws','PDF','1.7 MB',NULL,NULL),
(7,'2020 Meeting Dates','PDF','10.2 KB',NULL,'Year-specific; outdated.');

-- ---------------------------------------------------------------- members
INSERT INTO members (page_id, display_order, name_as_shown, role_as_shown, term_as_shown, term_end_iso, email_listed, phone_listed) VALUES
(8,1,'Justin C. Perry','3rd Assistant Cheif','Term expires 04/2018','2018-04',1,0),
(8,2,'Danielle M. Rose','Chief','Term expires 04/2018','2018-04',1,0),
(8,3,'Timothy L. Jerome','1st Assistant Chief','Term expires 04/2018','2018-04',1,0),
(8,4,'Jerrid Lavoie','2nd Assistant Chief','Term expires 04/2018','2018-04',0,0),
(7,1,'Mary Cabral','Alternate Member','Term expires 9/19/2021','2021-09-19',1,1),
(7,2,'Edward Komara','Chairman','Term expires 11/3/2023','2023-11-03',1,1),
(7,3,'Richard Del Guidice','Member','September 19, 2021','2021-09-19',1,1),
(7,4,'Janna Cummings','Member','Term expires 11/18/2024','2024-11-18',0,0),
(7,5,'Mike Weil','Alternate Member','Term expires 11/6/2022','2022-11-06',1,1),
(7,6,'Louann Lange','Member','Term expires 9/21/2025','2025-09-21',0,0);

-- ---------------------------------------------------------------- issues (original content)
INSERT INTO issues (page_id, issue_type, text_as_shown, description, suggested_action) VALUES
-- site-wide
(NULL,'structure',NULL,
 'Every page repeats the same banner photo, top navigation (Home, Search, News, Calendars, Departments), 16-item side navigation, footer contact block and disclaimer. OCR will capture all of it on every page.',
 'Crop screenshots to the content area before OCR, or strip repeated text; recover the shared elements once.'),
(NULL,'structure','Return To List',
 'Every detail page has a "Return To List" button, so each section had a list page (level 2). None of those list pages is in this sample.',
 'Check the full archive for the list pages when building the sitemap.'),
(NULL,'outdated','© 2023 Village Of Potsdam, St.Lawrence County',
 'Footer copyright year is 2023, which suggests the capture date; several pages hold content older than that.',NULL),
-- Public Safety
(1,'inconsistency','38 Main Street',
 'Address block says 38 Main Street, but the Description says Station 1 is at 29 Elm Street, Potsdam.',
 'Ask the rescue squad which address is current.'),
(2,'thin_content','See Department or Potsdam Police website for more information.',
 'Description only points elsewhere; no information about the department itself.',
 'Decide whether to keep a listing page or link directly to the department site.'),
(3,'duplicate','Potsdam Fire Department',
 'A second page with the same title exists under Boards & Committees (board-fire.png) with different content.',
 'Consider consolidating into one Fire Department page.'),
(3,'missing_content',NULL,
 'No Description section, while the Police and Rescue Squad listings have one.',NULL),
-- Parks
(4,'original_typo','known for being great a area for fishing',
 'Word order error in the original text ("great a area").','Correct during remediation, not during recovery.'),
(4,'missing_content',NULL,
 'No contact name or phone number, unlike Ives Park and Garner Park.',NULL),
(4,'other','The SUNY Potsdam owns a large park',
 'Page describes a park owned by SUNY Potsdam, not the village.',
 'Confirm whether the village should keep this page or link to SUNY Potsdam.'),
(5,'inconsistency','Racquette River',
 'River name spelled "Racquette" here but "Raquette" on the Garner and Lehman pages.',
 'Standardize spelling during remediation.'),
(5,'inconsistency','Contact the Village Clerk at 265-7480.',
 'Reservations phone number has no area code; other numbers on the page use 315-265-7480.',NULL),
(5,'outdated','A new kayak/canoe launch was installed in the spring of 2014',
 'Describes a 2014 installation as "new".','Revise wording.'),
(6,'other','Raymond Street',
 'Address has no street number (Raymond Street, Potsdam, NY 13676).',NULL),
-- Boards & Committees
(7,'inconsistency','Number of Members: 7',
 'States 7 members but lists 6.','Confirm current membership.'),
(7,'outdated',NULL,
 'Every listed term end date (2021 to 2025) has passed; three had passed before the 2023 footer date.',
 'Replace member list with current appointments.'),
(7,'inconsistency','Term: September 19, 2021',
 'One term is written as a date without "Term expires" and in a different date format from the others.',NULL),
(7,'missing_content','Janna Cummings ( )',
 'Empty email brackets and an empty "Phone:" line.',NULL),
(7,'privacy','Phone: 315-265-3163 - H',
 'Members'' home phone numbers (marked "- H") and personal email addresses are published.',
 'Ask the village whether to publish an office contact instead.'),
(7,'outdated','2020 Meeting Dates',
 'Linked PDF of 2020 meeting dates.','Replace with current schedule or remove.'),
(8,'original_typo','3rd Assistant Cheif',
 '"Cheif" is misspelled in the original.','Correct during remediation, not during recovery.'),
(8,'original_typo','Regular meetins are held',
 '"meetins" is misspelled in the original.','Correct during remediation, not during recovery.'),
(8,'outdated','Term expires 04/2018',
 'All four officer terms expired in April 2018.','Replace with current officers.'),
(8,'duplicate','Potsdam Fire Department',
 'Same title as the Public Safety page ps-fire.png, different content.',
 'Consider consolidating into one Fire Department page.'),
(8,'structure',NULL,
 'A fire department (an emergency service) is listed as a Board/Committee. Probably because its officers are elected and approved by the Village Board.',
 'Reconsider placement in the new information architecture.'),
(9,'thin_content','Number of Members: 6',
 'Page shows only the title and member count: no members, duties, meeting info or documents.',
 'Ask the village for current content or remove the page.');
