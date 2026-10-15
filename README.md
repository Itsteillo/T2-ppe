# Estratagemas de Helldivers 2

Catálogo de estratagemas del videojuego Helldivers 2 (imagen, nombre, categoría y código de entrada).
Proyecto Astro en arquitectura híbrida sobre Cloudflare Workers,
con Supabase como base de datos y autenticación.

Proyecto académico y no oficial, sin relación con los creadores del juego.

## Modelo: tabla `estratagemas`

| Campo | Tipo | Nota |
|---|---|---|
| `id` | uuid | PK |
| `imagen` | text | URL de la imagen |
| `nombre` | text | Campo de búsqueda |
| `categoria` | text | `ofensivo`, `suministro`, `defensivo` o `mision` |
| `codigo` | text | Teclas `W A S D` (arriba, izquierda, abajo, derecha). Ej: `WDSSS` |
| `created_by` | uuid | FK a `auth.users`, por defecto `auth.uid()` |
| `created_at` | timestamptz | |

Lectura pública; insertar, editar y borrar solo con sesión y sobre filas propias (RLS).

## Qué se renderiza cómo

| Ruta | Modo | Descripción |
|---|---|---|
| `/` | SSR (`prerender = false`) | Listado público; consulta Supabase en el servidor en cada request. Búsqueda y paginación con `?q=...&page=2`. |
| `/acerca` | SSG (`prerender = true`) | Página pública "Acerca de". |
| `/login`, `/registro` | SSG (`prerender = true`) | Autenticación desde el cliente. |
| `/admin` | SSG (`prerender = true`) | CRUD desde el cliente; redirige a `/login` sin sesión. |

Todas las páginas usan `src/layouts/Layout.astro`, que incluye `<ClientRouter />` (View Transitions) y un `<title>` por página.

## Estructura

```
├── astro.config.mjs         # adaptador de Cloudflare
├── wrangler.jsonc           # configuración del Worker
├── supabase/
│   ├── schema.sql           # tabla, índices y políticas RLS
│   └── seed.sql             # 29 estratagemas de ejemplo
├── .env.example
└── src/
    ├── layouts/Layout.astro
    ├── components/          # Header, EstratagemaRow, Pagination
    ├── lib/
    │   ├── supabase.ts            # cliente servidor + cliente navegador
    │   ├── estratagemas.ts        # consulta SSR (búsqueda + paginación)
    │   ├── estratagema-utils.ts   # etiquetas, flechas y formatos
    │   └── types.ts
    ├── pages/
    │   ├── index.astro      # SSR
    │   ├── acerca.astro     # SSG
    │   ├── login.astro      # SSG
    │   ├── registro.astro   # SSG
    │   └── admin/index.astro# SSG + CRUD cliente
    └── styles/global.css
```

## Puesta en marcha

1. En Supabase, ejecuta `supabase/schema.sql` en el SQL Editor.
2. En Authentication → Providers → Email, desactiva "Confirm email" mientras desarrollas.
3. `cp .env.example .env` y completa `PUBLIC_SUPABASE_URL` y `PUBLIC_SUPABASE_ANON_KEY`.
4. `npm install`
5. `npm run dev` → http://localhost:4321
6. Regístrate en `/registro` y luego ejecuta `supabase/seed.sql` para cargar los datos de ejemplo.

Los datos de ejemplo vienen de la wiki de la comunidad (helldivers.wiki.gg) y pueden cambiar con los parches del juego.

## Despliegue en Cloudflare Workers

**Desde tu máquina**

```bash
npx wrangler login
npm run deploy        # astro build && wrangler deploy
```

Las variables `PUBLIC_*` se inyectan en build time, así que deben estar definidas en tu `.env` al ejecutar `npm run deploy`.

**Con Git (Workers Builds)**

1. Cloudflare Dashboard → Workers & Pages → Create → Import a repository.
2. Build command: `npm run build`. Deploy command: `npx wrangler deploy`.
3. En Settings → Build → Variables and secrets, agrega `PUBLIC_SUPABASE_URL` y `PUBLIC_SUPABASE_ANON_KEY` (variables de **build**, no solo de runtime).
4. En Supabase → Authentication → URL Configuration, agrega la URL `*.workers.dev` del Worker.
