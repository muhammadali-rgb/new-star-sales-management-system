# Sales & Visit Tracker

A web app I built to manage my daily work as a Sales and Application Specialist
in the medical diagnostics field. It tracks customer visits, orders, and sales
opportunities, and reminds me to follow up with customers who haven't been
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
- [Daily / weekly / monthly / yearly reports: add only when built]

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
[Add 2-3 screenshots here, using fake data only]

## Security Notes
- Secrets are kept in `.env`, which is excluded from Git
- Row Level Security is enabled on all tables
- [Mention if sign-ups are disabled, or that per-user policies are planned]

## Roadmap
- Reports and analytics
- Per-user data ownership policies

## Built With AI Assistance
Designed and tested by me, with code developed using ChatGPT and Claude.
