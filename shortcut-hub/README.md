# Hoplink — cloud shortcut hub

Hoplink is a responsive personal dashboard for saving, organizing, searching, favoriting, and opening links. Accounts use Supabase email/password authentication, and shortcuts sync to Postgres.

## Features

- Email/password sign-up, sign-in, password reset, and sign-out
- Private cloud-synced shortcuts protected by row-level security
- Add, edit, delete, favorite, and open links
- Custom categories, emoji icons, colors, and descriptions
- Search, filters, grid/list views, JSON import/export
- Responsive dashboard for desktop, tablet, and mobile

## Run locally

1. Use a static server from this directory, for example `python -m http.server 8000`.
2. Open `http://localhost:8000`.
3. Create an account with an email/password. If confirmations are enabled in Supabase, verify your email before signing in.

The standalone `index.html` is preconfigured for the Supabase project where `public.hoplink_shortcuts` was created. Its URL and publishable API key are public-client credentials. Never put a `service_role` or secret key in frontend code.

## Use a different Supabase project

1. Open `supabase/schema.sql` in the target project's SQL Editor and run it.
2. From the Hoplink sign-in screen, select **Change project** and enter the target project's URL and publishable key.

The schema has been applied to the current connected project. It creates only `public.hoplink_shortcuts`, enables RLS, and defines four owner-scoped policies for reading, creating, updating, and deleting rows. The existing project's other tables were left unchanged.

For production, add your final site URL to Supabase **Authentication → URL Configuration → Redirect URLs** and keep email confirmation enabled.
