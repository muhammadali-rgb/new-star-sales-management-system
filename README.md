# Sales & Visit Tracker

A web app I built to manage daily work as a Sales and Application Specialist
in the medical diagnostics field. It tracks customer visits, orders, and sales
opportunities, and reminds to follow up with customers who haven't been
visited recently.

## Features
- Secure login with Supabase Authentication
- Customer management (details, contacts, visit frequency)
- Visit logging with satisfaction feedback and follow-up tasks
- Analyzer and assay tracking per customer
- Orders and order items with automatic totals
- Opportunity pipeline (new analyzers, added assays)
- Training records and complaint tracking
- Automatic reminders for customers not visited in 30+ days
- Daily, weekly, monthly, and yearly visit and sales reports
  

## Tech Stack
React, Vite, JavaScript, Supabase (PostgreSQL, Auth, Row Level Security)

## Database
The schema is in `supabase/schema.sql` and includes 13 tables with
foreign keys, cascading deletes, and row-level security enabled.

## Getting Started
1. Install Node.js 18+
2. Copy `.env.example` to `.env`
3. Create a free Supabase project
4. Run `supabase/schema.sql` in the Supabase SQL Editor
5. Add your Supabase URL and anon key to `.env`
6. Run `npm install` then `npm run dev`

## Screenshots
## DASHBOARD
<img width="1878" height="895" alt="APP DASHBOARD" src="https://github.com/user-attachments/assets/4b3ec3f6-dd1a-4f1b-8c2e-1b7b3f532c01" />
## CUSTOMERS
<img width="1889" height="886" alt="Screenshot 2026-10-31 163402" src="https://github.com/user-attachments/assets/fe8182d7-418d-4e1c-91eb-cfbeb7b392ae" />
## VISITS
<img width="1887" height="901" alt="image" src="https://github.com/user-attachments/assets/7ed7d445-9006-436f-9642-92c5ce4b2014" />




## Security Notes
- Secrets are kept in `.env`, which is excluded from Git
- Row Level Security is enabled on all tables
- Public sign-ups are disabled

## Roadmap
- Per-user data ownership policies (currently single-user, with sign-ups disabled)
- Export reports to PDF/Excel
- Mobile-friendly improvements

## Built With AI Assistance
Designed and tested by me, with code developed using ChatGPT and Claude.
