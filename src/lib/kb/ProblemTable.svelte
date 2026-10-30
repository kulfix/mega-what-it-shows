<script lang="ts">
  import reports from '#lib/data/reports-4471.json';
  import notes from '#lib/data/desk-notes.json';
  import { type Report } from '#lib/kb/causes';
  import { groupByProblem, mergedInto, type Problem } from '#lib/kb/problems';
  import { tenantOf } from '#lib/kb/locales';

  // `tickets`: where each problem is tracked now, one link per problem.
  let { ticket, tickets = {} }: { ticket: number; tickets?: Partial<Record<Problem, string>> } = $props();

  const rows = $derived((reports as Report[]).filter((r) => r.mergedInto === ticket));
  const merged = $derived(mergedInto(reports as Report[], ticket));
  const groups = $derived(groupByProblem(merged, tenantOf, notes.oneDayMove));
  const counted = $derived(groups.reduce((n, g) => n + g.reports.length, 0));
  const channels = (g: { channels: Record<string, number> }) =>
    Object.entries(g.channels)
      .sort((a, b) => b[1] - a[1])
      .map(([channel, n]) => `${channel} ×${n}`)
      .join(' · ');
  const issueNo = (url: string) => `#${url.split('/').pop()}`;
</script>

<p class="sum">
  <strong>{merged.length}</strong> reports merged into #{ticket} ·
  <strong>{groups.length}</strong>
  {groups.length === 1 ? 'problem' : 'problems'}
</p>

<table>
  <thead>
    <tr><th>problem</th><th>reports</th><th>tenants</th><th>came in by</th><th>seen</th><th>ticket</th></tr>
  </thead>
  <tbody>
    {#each groups as g (g.problem)}
      {@const url = tickets[g.problem]}
      <tr class:open={!url}>
        <td><code>{g.problem}</code></td>
        <td>{g.reports.length}</td>
        <td>{g.tenants}</td>
        <td class="by">{channels(g)}</td>
        <td>{g.firstSeen} → {g.lastSeen}</td>
        <td>{#if url}<a href={url}>{issueNo(url)}</a>{:else}no ticket yet{/if}</td>
      </tr>
    {/each}
  </tbody>
</table>

<p class="note">
  Counted once per id: the export holds {rows.length} rows for #{ticket}, {rows.length - merged.length} of them
  a second copy of a report. The problems add up to {counted}{counted === merged.length ? '' : ` — not ${merged.length}: check the split`}.
</p>

<style>
  .sum { font-size: 1.1rem; }
  .by { color: var(--muted); font-size: 0.85em; }
  .note { color: var(--muted); font-size: 0.85em; }
  .open td { background: var(--warn-bg); }
  .open td:last-child { color: var(--warn); font-weight: 600; }
</style>
