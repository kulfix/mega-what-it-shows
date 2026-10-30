# what it shows

The support desk's kb, laid out the way the desk keeps it: `apps/kb/`, which the desk's export
turns into `src/` ("Exported 2026-10-04 from the `support` repo, `apps/kb/` → `src/`").
Everything in `apps/kb/` is byte-identical to the export (`kb-export-267efc5e.zip`), plus one signed page:

- the page: `apps/kb/routes/kb/incidents/4471-problems/+page.svx`
- the page as the desk will see it: `rendered/kb/incidents/4471-problems.html` (the whole kb is rendered into `rendered/`)
- the tickets: one issue per problem in #4471, in this repo, linked from the page

`kb-build/build.sh` does what the export does: it copies `apps/kb/` to `src/` in a scratch folder, adds the
build files the export leaves out (`package.json`, `svelte.config.js`, `vite.config.js`, `app.html`,
`routes/+layout.ts`; SvelteKit 2, mdsvex, adapter-static) and renders every page into `rendered/`.
Needs Node 22 and pnpm.
