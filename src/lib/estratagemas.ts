import { createServerClient } from "./supabase";
import type { Estratagema } from "./types";

export const PAGE_SIZE = 10;

export interface ListadoEstratagemas {
  estratagemas: Estratagema[];
  total: number;
  page: number;
  totalPages: number;
  error: string | null;
  /** La página pedida queda fuera de rango (p. ej. ?page=99). */
  fueraDeRango: boolean;
}

/** Escapa %, _ y \ para que el texto del usuario no actúe como comodín en ILIKE. */
function escaparLike(texto: string) {
  return texto.replace(/[\\%_]/g, "\\$&");
}

export async function listarEstratagemas(q: string, page: number): Promise<ListadoEstratagemas> {
  const supabase = createServerClient();
  const from = (page - 1) * PAGE_SIZE;
  const to = from + PAGE_SIZE - 1;

  let query = supabase
    .from("estratagemas")
    .select("*", { count: "exact" })
    .order("nivel_requerido", { ascending: true })
    .order("nombre", { ascending: true })
    .range(from, to);

  if (q) query = query.ilike("nombre", `%${escaparLike(q)}%`);

  const { data, count, error } = await query;

  if (error) {
    // PGRST103: el rango pedido supera el total de filas.
    const fueraDeRango = error.code === "PGRST103";
    return {
      estratagemas: [],
      total: 0,
      page,
      totalPages: 0,
      error: fueraDeRango ? null : error.message || "No hay conexión con Supabase.",
      fueraDeRango,
    };
  }

  const total = count ?? 0;
  return {
    estratagemas: (data ?? []) as Estratagema[],
    total,
    page,
    totalPages: Math.ceil(total / PAGE_SIZE),
    error: null,
    fueraDeRango: false,
  };
}
