# Team guide: adding your pages

This guide walks you through everything, from installing the tools to pushing your work to GitHub. Take it one part at a time. Copy each command exactly, paste it into Terminal, and press Enter.

| Person | Your pages | Page numbers | Your error-log file |
|---|---|---|---|
| Bolatito Abolade | ps-rescue, parks-lehman, board-zoning | 1, 4, 7 | database/ocr_errors_bolatito.sql |
| Sharon Ajibade | ps-police, parks-ives, board-fire | 2, 5, 8 | database/ocr_errors_sharon.sql |

**Please take turns.** Bolatito does Parts 7–8 first and tells the group. Then Sharon does Parts 7–8. This avoids clashes on GitHub.

If you get stuck, take a screenshot of Terminal and send it to Nurina.

---

## Part 1: Accept the GitHub invitation

1. Check your email for "invited you to collaborate on ninaorta/potsdam-website-audit".
2. Click **View invitation**, then **Accept invitation**.

If you can't find the email, go to github.com/ninaorta/potsdam-website-audit while logged in. A banner at the top lets you accept.

---

## Part 2: Install the tools (once)

Everyone needs four things: **Homebrew** (Mac only), **Git and GitHub CLI**, **Tesseract**, and **VS Code**.

### On a Mac

Open **Terminal**: press Cmd + Space, type Terminal, press Enter.

**a. Homebrew.** Paste this and press Enter:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
- It asks for your Mac password. The letters don't show while you type; that's normal. Type it and press Enter.
- If it says "Press RETURN", press Enter.
- It can take 5–15 minutes.
- At the end it shows **Next steps** with three commands. Copy and run each one. They usually look like this:
```
echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv zsh)"
```
Check it worked:
```
brew --version
```
You should see a version number.

**b. Tesseract and GitHub CLI:**
```
brew install tesseract gh
```

**c. VS Code:**
```
brew install --cask visual-studio-code
```

### On Windows

1. Install **Git for Windows** from git-scm.com. Click Next through every screen; the defaults are fine. This also gives you **Git Bash**, which you'll use as your Terminal.
2. Install **GitHub CLI** from cli.github.com (Download for Windows).
3. Install **Tesseract** from github.com/UB-Mannheim/tesseract/wiki (the Windows installer). Use the default folder.
4. Install **Python** from python.org/downloads. On the first screen, tick **Add python.exe to PATH**.
5. Install **VS Code** from code.visualstudio.com.
6. Open **Git Bash** from the Start menu. Use Git Bash for every command in this guide.
7. Let Git Bash find Tesseract:
```
echo 'export PATH="$PATH:/c/Program Files/Tesseract-OCR"' >> ~/.bashrc
source ~/.bashrc
```

On Windows, type **python** wherever this guide says python3.

### Check everything (Mac and Windows)
```
tesseract --version
```
```
gh --version
```
Both should print a version number.

---

## Part 3: Log in and download the project (once)

**a. Log in to GitHub:**
```
gh auth login
```
It asks four questions. Use the arrow keys to move and Enter to choose:
1. Where do you use GitHub? → **GitHub.com**
2. Preferred protocol? → **HTTPS**
3. Authenticate Git with your GitHub credentials? → **Y**
4. How would you like to authenticate? → **Login with a web browser**

It shows a code like ABCD-1234. Press Enter, a browser opens, type the code, and click **Authorize**. Terminal then says "Logged in as ...".

**b. Tell Git your name** (use your own name and your GitHub email):
```
git config --global user.name "Your Full Name"
git config --global user.email "your-github-email@example.com"
git config --global pull.rebase false
```
The last line tells Git how to combine your work with your teammates' work.

**c. Download the project** to your Desktop:
```
cd ~/Desktop
gh repo clone ninaorta/potsdam-website-audit
cd potsdam-website-audit
```
You now have a folder **potsdam-website-audit** on your Desktop.

From now on, every time you open a new Terminal window, go into the folder first:
```
cd ~/Desktop/potsdam-website-audit
```

---

## Part 4: Run OCR on your three pages

**Bolatito:**
```
bash scripts/run_ocr.sh screenshots/ps-rescue.png screenshots/parks-lehman.png screenshots/board-zoning.png
```

**Sharon:**
```
bash scripts/run_ocr.sh screenshots/ps-police.png screenshots/parks-ives.png screenshots/board-fire.png
```

