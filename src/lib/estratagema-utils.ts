// Utilidades puras: se pueden importar tanto en el servidor como en el navegador.
import type { Categoria } from "./types";

export const CATEGORIAS: Record<Categoria, string> = {
  ofensivo: "Ofensivo",
  suministro: "Suministro",
  defensivo: "Defensivo",
  mision: "Misión",
};

const FLECHAS: Record<string, string> = { W: "↑", A: "←", S: "↓", D: "→" };
const DIRECCIONES: Record<string, string> = {
  W: "arriba",
  A: "izquierda",
  S: "abajo",
  D: "derecha",
};

export function teclas(codigo: string) {
  return [...codigo.toUpperCase()].map((t) => ({
    tecla: t,
    flecha: FLECHAS[t] ?? "?",
    direccion: DIRECCIONES[t] ?? "?",
  }));
}

/** "WDS" → "arriba, derecha, abajo" (para lectores de pantalla). */
export function describirCodigo(codigo: string) {
  return teclas(codigo).map((t) => t.direccion).join(", ");
}

export function formatoSegundos(s: number) {
  if (s < 60) return `${s} s`;
  const m = Math.floor(s / 60);
  const r = s % 60;
  return r ? `${m} min ${r} s` : `${m} min`;
}

const numero = new Intl.NumberFormat("es-CO");

export function formatoCosto(n: number) {
  return n === 0 ? "Gratis" : `${numero.format(n)} req.`;
}
