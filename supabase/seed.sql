-- Datos de ejemplo. Ejecutar DESPUÉS de registrar al menos un usuario en la app
-- (los registros se asignan al usuario más antiguo de auth.users).
-- Valores tomados de la wiki de la comunidad (helldivers.wiki.gg); pueden cambiar con los parches.
-- Nota: si todavía no existe ningún usuario, este INSERT no agrega filas.

with u as (
  select id from auth.users order by created_at asc limit 1
)
insert into public.estratagemas
  (nombre, categoria, codigo, enfriamiento_seg, nivel_requerido, costo_requisiciones, descripcion, created_by)
select v.nombre, v.categoria, v.codigo, v.enfriamiento_seg, v.nivel_requerido, v.costo_requisiciones, v.descripcion, u.id
from u
cross join (
  values
    ('Orbital Precision Strike', 'ofensivo', 'DDW', 90, 1, 0, 'Ataque orbital concentrado sobre un punto concreto.'),
    ('Orbital Gatling Barrage', 'ofensivo', 'DSAWW', 70, 1, 1500, 'Lluvia de fuego orbital, ideal contra grupos de enemigos pequeños.'),
    ('Orbital Gas Strike', 'ofensivo', 'DDSD', 75, 1, 4000, 'Proyectil orbital que deja una nube de gas en la zona.'),
    ('Orbital 120mm HE Barrage', 'ofensivo', 'DDSADS', 180, 5, 4000, 'Bombardeo orbital de explosivos de alto poder sobre un área.'),
    ('Orbital Airburst Strike', 'ofensivo', 'DDD', 100, 5, 4000, 'Proyectil orbital que estalla en el aire sobre el objetivo.'),
    ('Orbital 380mm HE Barrage', 'ofensivo', 'DSWWASS', 240, 8, 7500, 'Bombardeo prolongado y de gran alcance con proyectiles pesados.'),
    ('Orbital Laser', 'ofensivo', 'DSWDS', 300, 15, 10000, 'Láser orbital que barre la zona durante un tiempo.'),
    ('Orbital Railcannon Strike', 'ofensivo', 'DWSSD', 180, 20, 10000, 'Disparo orbital único para abatir objetivos enormes.'),
    ('Eagle Strafing Run', 'ofensivo', 'WDD', 15, 1, 1500, 'Pasada de ametrallamiento de un Águila sobre el objetivo.'),
    ('Eagle Airstrike', 'ofensivo', 'WDSD', 15, 1, 4000, 'Bombardeo de un Águila sobre una franja del terreno.'),
    ('Eagle Cluster Bomb', 'ofensivo', 'WDSSD', 15, 3, 4000, 'Bombas de racimo lanzadas por un Águila.'),
    ('Eagle Napalm Airstrike', 'ofensivo', 'WDSW', 15, 5, 5000, 'Ataque aéreo con napalm que incendia el área.'),
    ('Eagle 110mm Rocket Pods', 'ofensivo', 'WDWA', 15, 10, 7500, 'Descarga de cohetes de un Águila contra el objetivo.'),
    ('Eagle 500kg Bomb', 'ofensivo', 'WDSSS', 15, 15, 10000, 'Bomba pesada lanzada por un Águila.'),
    ('MG-43 Machine Gun', 'suministro', 'SASWD', 480, 1, 0, 'Ametralladora de apoyo para grupos de enemigos ligeros y medianos.'),
    ('EAT-17 Expendable Anti-Tank', 'suministro', 'SSAWD', 70, 3, 3000, 'Lanzacohetes desechable para enemigos blindados.'),
    ('GR-8 Recoilless Rifle', 'suministro', 'SADDA', 480, 5, 6000, 'Rifle sin retroceso para destruir enemigos grandes.'),
    ('AC-8 Autocannon', 'suministro', 'SASWWD', 480, 10, 7000, 'Cañón automático que usa una mochila de munición.'),
    ('RS-422 Railgun', 'suministro', 'SDSWAD', 480, 20, 10000, 'Arma de riel de alta potencia.'),
    ('B-1 Supply Pack', 'suministro', 'SASWWS', 480, 1, 4000, 'Mochila con munición y suministros para el escuadrón.'),
    ('LIFT-850 Jump Pack', 'suministro', 'SWWSW', 480, 8, 6000, 'Mochila de salto para moverse rápido por el terreno.'),
    ('SH-32 Shield Generator Pack', 'suministro', 'SWADAD', 480, 20, 10000, 'Mochila que genera un escudo de energía para quien la lleva.'),
    ('EXO-45 Patriot Exosuit', 'suministro', 'ASDWASS', 420, 25, 20000, 'Exotraje de un piloto con blindaje y armas montadas.'),
    ('M-102 Fast Recon Vehicle', 'suministro', 'ASDSDSW', 480, 25, 25000, 'Vehículo de reconocimiento rápido con capacidad para varios Helldivers.'),
    ('A/MG-43 Machine Gun Sentry', 'defensivo', 'SWDDW', 90, 1, 1500, 'Torreta automática de ametralladora.'),
    ('A/G-16 Gatling Sentry', 'defensivo', 'SWDA', 150, 5, 4000, 'Torreta automática con cañón Gatling.'),
    ('A/AC-8 Autocannon Sentry', 'defensivo', 'SWDWAW', 150, 13, 6000, 'Torreta automática con cañón automático.'),
    ('Reinforce', 'mision', 'WSDAW', 300, 1, 0, 'Llama a un Helldiver caído de vuelta al combate.'),
    ('Resupply', 'mision', 'SSWD', 480, 1, 0, 'Envía una caja de suministros al escuadrón.')
) as v(nombre, categoria, codigo, enfriamiento_seg, nivel_requerido, costo_requisiciones, descripcion);
