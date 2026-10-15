export type Categoria = "ofensivo" | "suministro" | "defensivo" | "mision";

export interface Estratagema {
  id: string;
  imagen: string;
  nombre: string;
  categoria: Categoria;
  /** Teclas W, A, S, D (arriba, izquierda, abajo, derecha). Ej: "WDSSS". */
  codigo: string;
  created_by: string;
  created_at: string;
}

export type EstratagemaInput = Omit<Estratagema, "id" | "created_by" | "created_at">;
