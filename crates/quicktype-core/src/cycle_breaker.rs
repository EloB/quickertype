//! Port of `packages/quicktype-core/src/CycleBreaker.ts`.
//!
//! `breakCycles` is exported by quicktype-core but called nowhere in
//! quicktype; the cycle breaking renderers use is
//! [`cycle_breaker_types_for_graph`](crate::declaration_ir::cycle_breaker_types_for_graph).
//! It is ported as is, including a quirk: the TypeScript tests
//! `path.indexOf(edge) === undefined`, which is never true (`indexOf`
//! returns -1), so the first step of the cycle search already "finds" a
//! cycle, `path.slice(-1)` if the edge is not on the path.

use crate::messages::Result;
use crate::support::support::{assert, assert_default, panic};

/// `breakCycles(outEdges, chooseBreaker)`: repeatedly removes nodes without
/// incoming or outgoing edges, and when only cycles remain, removes the
/// node `choose_breaker` picks from one. Returns the chosen nodes with
/// their info, in order.
pub fn break_cycles<T>(
    out_edges: &[Vec<usize>],
    mut choose_breaker: impl FnMut(&[usize]) -> Result<(usize, T)>,
) -> Result<Vec<(usize, T)>> {
    let num_nodes = out_edges.len();
    let mut in_edges: Vec<Vec<usize>> = vec![Vec::new(); num_nodes];
    let mut in_degree: Vec<usize> = vec![0; num_nodes];
    let mut out_degree: Vec<usize> = out_edges.iter().map(Vec::len).collect();
    let mut done: Vec<bool> = vec![false; num_nodes];
    let mut results: Vec<(usize, T)> = Vec::new();

    for (i, edges) in out_edges.iter().enumerate() {
        for &n in edges {
            in_edges[n].push(i);
            in_degree[n] += 1;
        }
    }

    let mut work_list: Vec<usize> = (0..num_nodes)
        .filter(|&i| in_degree[i] == 0 || out_degree[i] == 0)
        .collect();

    let remove_node = |node: usize,
                       in_degree: &mut Vec<usize>,
                       out_degree: &mut Vec<usize>,
                       done: &mut Vec<bool>,
                       work_list: &mut Vec<usize>|
     -> Result<()> {
        for &n in &out_edges[node] {
            assert_default(in_degree[n] > 0)?;
            in_degree[n] -= 1;
            if in_degree[n] == 0 {
                work_list.push(n);
            }
        }
        for &n in &in_edges[node] {
            assert_default(out_degree[n] > 0)?;
            out_degree[n] -= 1;
            if out_degree[n] == 0 {
                work_list.push(n);
            }
        }
        done[node] = true;
        Ok(())
    };

    loop {
        if let Some(i) = work_list.pop() {
            if done[i] || (in_degree[i] == 0 && out_degree[i] == 0) {
                done[i] = true;
                continue;
            }
            assert(
                in_degree[i] == 0 || out_degree[i] == 0,
                "Can't have nodes in the worklist with in and out edges",
            )?;
            remove_node(
                i,
                &mut in_degree,
                &mut out_degree,
                &mut done,
                &mut work_list,
            )?;
            continue;
        }

        let Some(n) = done.iter().position(|&d| !d) else {
            // We're done!
            break;
        };

        // There's a cycle.
        let path: Vec<usize> = vec![n];
        let Some(&maybe_edge) = out_edges[n].iter().find(|&&x| !done[x]) else {
            return panic("Presumed cycle is not a cycle");
        };
        // `path.indexOf(maybeEdge)`, then `path.slice(maybeFirst)` with
        // JavaScript's negative-index semantics.
        let start = match path.iter().position(|&x| x == maybe_edge) {
            Some(i) => i,
            None => path.len() - 1,
        };
        let cycle = &path[start..];
        let (break_node, info) = choose_breaker(cycle)?;
        assert(cycle.contains(&break_node), "Breaker chose an invalid node")?;
        remove_node(
            break_node,
            &mut in_degree,
            &mut out_degree,
            &mut done,
            &mut work_list,
        )?;
        results.push((break_node, info));
    }

    Ok(results)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn acyclic_graphs_need_no_breakers() {
        let edges = vec![vec![1], vec![2], vec![]];
        let result = break_cycles(&edges, |c| Ok((c[0], ()))).unwrap();
        assert!(result.is_empty());
    }

    #[test]
    fn breaks_a_cycle_at_the_first_remaining_node() {
        let edges = vec![vec![1], vec![2], vec![0]];
        let mut cycles = Vec::new();
        let result = break_cycles(&edges, |c| {
            cycles.push(c.to_vec());
            Ok((c[0], "x"))
        })
        .unwrap();
        assert_eq!(cycles, vec![vec![0]]);
        assert_eq!(result, vec![(0, "x")]);
    }

    #[test]
    fn rejects_invalid_breakers() {
        let edges = vec![vec![1], vec![0]];
        assert!(break_cycles(&edges, |_| Ok((1, ()))).is_err());
    }
}
