-- GUURI MVP Backend v1
-- PostgreSQL/Supabase-ready schema
-- This is the first backend foundation; payment/KYC providers are connected later.

create extension if not exists pgcrypto;

create type application_status as enum (
  'draft','submitted','under_review','documents_required',
  'verified','partner_review','approved','rejected',
  'agreement_pending','disbursed','active','completed','cancelled'
);

create type kyc_status as enum ('pending','verified','rejected','needs_update');
create type agreement_status as enum ('draft','pending_signature','signed','cancelled');
create type payment_status as enum ('pending','paid','failed','overdue','cancelled');
create type partner_status as enum ('pending','active','suspended');

create table profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null,
  phone text,
  email text,
  role text not null default 'customer'
    check (role in ('customer','admin','partner_staff','finance_staff')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table partners (
  id uuid primary key default gen_random_uuid(),
  legal_name text not null,
  display_name text not null,
  phone text,
  email text,
  status partner_status not null default 'pending',
  created_at timestamptz not null default now()
);

create table applications (
  id uuid primary key default gen_random_uuid(),
  application_no text unique not null,
  applicant_id uuid not null references profiles(id),
  requested_amount numeric(12,2) not null check (requested_amount > 0),
  purpose text not null,
  term_months integer not null check (term_months > 0),
  status application_status not null default 'draft',
  assigned_partner_id uuid references partners(id),
  submitted_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table kyc_documents (
  id uuid primary key default gen_random_uuid(),
  application_id uuid not null references applications(id) on delete cascade,
  document_type text not null,
  storage_path text not null,
  status kyc_status not null default 'pending',
  reviewer_id uuid references profiles(id),
  rejection_reason text,
  created_at timestamptz not null default now(),
  reviewed_at timestamptz
);

create table financing_offers (
  id uuid primary key default gen_random_uuid(),
  application_id uuid not null references applications(id) on delete cascade,
  partner_id uuid not null references partners(id),
  structure text not null default 'murabaha',
  requested_amount numeric(12,2) not null check (requested_amount > 0),
  profit_amount numeric(12,2) not null default 0 check (profit_amount >= 0),
  final_agreed_price numeric(12,2) not null check (final_agreed_price > 0),
  term_months integer not null check (term_months > 0),
  monthly_payment numeric(12,2) not null check (monthly_payment > 0),
  service_fee numeric(12,2) not null default 0 check (service_fee >= 0),
  status text not null default 'pending'
    check (status in ('pending','accepted','declined','expired')),
  created_at timestamptz not null default now(),
  accepted_at timestamptz
);

create table agreements (
  id uuid primary key default gen_random_uuid(),
  agreement_no text unique not null,
  application_id uuid not null references applications(id),
  offer_id uuid not null references financing_offers(id),
  status agreement_status not null default 'draft',
  agreement_version text not null default '1.0',
  signed_by_customer_at timestamptz,
  signed_by_partner_at timestamptz,
  document_path text,
  created_at timestamptz not null default now()
);

create table payments (
  id uuid primary key default gen_random_uuid(),
  application_id uuid not null references applications(id),
  installment_no integer,
  due_date date not null,
  amount numeric(12,2) not null check (amount > 0),
  status payment_status not null default 'pending',
  provider text,
  provider_reference text,
  paid_at timestamptz,
  created_at timestamptz not null default now()
);

create table notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references profiles(id) on delete cascade,
  title text not null,
  body text not null,
  type text not null,
  read_at timestamptz,
  created_at timestamptz not null default now()
);

create table audit_logs (
  id uuid primary key default gen_random_uuid(),
  actor_id uuid references profiles(id),
  action text not null,
  entity_type text not null,
  entity_id uuid,
  metadata jsonb,
  created_at timestamptz not null default now()
);

create index applications_applicant_idx on applications(applicant_id);
create index applications_partner_idx on applications(assigned_partner_id);
create index applications_status_idx on applications(status);
create index kyc_application_idx on kyc_documents(application_id);
create index payments_application_idx on payments(application_id);
create index payments_due_date_idx on payments(due_date);
create index notifications_user_idx on notifications(user_id);

-- GUURI calculation example:
-- requested_amount = 5000
-- profit_amount = 750
-- final_agreed_price = 5750
-- term_months = 12
-- monthly_payment = 5750 / 12 = 479.166...
--
-- IMPORTANT:
-- The displayed 2% GUURI service fee must be explicitly defined
-- whether it is included in or added to the customer's total.
-- Do not silently add it to the payment schedule.