You should see three lines that start with **done:**. Your raw text files are now in **ocr/raw/**.

**Never edit the files in ocr/raw.** They are the evidence of what Tesseract produced on its own.

---

## Part 5: Check the text against the screenshots

Do this for each of your three pages. It is the most important part of the project.

**a. Open the project in VS Code.** Open VS Code, choose **File → Open Folder**, pick **potsdam-website-audit** on your Desktop, and click **Open**.

**b. Make a copy to correct.** In the left panel, open **ocr → raw**. Right-click your file (for example ps-rescue.txt) and choose **Copy**. Then right-click the **verified** folder and choose **Paste**.

**c. Correct the copy.** Open the copy in **ocr/verified**. Open the matching screenshot from the **screenshots** folder next to it. Edit the copy until it matches the screenshot exactly:
- Keep only the page's own content: the section heading, the page title, the text, image captions marked like [image caption] Lehman Park, and Return To List.
- Delete the menu items (Agendas & Minutes, Forms, Laws...) and the footer. These are already recorded once in ocr/verified/_site-chrome.txt.
- Keep the original site's typos exactly as they are. Do not fix them.

Look at Nurina's ocr/verified/parks-garner.txt for an example of a finished file.

**d. Compare the two versions.** In the left panel, right-click the file in **ocr/raw** and choose **Select for Compare**. Then right-click the same file in **ocr/verified** and choose **Compare with Selected**. The differences show in red and green. Each difference is an OCR error.

**e. Log each error.** Open your error-log file (database/ocr_errors_bolatito.sql or database/ocr_errors_sharon.sql). Follow the instructions at the top of the file:
- Delete the "-- " at the start of the INSERT line and of each example row.
- Make one row per error.

Each row has these values, in this order:

| Value | What to write | Allowed values |
|---|---|---|
| page_id | Your page number | Bolatito 1, 4, 7 · Sharon 2, 5, 8 |
| method | Always 'tesseract' | tesseract |
| region | Where on the page | body, heading, sidebar_nav, top_nav, footer, image_caption, link |
| error_type | What kind of error | character_substitution, word_split_or_merge, missing_text, extra_text, number_or_date, name, email_or_url, punctuation, reading_order, heading_or_list_structure, other |
| ocr_text | What Tesseract wrote | the text in quotes, or NULL if it wrote nothing |
| correct_text | What the screenshot shows | the text in quotes |
| severity | How serious | high (changes a name, number, date, email, link or meaning), medium (a heading or menu item lost or misplaced), low (stray characters, bullets) |
| notes | One short sentence | anything |
| recorded_by | Your full name | |

Rules that prevent errors:
- Put text values in single quotes: 'Ives Park'.
- If the text itself has an apostrophe, type it twice: 'FAQ''s'.
- Every row ends with a comma, except the **last** row, which ends with a semicolon ;

Nurina's database/ocr_errors_nina.sql has 28 finished rows you can copy from.

**f. When all three pages are done**, delete the "-- " at the start of the last line of your file (the UPDATE line). This marks your pages as verified.

---

## Part 6: Rebuild the database

```
cd database
python3 build_db.py
cd ..
```

You should see lines starting with **loaded** and then a list of CSV files. If you see an error instead, it is almost always a missing comma, quote or semicolon in your error-log file. Fix it and run the command again.

Do not edit inventory.db yourself. The build script recreates it from the .sql files every time.

---

## Part 7: Save your work to GitHub

Run these one at a time:

```
git pull
```
This gets everyone else's latest work first.

```
cd database
python3 build_db.py
cd ..
```
Rebuild once more so the database includes everyone's errors.

```
git add .
git commit -m "Verify OCR for my three pages and log errors"
git push
```

The last line should look like **main -> main**. Your work is on GitHub. Tell the group you're done.

---

## Part 8: If something goes wrong

**git push says "rejected" or "fetch first".** Someone pushed before you. Run:
```
git pull
cd database
python3 build_db.py
cd ..
git add .
git commit -m "Merge and rebuild database"
git push
```

**git pull says "CONFLICT" in inventory.db or a .csv file.** That's expected and easy to fix. Run the same commands as above, starting from cd database. Rebuilding creates a fresh database that includes everyone's work.

**Terminal says "command not found".** The tool isn't installed or Terminal can't find it. Close Terminal, open it again, and retry. If it still fails, repeat Part 2 for that tool.

**Terminal opens a strange screen after git commit** (lots of ~ symbols). You forgot the -m "message" part. Type :q and press Enter, then run the commit command again with -m "message".
