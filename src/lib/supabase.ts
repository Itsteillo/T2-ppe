import { createClient } from "@supabase/supabase-js";

const url = import.meta.env.PUBLIC_SUPABASE_URL;
const anonKey = import.meta.env.PUBLIC_SUPABASE_ANON_KEY;

if (!url || !anonKey) {
  throw new Error(
    "Faltan PUBLIC_SUPABASE_URL o PUBLIC_SUPABASE_ANON_KEY. Copia .env.example a .env.",
  );
}

/**
 * Cliente para el SERVIDOR (SSR). Usa la anon key: el listado es público y
 * las políticas RLS solo permiten `select` a usuarios anónimos.
 * Sin sesión persistida: cada request del Worker es independiente.
 */
export function createServerClient() {
  return createClient(url, anonKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  });
}

/**
 * Cliente para el NAVEGADOR (login, registro y administración).
 * Mantiene la sesión en localStorage. Solo importar desde scripts de cliente.
 */
export const supabase = createClient(url, anonKey);
