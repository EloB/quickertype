//! Port of `packages/quicktype-core/src/Graph.ts`.
//!
//! A directed graph over a list of nodes, with Tarjan's strongly connected
//! components, roots and depth-first traversal. Node order is the given
//! order and successor order is edge order, so every result is
//! deterministic. The recursive algorithms are implemented with explicit
//! stacks (so deep type graphs cannot overflow the stack) that visit nodes
//! in exactly the order the recursive TypeScript does.

use std::collections::HashMap;
use std::hash::Hash;

use indexmap::IndexSet;

use crate::messages::Result;
use crate::support::support::{assert, assert_default, defined};

fn count_component_graph_nodes(components: &[Vec<usize>]) -> Result<usize> {
    if components.is_empty() {
        return Ok(0);
    }
    let mut largest: isize = -1;
    let mut count = 0;
    for c in components {
        assert(!c.is_empty(), "Empty component not allowed")?;
        for &v in c {
            largest = largest.max(v as isize);
            count += 1;
        }
    }
    assert(
        largest + 1 == count as isize,
        "Vertex indexes and count don't match up",
    )?;
    Ok(count)
}

/// Tarjan's algorithm, in the visiting order of the recursive original.
fn strongly_connected_components(successors: &[Vec<usize>]) -> Result<Vec<Vec<usize>>> {
    let num_nodes = successors.len();
    let mut index = 0usize;
    let mut stack: Vec<usize> = Vec::new();
    let mut indexes: Vec<Option<usize>> = vec![None; num_nodes];
    let mut low_links: Vec<usize> = vec![0; num_nodes];
    let mut on_stack: Vec<bool> = vec![false; num_nodes];
    let mut sccs: Vec<Vec<usize>> = Vec::new();

    for root in 0..num_nodes {
        if indexes[root].is_some() {
            continue;
        }
        // Each frame is a node and the position in its successor list.
        let mut frames: Vec<(usize, usize)> = Vec::new();
        let mut enter = |v: usize,
                         frames: &mut Vec<(usize, usize)>,
                         stack: &mut Vec<usize>,
                         indexes: &mut Vec<Option<usize>>,
                         low_links: &mut Vec<usize>,
                         on_stack: &mut Vec<bool>| {
            indexes[v] = Some(index);
            low_links[v] = index;
            index += 1;
            stack.push(v);
            on_stack[v] = true;
            frames.push((v, 0));
        };
        enter(
            root,
            &mut frames,
            &mut stack,
            &mut indexes,
            &mut low_links,
            &mut on_stack,
        );

        while let Some(&mut (v, ref mut position)) = frames.last_mut() {
            if let Some(&w) = successors[v].get(*position) {
                *position += 1;
                match indexes[w] {
                    None => enter(
                        w,
                        &mut frames,
                        &mut stack,
                        &mut indexes,
                        &mut low_links,
                        &mut on_stack,
                    ),
                    Some(w_index) => {
                        if on_stack[w] {
                            low_links[v] = low_links[v].min(w_index);
                        }
                    }
                }
                continue;
            }

            // All successors of v are done.
            if Some(low_links[v]) == indexes[v] {
                let mut scc = Vec::new();
                loop {
                    let w = defined(stack.pop())?;
                    on_stack[w] = false;
                    scc.push(w);
                    if w == v {
                        break;
                    }
                }
                sccs.push(scc);
            }
            frames.pop();
            if let Some(&(parent, _)) = frames.last() {
                low_links[parent] = low_links[parent].min(low_links[v]);
            }
        }
    }

    assert(
        count_component_graph_nodes(&sccs)? == num_nodes,
        "We didn't put all the nodes into SCCs",
    )?;
    Ok(sccs)
}

