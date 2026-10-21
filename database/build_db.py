"""Rebuild inventory.db from the SQL source files, then export CSVs.

Run from the database/ folder:   python3 build_db.py

Why: three people editing one binary .db file on GitHub causes merge conflicts.
Instead, everyone edits SQL text files and rebuilds:
  schema.sql            table definitions
  seed.sql              page inventory, images, documents, members, issues
  ocr_errors_*.sql      one file per team member (ocr_errors_nina.sql, ...)
"""
import sqlite3
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
DB = HERE / "inventory.db"

if DB.exists():
    DB.unlink()

con = sqlite3.connect(DB)
con.execute("PRAGMA foreign_keys = ON")
files = ["schema.sql", "seed.sql"] + sorted(p.name for p in HERE.glob("ocr_errors_*.sql"))
for name in files:
    con.executescript((HERE / name).read_text(encoding="utf-8"))
    print(f"loaded {name}")
con.commit()

problems = con.execute("PRAGMA foreign_key_check").fetchall()
if problems:
    sys.exit(f"Foreign key problems: {problems}")
con.close()

subprocess.run([sys.executable, str(HERE / "export_csv.py")], check=True)
