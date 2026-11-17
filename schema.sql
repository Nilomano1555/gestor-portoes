-- Gestor Portões | schema inicial Supabase
create extension if not exists pgcrypto;
create table if not exists public.clients (
 id uuid primary key default gen_random_uuid(), user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
 name text not null, phone text, address text, city text, notes text, created_at timestamptz not null default now()
);
create table if not exists public.service_catalog (
 id uuid primary key default gen_random_uuid(), user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
 name text not null, category text default 'Manutenção', price numeric(12,2) not null default 0, created_at timestamptz not null default now()
);
create table if not exists public.jobs (
 id uuid primary key default gen_random_uuid(), user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
 client_id uuid references public.clients(id) on delete set null, kind text not null, scheduled_at timestamptz,
 address text, description text, status text not null default 'Orçamento', price numeric(12,2) not null default 0,
 payment_status text not null default 'Pendente', created_at timestamptz not null default now()
);
create index if not exists clients_user_idx on public.clients(user_id);
create index if not exists jobs_user_date_idx on public.jobs(user_id,scheduled_at);
create index if not exists services_user_idx on public.service_catalog(user_id);
alter table public.clients enable row level security;
alter table public.service_catalog enable row level security;
alter table public.jobs enable row level security;
create policy "clients own rows" on public.clients for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "services own rows" on public.service_catalog for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "jobs own rows" on public.jobs for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