fn build_component_of_node_map(
    successors: &[Vec<usize>],
    components: &[Vec<usize>],
) -> Result<Vec<usize>> {
    let num_nodes = successors.len();
    assert(
        num_nodes == count_component_graph_nodes(components)?,
        "Components don't match up with graph",
    )?;
    let mut component_of_node: Vec<Option<usize>> = vec![None; num_nodes];
    for (c, component) in components.iter().enumerate() {
        for &n in component {
            assert(
                component_of_node[n].is_none(),
                "We have a node that's in two components",
            )?;
            component_of_node[n] = Some(c);
        }
    }
    component_of_node.into_iter().map(defined).collect()
}

fn build_meta_successors(
    successors: &[Vec<usize>],
    components: &[Vec<usize>],
) -> Result<Vec<Vec<usize>>> {
    let component_of_node = build_component_of_node_map(successors, components)?;
    let mut component_added = vec![false; components.len()];
    let mut meta_successors = Vec::with_capacity(components.len());
    for (c, component) in components.iter().enumerate() {
        let mut succ = Vec::new();
        for &n in component {
            for &s in &successors[n] {
                let ms = component_of_node[s];
                if ms == c || component_added[ms] {
                    continue;
                }
                succ.push(ms);
                component_added[ms] = true;
            }
        }
        for &ms in &succ {
            assert_default(component_added[ms])?;
            component_added[ms] = false;
        }
        meta_successors.push(succ);
    }
    Ok(meta_successors)
}

fn invert_edges(successors: &[Vec<usize>]) -> Vec<Vec<usize>> {
    let mut predecessors = vec![Vec::new(); successors.len()];
    for (s, succ) in successors.iter().enumerate() {
        for &v in succ {
            predecessors[v].push(s);
        }
    }
    predecessors
}

fn find_roots(successors: &[Vec<usize>]) -> Vec<usize> {
    let mut in_degrees = vec![0usize; successors.len()];
    for succ in successors {
        for &v in succ {
            in_degrees[v] += 1;
        }
    }
    (0..successors.len())
        .filter(|&v| in_degrees[v] == 0)
        .collect()
}

/// `Graph<T>`.
#[derive(Clone, Debug)]
pub struct Graph<T> {
    nodes: Vec<T>,
    index_by_node: HashMap<T, usize>,
    successors: Vec<Vec<usize>>,
}

impl<T: Clone + Eq + Hash> Graph<T> {
    /// `new Graph(nodes, invertDirection, edges)` with an edge function.
    pub fn new(
        nodes: impl IntoIterator<Item = T>,
        invert_direction: bool,
        mut edges: impl FnMut(&T) -> Result<IndexSet<T>>,
    ) -> Result<Graph<T>> {
        let nodes: Vec<T> = nodes.into_iter().collect();
        let index_by_node = Self::index_nodes(&nodes);
        let mut edges_array = Vec::with_capacity(nodes.len());
        for n in &nodes {
            let mut succ = Vec::new();
            for s in edges(n)? {
                succ.push(*defined(index_by_node.get(&s))?);
            }
            edges_array.push(succ);
        }
        Ok(Self::from_parts(
            nodes,
            index_by_node,
            invert_direction,
            edges_array,
        ))
    }

    /// `new Graph(nodes, invertDirection, edges)` with an edge array of node
    /// indexes.
    pub fn with_edges(
        nodes: impl IntoIterator<Item = T>,
        invert_direction: bool,
        edges: Vec<Vec<usize>>,
    ) -> Result<Graph<T>> {
        let nodes: Vec<T> = nodes.into_iter().collect();
        assert(edges.len() == nodes.len(), "Assertion failed")?;
        for succ in &edges {
            for &s in succ {
                assert(s < nodes.len(), "Assertion failed")?;
            }
        }
        let index_by_node = Self::index_nodes(&nodes);
        Ok(Self::from_parts(
            nodes,
            index_by_node,
            invert_direction,
            edges,
        ))
    }

    fn index_nodes(nodes: &[T]) -> HashMap<T, usize> {
        // Like `new Map(nodes.map((n, i) => [n, i]))`: the last index wins.
        nodes
            .iter()
            .enumerate()
            .map(|(i, n)| (n.clone(), i))
            .collect()
    }

