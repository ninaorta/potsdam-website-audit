"""Export every table (and the page_summary view) in inventory.db to CSV.

Run from the database/ folder:   python3 export_csv.py
Output goes to database/csv/. Re-run before every commit that changes the
database, so the CSV files always match the authoritative SQLite file.
"""
import csv
import sqlite3
from pathlib import Path

HERE = Path(__file__).resolve().parent
DB = HERE / "inventory.db"
OUT = HERE / "csv"
OUT.mkdir(exist_ok=True)

con = sqlite3.connect(DB)
names = [r[0] for r in con.execute(
    "SELECT name FROM sqlite_master WHERE type IN ('table','view') "
    "AND name NOT LIKE 'sqlite_%' ORDER BY type DESC, name")]

for name in names:
    cur = con.execute(f'SELECT * FROM "{name}"')
    headers = [d[0] for d in cur.description]
    rows = cur.fetchall()
    with open(OUT / f"{name}.csv", "w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(headers)
        w.writerows(rows)
    print(f"{name}.csv  ({len(rows)} rows)")

con.close()
