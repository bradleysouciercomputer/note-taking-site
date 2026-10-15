-- Hoplink cloud shortcuts: run this script in the SQL Editor of the Supabase
-- project you choose for this app. It creates a separate table and does not
-- alter Supabase Auth or any existing application tables.

create table if not exists public.hoplink_shortcuts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null check (char_length(btrim(title)) between 1 and 80),
  url text not null check (url ~* '^https?://'),
  description text not null default '' check (char_length(description) <= 280),
  category text not null default 'General' check (char_length(btrim(category)) between 1 and 40),
  icon text not null default '↗' check (char_length(icon) between 1 and 8),
  accent text not null default '#eeeaff' check (accent in ('#eeeaff', '#e4f7ef', '#fff0e5', '#e8f3ff', '#ffe9ef', '#f5eaff')),
  is_favorite boolean not null default false,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists hoplink_shortcuts_user_sort_idx
  on public.hoplink_shortcuts (user_id, sort_order, created_at desc);
create index if not exists hoplink_shortcuts_user_category_idx
  on public.hoplink_shortcuts (user_id, category);

alter table public.hoplink_shortcuts enable row level security;

grant select, insert, update, delete on public.hoplink_shortcuts to authenticated;
revoke all on public.hoplink_shortcuts from anon;

drop policy if exists "Users can read their own Hoplink shortcuts" on public.hoplink_shortcuts;
create policy "Users can read their own Hoplink shortcuts"
  on public.hoplink_shortcuts for select to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Users can create their own Hoplink shortcuts" on public.hoplink_shortcuts;
create policy "Users can create their own Hoplink shortcuts"
  on public.hoplink_shortcuts for insert to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update their own Hoplink shortcuts" on public.hoplink_shortcuts;
create policy "Users can update their own Hoplink shortcuts"
  on public.hoplink_shortcuts for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can delete their own Hoplink shortcuts" on public.hoplink_shortcuts;
create policy "Users can delete their own Hoplink shortcuts"
  on public.hoplink_shortcuts for delete to authenticated
  using ((select auth.uid()) = user_id);