    fn from_parts(
        nodes: Vec<T>,
        index_by_node: HashMap<T, usize>,
        invert_direction: bool,
        edges: Vec<Vec<usize>>,
    ) -> Graph<T> {
        let successors = if invert_direction {
            invert_edges(&edges)
        } else {
            edges
        };
        Graph {
            nodes,
            index_by_node,
            successors,
        }
    }

    /// `size`.
    pub fn size(&self) -> usize {
        self.nodes.len()
    }

    /// `nodes`.
    pub fn nodes(&self) -> &[T] {
        &self.nodes
    }

    /// The successors of the node at `index`, as node indexes.
    pub fn successors(&self, index: usize) -> &[usize] {
        &self.successors[index]
    }

    /// `findRoots()`: nodes without predecessors, in node order.
    pub fn find_roots(&self) -> Vec<T> {
        find_roots(&self.successors)
            .into_iter()
            .map(|n| self.nodes[n].clone())
            .collect()
    }

    /// `dfsTraversal(root, preOrder, process)`: the subgraph starting at
    /// `root` must be acyclic.
    pub fn dfs_traversal(
        &self,
        root: &T,
        pre_order: bool,
        mut process: impl FnMut(&T) -> Result<()>,
    ) -> Result<()> {
        let mut visited = vec![false; self.size()];
        let root = *defined(self.index_by_node.get(root))?;
        let mut frames: Vec<(usize, usize)> = Vec::new();

        visited[root] = true;
        if pre_order {
            process(&self.nodes[root])?;
        }
        frames.push((root, 0));
        while let Some(&mut (v, ref mut position)) = frames.last_mut() {
            if let Some(&w) = self.successors[v].get(*position) {
                *position += 1;
                if visited[w] {
                    continue;
                }
                visited[w] = true;
                if pre_order {
                    process(&self.nodes[w])?;
                }
                frames.push((w, 0));
                continue;
            }
            if !pre_order {
                process(&self.nodes[v])?;
            }
            frames.pop();
        }
        Ok(())
    }

    /// `stronglyConnectedComponents()`: the graph of components. Each
    /// component lists its nodes in Tarjan's pop order, so its first node is
    /// `iterableFirst(component)`.
    pub fn strongly_connected_components(&self) -> Result<Graph<Vec<T>>> {
        let components = strongly_connected_components(&self.successors)?;
        let component_successors = build_meta_successors(&self.successors, &components)?;
        let nodes: Vec<Vec<T>> = components
            .iter()
            .map(|ns| {
                let mut seen = IndexSet::new();
                for &n in ns {
                    seen.insert(self.nodes[n].clone());
                }
                seen.into_iter().collect()
            })
            .collect();
        Graph::with_edges(nodes, false, component_successors)
    }

