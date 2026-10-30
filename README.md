# what it shows

The support desk's kb export (`kb-export-267efc5e.zip`), unpacked as it came: `support-kb/`.
One page is added to it, signed:

- the page: `support-kb/src/routes/kb/incidents/4471/problems/+page.svx`
- the page as the desk will see it: `support-kb/rendered/kb/incidents/4471/problems.html` (the whole kb is built into `support-kb/rendered/`)
- the tickets: one issue per problem in #4471, in this repo, linked from the page

Everything else under `support-kb/src/` is byte-identical to the export. To build the kb (Node 22, pnpm):
`cd support-kb && pnpm install && pnpm build`. The export carries only `src/`, so `package.json`,
`svelte.config.js`, `vite.config.js`, `src/app.html` and `src/routes/+layout.ts` are added to build it
(SvelteKit 2, mdsvex, adapter-static).
