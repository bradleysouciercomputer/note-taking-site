# Hoplink — cloud shortcut hub

A responsive personal dashboard for saving, organizing, searching, favoriting, and opening your links. User accounts use Supabase email/password authentication and shortcuts sync to the cloud.

## Features

- Email/password sign-up and sign-in, password reset, and sign-out
- Personal cloud-synced shortcuts protected by Supabase Row Level Security
- Add, edit, delete, favorite, and copy shortcut URLs
- Custom categories, emoji icons, soft accent colors, and descriptions
- Search, category filtering, favorites filtering, and grid/list views
- JSON export/import for backups
- Responsive layout for desktop, tablet, and mobile
- Supabase project credentials are entered in the app and stored in that browser only

## Setup

1. Create or select the Supabase project you want to use for Hoplink.
2. In Supabase, open **SQL Editor** and run [`supabase/schema.sql`](supabase/schema.sql). This creates `public.hoplink_shortcuts`, turns on RLS, grants only authenticated access, and restricts rows to their owner.
3. In Supabase **Project Settings → API Keys**, copy the project URL and the **publishable** key (`sb_publishable_...`). Do not use a `service_role` key or secret key in this browser app.
4. Serve this folder as a static site, e.g. with `python -m http.server 8000` from this folder, then open `http://localhost:8000`. Alternatively deploy the folder to any static web host.
5. On first launch, choose **Connect Supabase**, paste the project URL and publishable key, and save. Those values are stored in local storage in the current browser; they are public-client credentials, not a substitute for database security. RLS is what protects each user's records.
6. Create an account with an email/password. If email confirmation is enabled in Supabase, follow the confirmation link before signing in. Add your deployment URL to Supabase **Authentication → URL Configuration → Redirect URLs**.

## Important notes

- The included SQL file is intentionally not applied to any existing project automatically. Choose the right Supabase project first.
- The app uses the pinned browser UMD build of `@supabase/supabase-js` version `2.117.3` from jsDelivr.
- For production use, enable email confirmation, add your real domain to the Auth redirect allowlist, and consider CAPTCHA/rate limits for public sign-up.
- Export your shortcuts from the top-right **Export** action to keep a portable JSON backup.