    /// `makeDot(includeNode, nodeLabel)`: the graph in Graphviz format.
    pub fn make_dot(
        &self,
        mut include_node: impl FnMut(&T) -> bool,
        mut node_label: impl FnMut(&T) -> String,
    ) -> String {
        let mut lines: Vec<String> = vec![
            "digraph G {".into(),
            "    ordering = out;".into(),
            String::new(),
        ];
        for (i, n) in self.nodes.iter().enumerate() {
            if !include_node(n) {
                continue;
            }
            lines.push(format!("    node{i} [label=\"{}\"];", node_label(n)));
        }
        for (i, n) in self.nodes.iter().enumerate() {
            if !include_node(n) {
                continue;
            }
            for &j in &self.successors[i] {
                if !include_node(&self.nodes[j]) {
                    continue;
                }
                lines.push(format!("    node{i} -> node{j};"));
            }
        }
        lines.push("}".into());
        lines.push(String::new());
        lines.join("\n")
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    /// The recursive TypeScript algorithm, for comparison.
    fn recursive_scc(successors: &[Vec<usize>]) -> Vec<Vec<usize>> {
        struct State<'a> {
            successors: &'a [Vec<usize>],
            index: usize,
            stack: Vec<usize>,
            indexes: Vec<isize>,
            low: Vec<isize>,
            on_stack: Vec<bool>,
            sccs: Vec<Vec<usize>>,
        }
        fn strongconnect(s: &mut State<'_>, v: usize) {
            s.indexes[v] = s.index as isize;
            s.low[v] = s.index as isize;
            s.index += 1;
            s.stack.push(v);
            s.on_stack[v] = true;
            for i in 0..s.successors[v].len() {
                let w = s.successors[v][i];
                if s.indexes[w] < 0 {
                    strongconnect(s, w);
                    s.low[v] = s.low[v].min(s.low[w]);
                } else if s.on_stack[w] {
                    s.low[v] = s.low[v].min(s.indexes[w]);
                }
            }
            if s.low[v] == s.indexes[v] {
                let mut scc = vec![];
                loop {
                    let w = s.stack.pop().unwrap();
                    s.on_stack[w] = false;
                    scc.push(w);
                    if w == v {
                        break;
                    }
                }
                s.sccs.push(scc);
            }
        }
        let n = successors.len();
        let mut s = State {
            successors,
            index: 0,
            stack: vec![],
            indexes: vec![-1; n],
            low: vec![-1; n],
            on_stack: vec![false; n],
            sccs: vec![],
        };
        for v in 0..n {
            if s.indexes[v] < 0 {
                strongconnect(&mut s, v);
            }
        }
        s.sccs
    }

    fn pseudo_random_graph(n: usize, seed: u64) -> Vec<Vec<usize>> {
        let mut x = seed;
        let mut next = || {
            x ^= x << 13;
            x ^= x >> 7;
            x ^= x << 17;
            x
        };
        (0..n)
            .map(|_| {
                let k = (next() % 4) as usize;
                (0..k).map(|_| (next() % n as u64) as usize).collect()
            })
            .collect()
    }

    #[test]
    fn iterative_tarjan_matches_recursive() {
        for seed in 1..200u64 {
            let n = 1 + (seed as usize % 25);
            let g = pseudo_random_graph(n, seed);
            assert_eq!(
                strongly_connected_components(&g).unwrap(),
                recursive_scc(&g),
                "seed {seed}"
            );
        }
    }

    #[test]
    fn components_roots_and_traversal() {
        // 0 -> 1 -> 2 -> 1, 3 -> 0
        let g = Graph::with_edges(
            vec!['a', 'b', 'c', 'd'],
            false,
            vec![vec![1], vec![2], vec![1], vec![0]],
        )
        .unwrap();
        assert_eq!(g.find_roots(), vec!['d']);
        let sccs = g.strongly_connected_components().unwrap();
        assert_eq!(sccs.nodes(), &[vec!['c', 'b'], vec!['a'], vec!['d']]);
        assert_eq!(sccs.successors(1), &[0]);
        let inverted = Graph::with_edges(vec!['a', 'b'], true, vec![vec![1], vec![]]).unwrap();
        assert_eq!(inverted.find_roots(), vec!['b']);

        let tree = Graph::with_edges(
            vec![0, 1, 2, 3],
            false,
            vec![vec![1, 2], vec![3], vec![3], vec![]],
        )
        .unwrap();
        let mut pre = vec![];
        tree.dfs_traversal(&0, true, |n| {
            pre.push(*n);
            Ok(())
        })
        .unwrap();
        assert_eq!(pre, vec![0, 1, 3, 2]);
        let mut post = vec![];
        tree.dfs_traversal(&0, false, |n| {
            post.push(*n);
            Ok(())
        })
        .unwrap();
        assert_eq!(post, vec![3, 1, 2, 0]);
    }

    #[test]
    fn dot_output() {
        let g = Graph::with_edges(vec![1, 2], false, vec![vec![1], vec![]]).unwrap();
        assert_eq!(
            g.make_dot(|_| true, |n| n.to_string()),
            "digraph G {\n    ordering = out;\n\n    node0 [label=\"1\"];\n    node1 [label=\"2\"];\n    node0 -> node1;\n}\n"
        );
    }
}
