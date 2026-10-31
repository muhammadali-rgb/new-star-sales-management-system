# New Star Sales & Application Management — V1

V1 includes a responsive dashboard, Supabase authentication, customer CRUD and customer contacts CRUD. The database schema also prepares the future modules.

## Run
1. Install Node.js 18+.
2. Copy `.env.example` to `.env`.
3. Create a free Supabase project.
4. Run `supabase/schema.sql` in Supabase SQL Editor.
5. Add your Supabase URL and anon/publishable key to `.env`.
6. Run `npm install` then `npm run dev`.

If Supabase variables are empty, the UI can still be previewed, but data will not persist.

Next: visits + automatic monthly reminders.
