// @ts-check
import { defineConfig } from "astro/config";
import cloudflare from "@astrojs/cloudflare";

// El adaptador de Cloudflare deja todas las páginas en modo servidor por defecto.
// Las páginas estáticas lo declaran con `export const prerender = true`.
export default defineConfig({
  output: "server",
  adapter: cloudflare(),
});
