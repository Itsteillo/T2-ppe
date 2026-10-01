-- Ejecutar en Supabase → SQL Editor

-- Extensión para acelerar búsquedas con ILIKE '%texto%'
create extension if not exists pg_trgm;

create table if not exists public.estratagemas (
  id                  uuid primary key default gen_random_uuid(),
  nombre              text not null check (char_length(nombre) between 2 and 120),
  categoria           text not null check (categoria in ('ofensivo', 'suministro', 'defensivo', 'mision')),
  -- Teclas W (arriba), A (izquierda), S (abajo), D (derecha). Ej: WDSSS
  codigo              text not null check (codigo ~ '^[WASD]{2,10}$'),
  enfriamiento_seg    integer not null check (enfriamiento_seg >= 0),
  nivel_requerido     integer not null default 1 check (nivel_requerido >= 1),
  costo_requisiciones integer not null default 0 check (costo_requisiciones >= 0),
  descripcion         text,
  created_by          uuid not null default auth.uid() references auth.users(id) on delete cascade,
  created_at          timestamptz not null default now()
);

-- Índices: búsqueda por nombre, orden del listado y filtro "mis estratagemas"
create index if not exists estratagemas_nombre_trgm_idx on public.estratagemas using gin (nombre gin_trgm_ops);
create index if not exists estratagemas_orden_idx       on public.estratagemas (nivel_requerido, nombre);
create index if not exists estratagemas_created_by_idx  on public.estratagemas (created_by);

-- RLS
alter table public.estratagemas enable row level security;

-- Lectura pública (la usa el SSR con la anon key)
create policy "estratagemas_select_publico"
  on public.estratagemas for select
  to anon, authenticated
  using (true);

-- Escritura solo con sesión activa y sobre filas propias
create policy "estratagemas_insert_autenticado"
  on public.estratagemas for insert
  to authenticated
  with check (auth.uid() = created_by);

create policy "estratagemas_update_propietario"
  on public.estratagemas for update
  to authenticated
  using (auth.uid() = created_by)
  with check (auth.uid() = created_by);

create policy "estratagemas_delete_propietario"
  on public.estratagemas for delete
  to authenticated
  using (auth.uid() = created_by);
