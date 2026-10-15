-- Datos de ejemplo. Ejecutar después de registrar al menos un usuario en la app.
-- Las imágenes son placeholders para que cada registro tenga el modelo del proyecto de referencia.

with u as (
  select id from auth.users order by created_at asc limit 1
)
insert into public.estratagemas
  (imagen, nombre, categoria, codigo, created_by)
select
  concat('https://placehold.co/600x400/1b1b1b/ffe81f?text=', replace(v.nombre, ' ', '+')),
  v.nombre,
  v.categoria,
  v.codigo,
  u.id
from u
cross join (
  values
    ('Orbital Precision Strike', 'ofensivo', 'DDW'),
    ('Eagle Airstrike', 'ofensivo', 'WDSD'),
    ('MG-43 Machine Gun', 'suministro', 'SASWD'),
    ('EAT-17 Expendable Anti-Tank', 'suministro', 'SSAWD'),
    ('A/MG-43 Machine Gun Sentry', 'defensivo', 'SWDDW'),
    ('A/G-16 Gatling Sentry', 'defensivo', 'SWDA'),
    ('Reinforce', 'mision', 'WSDAW'),
    ('Resupply', 'mision', 'SSWD')
) as v(nombre, categoria, codigo);
