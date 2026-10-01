export type Categoria = "ofensivo" | "suministro" | "defensivo" | "mision";

export interface Estratagema {
  id: string;
  nombre: string;
  categoria: Categoria;
  /** Teclas W, A, S, D (arriba, izquierda, abajo, derecha). Ej: "WDSSS". */
  codigo: string;
  enfriamiento_seg: number;
  nivel_requerido: number;
  costo_requisiciones: number;
  descripcion: string | null;
  created_by: string;
  created_at: string;
}

export type EstratagemaInput = Omit<Estratagema, "id" | "created_by" | "created_at">;
