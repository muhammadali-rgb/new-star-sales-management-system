create extension if not exists "pgcrypto";

create table if not exists public.customers (
 id uuid primary key default gen_random_uuid(), customer_name text not null,
 customer_type text not null default 'Medical Laboratory', address text, area text, city text, governorate text,
 phone text, email text, website text, status text not null default 'Active',
 priority text not null default 'Medium', visit_frequency_days integer not null default 30,
 last_visit_date date, next_visit_due_date date, notes text,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);

create table if not exists public.customer_contacts (
 id uuid primary key default gen_random_uuid(), customer_id uuid not null references public.customers(id) on delete cascade,
 name text not null, job_title text, department text, phone text, email text, whatsapp text,
 is_primary boolean not null default false, notes text, created_at timestamptz not null default now(),
 updated_at timestamptz not null default now()
);

create table if not exists public.visits (
 id uuid primary key default gen_random_uuid(), customer_id uuid not null references public.customers(id) on delete cascade,
 visit_date date not null default current_date, start_time timestamptz, end_time timestamptz,
 visit_type text not null default 'Routine Visit', purpose text, status text not null default 'Planned',
 customer_satisfaction text, product_satisfaction text, delivery_satisfaction text,
 service_satisfaction text, technical_support_satisfaction text, notes text, problems text,
 follow_up_required boolean not null default false, follow_up_date date, follow_up_task text,
 gps_lat numeric, gps_lng numeric, created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);

create table if not exists public.analyzers (
 id uuid primary key default gen_random_uuid(), customer_id uuid not null references public.customers(id) on delete cascade,
 manufacturer text, analyzer_model text not null, serial_number text, installation_date date,
 installation_location text, warranty_start date, warranty_end date, status text not null default 'Active',
 monthly_test_volume numeric, contract_information text, notes text, created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);

create table if not exists public.assays (
 id uuid primary key default gen_random_uuid(), assay_name text not null, manufacturer text, product_code text,
 category text, unit text, list_price numeric, reagent_information text, active boolean not null default true,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);

create table if not exists public.customer_analyzer_assays (
 id uuid primary key default gen_random_uuid(), analyzer_id uuid not null references public.analyzers(id) on delete cascade,
 assay_id uuid not null references public.assays(id) on delete cascade,
 status text not null default 'Current', created_at timestamptz not null default now(),
 unique(analyzer_id, assay_id)
);

create table if not exists public.products (
 id uuid primary key default gen_random_uuid(), product_name text not null, product_code text,
 category text, manufacturer text, unit text, price numeric, currency text default 'KWD',
 compatible_analyzer text, active boolean not null default true, created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);

create table if not exists public.orders (
 id uuid primary key default gen_random_uuid(), customer_id uuid not null references public.customers(id) on delete cascade,
 order_date date not null default current_date, customer_po_number text, order_reference text,
 order_status text not null default 'Received', total_amount numeric default 0, notes text,
 attachment_url text, created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);

create table if not exists public.order_items (
 id uuid primary key default gen_random_uuid(), order_id uuid not null references public.orders(id) on delete cascade,
 product_id uuid references public.products(id) on delete set null, product_name text,
 quantity numeric not null default 1, unit_price numeric not null default 0, discount numeric not null default 0,
 total numeric generated always as ((quantity * unit_price) - discount) stored
);

create table if not exists public.opportunities (
 id uuid primary key default gen_random_uuid(), customer_id uuid not null references public.customers(id) on delete cascade,
 analyzer_id uuid references public.analyzers(id) on delete set null, opportunity_type text not null,
 description text, estimated_value numeric, expected_monthly_value numeric, probability numeric,
 expected_closing_date date, stage text not null default 'Identified', notes text, next_action text,
 next_action_date date, created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);

create table if not exists public.tasks (
 id uuid primary key default gen_random_uuid(), customer_id uuid references public.customers(id) on delete cascade,
 visit_id uuid references public.visits(id) on delete cascade, opportunity_id uuid references public.opportunities(id) on delete cascade,
 order_id uuid references public.orders(id) on delete cascade, task_title text not null, description text,
 due_date date, priority text default 'Medium', status text default 'Pending',
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);

alter table public.customers enable row level security;
alter table public.customer_contacts enable row level security;
alter table public.visits enable row level security;
alter table public.analyzers enable row level security;
alter table public.assays enable row level security;
alter table public.customer_analyzer_assays enable row level security;
alter table public.products enable row level security;
alter table public.orders enable row level security;
alter table public.order_items enable row level security;
alter table public.opportunities enable row level security;
alter table public.tasks enable row level security;

do $$
declare t text;
begin
 foreach t in array array['customers','customer_contacts','visits','analyzers','assays','customer_analyzer_assays','products','orders','order_items','opportunities','tasks'] loop
  execute format('drop policy if exists "authenticated users full access" on public.%I',t);
  execute format('create policy "authenticated users full access" on public.%I for all to authenticated using (true) with check (true)',t);
 end loop;
end $$;

create table if not exists public.training_records (
 id uuid primary key default gen_random_uuid(), customer_id uuid not null references public.customers(id) on delete cascade,
 date date not null default current_date, product text, participants text, trainer text, notes text,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table if not exists public.complaints (
 id uuid primary key default gen_random_uuid(), customer_id uuid not null references public.customers(id) on delete cascade,
 date date not null default current_date, product text, priority text default 'Medium', status text default 'Open',
 description text, resolution text, created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
alter table public.training_records enable row level security;
alter table public.complaints enable row level security;
do $$ begin
 drop policy if exists "authenticated users full access" on public.training_records;
 create policy "authenticated users full access" on public.training_records for all to authenticated using (true) with check (true);
 drop policy if exists "authenticated users full access" on public.complaints;
 create policy "authenticated users full access" on public.complaints for all to authenticated using (true) with check (true);
end $$;
