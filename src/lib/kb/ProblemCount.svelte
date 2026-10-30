<script lang="ts">
  import reports from '#lib/data/reports-4471.json';
  import notes from '#lib/data/desk-notes.json';
  import { type Report } from '#lib/kb/causes';
  import { groupByProblem, mergedInto, type Problem } from '#lib/kb/problems';
  import { tenantOf } from '#lib/kb/locales';

  // A count inside a sentence. `problem` set: that problem's reports. Unset: every report in the ticket.
  let { ticket, problem }: { ticket: number; problem?: Problem } = $props();

  const merged = $derived(mergedInto(reports as Report[], ticket));
  const n = $derived(
    problem ? (groupByProblem(merged, tenantOf, notes.oneDayMove).find((g) => g.problem === problem)?.reports.length ?? 0) : merged.length,
  );
</script>

<strong>{n}</strong>
