-- OCR errors for Bolatito Abolade's pages: ps-rescue (page 1), parks-lehman (page 4), board-zoning (page 7)
-- Method: Tesseract, -l eng --psm 3, full-page screenshot, no preprocessing.
-- How to fill this in: see TEAM_GUIDE.md, Part 5.

INSERT INTO ocr_errors (page_id, method, region, error_type, ocr_text, correct_text, severity, notes, recorded_by) VALUES
(1, 'tesseract', 'sidebar', 'extra_text', 'Agendas & Minutes ... Water / Sewer Payments', NULL, 'low', '16 side-menu items added to page text', 'Bolatito Abolade'),
(1, 'tesseract', 'footer', 'extra_text', 'DE wees Eee Digital', NULL, 'low', 'Logo in footer misread as text', 'Bolatito Abolade'),
(1, 'tesseract', 'footer', 'extra_text', '© 2023 Village Of Potsdam, St.Lawrence County', NULL, 'low', 'Footer copyright line removed from verified file', 'Bolatito Abolade'),
(4, 'tesseract', 'body', 'missing_text', 'Information', '• Information', 'low', 'Bullet missing in table of contents', 'Bolatito Abolade'),
(4, 'tesseract', 'body', 'wrong_character', 'e Images', '• Images', 'low', 'Bullet read as letter e', 'Bolatito Abolade'),
(4, 'tesseract', 'body', 'reading_order', 'Lehman Park 3 ... Lehman Park Lehman Park 2', 'Lehman Park, Lehman Park 2, Lehman Park 3', 'medium', 'Image captions out of order', 'Bolatito Abolade'),
(4, 'tesseract', 'body', 'extra_text', '| rn', NULL, 'low', 'Image misread as characters', 'Bolatito Abolade'),
(4, 'tesseract', 'body', 'missing_text', NULL, 'Return To List', 'medium', 'Link text not captured', 'Bolatito Abolade'),
(4, 'tesseract', 'sidebar', 'extra_text', 'Agendas & Minutes ... Water / Sewer Payments', NULL, 'low', '16 side-menu items added to page text', 'Bolatito Abolade'),
(4, 'tesseract', 'footer', 'extra_text', 'PaWete Ey Digital', NULL, 'low', 'Logo in footer misread as text', 'Bolatito Abolade'),
(4, 'tesseract', 'footer', 'extra_text', '© 2023 Village Of Potsdam, St.Lawrence County', NULL, 'low', 'Footer copyright line removed from verified file', 'Bolatito Abolade'),
(7, 'tesseract', 'header', 'extra_text', 'Calendars partments', NULL, 'low', 'Top navigation buttons misread, Departments cut off', 'Bolatito Abolade'),
(7, 'tesseract', 'body', 'wrong_character', '¢ Duties', '• Duties', 'low', 'Bullet misread', 'Bolatito Abolade'),
(7, 'tesseract', 'body', 'wrong_character', '¢ Members', '• Members', 'low', 'Bullet misread', 'Bolatito Abolade'),
(7, 'tesseract', 'body', 'wrong_character', '¢ FAQs', '• FAQs', 'low', 'Bullet misread', 'Bolatito Abolade'),
(7, 'tesseract', 'body', 'wrong_character', '« Documents', '• Documents', 'low', 'Bullet misread', 'Bolatito Abolade'),
(7, 'tesseract', 'body', 'wrong_character', '¢ Orders, requirements, decisions', '• Orders, requirements, decisions', 'low', 'Bullet misread', 'Bolatito Abolade'),
(7, 'tesseract', 'body', 'missing_text', 'Use variances.', '• Use variances.', 'low', 'Bullet missing', 'Bolatito Abolade'),
(7, 'tesseract', 'body', 'wrong_character', '« Area variances.', '• Area variances.', 'low', 'Bullet misread', 'Bolatito Abolade'),
(7, 'tesseract', 'body', 'wrong_character', '¢ Imposition of conditions.', '• Imposition of conditions.', 'low', 'Bullet misread', 'Bolatito Abolade'),
(7, 'tesseract', 'body', 'missing_text', '. Public Hearings and Special Meetings', '2. Public Hearings and Special Meetings', 'medium', 'List number 2 missing', 'Bolatito Abolade'),
(7, 'tesseract', 'body', 'missing_text', '. Members are appointed by the Mayor', '3. Members are appointed by the Mayor', 'medium', 'List number 3 missing', 'Bolatito Abolade'),
(7, 'tesseract', 'body', 'missing_text', '. An Oath of Office is required.', '4. An Oath of Office is required.', 'medium', 'List number 4 missing', 'Bolatito Abolade'),
(7, 'tesseract', 'body', 'missing_text', '. The Mayor, with approval', '5. The Mayor, with approval', 'medium', 'List number 5 missing', 'Bolatito Abolade'),
(7, 'tesseract', 'body', 'wrong_character', '¢ Use this form', '• Use this form', 'low', 'Bullet misread', 'Bolatito Abolade'),
(7, 'tesseract', 'body', 'wrong_character', '¢ $50 application fee.', '• $50 application fee.', 'low', 'Bullet misread', 'Bolatito Abolade'),
(7, 'tesseract', 'sidebar', 'extra_text', 'Agendas & Minutes ... Water / Sewer Payments', NULL, 'low', '16 side-menu items added to page text', 'Bolatito Abolade'),
(7, 'tesseract', 'body', 'missing_text', NULL, 'Return To List', 'medium', 'Link text not captured', 'Bolatito Abolade'),
(7, 'tesseract', 'footer', 'extra_text', '© 2023 Village Of Potsdam, St.Lawrence County', NULL, 'low', 'Footer copyright line removed from verified file', 'Bolatito Abolade');

UPDATE pages SET recovery_status = 'verified', verified_by = 'Bolatito Abolade', ocr_error_count = (SELECT COUNT(*) FROM ocr_errors e WHERE e.page_id = pages.page_id) WHERE page_id IN (1, 4, 7);
