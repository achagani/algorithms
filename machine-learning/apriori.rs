

use std::collections::HashMap;
use std::collections::HashSet;
use std::hash::{Hash, Hasher};
use std::iter::FromIterator;

#[derive(Debug,Default,Clone)]
pub struct ItemSet {
    pub items: HashSet<String>,
    pub support: f64,
    pub count: u64,
}

impl Hash for ItemSet {
    fn hash<H: Hasher>(&self, state: &mut H) {
        let mut a: Vec<String> = self.items.iter().cloned().collect();
        a.sort();
        for s in a.iter() {
            s.hash(state);
            state.write(s.as_bytes());
        }
    }
}

impl PartialEq for ItemSet {
    fn eq(&self, other: &ItemSet) -> bool {
        self.items == other.items
    }
}
impl Eq for ItemSet {}

fn first_pass(sets: &Vec<Vec<String>>, min_support: f64) -> (HashSet<ItemSet>, u64) {
    let mut sets_count = 0;
    let large = sets.iter()
        .inspect(|_| sets_count += 1)
        .flat_map(|x| x.iter())
        .fold(HashMap::new(), |mut acc, x| {
            *acc.entry(x).or_insert(0) += 1;
            acc
        })
        .iter()
        .filter(|&(_, &v)| v as f64 / sets_count as f64 > min_support)
        .fold(HashSet::new(), |mut acc, (&k, &v)| {
            acc.insert(ItemSet {
                items: vec![k.clone()].into_iter().collect::<HashSet<String>>(),
                support: v as f64 / sets_count as f64,
                count: v,
                ..Default::default()
            });

            acc
        });

    (large, sets_count)
}

fn generate_subsets(large: HashSet<ItemSet>) -> HashSet<ItemSet> {
    println!("Gerating Subsets...");
    println!("{:?}", large);
    println!("Gerating Subsets...");
    println!("---\n***");
    
    large.iter().fold(HashSet::new(), |mut acc, rit| {
        for lit in large.iter() {
            for i1 in rit.items.difference(&lit.items).cloned() {
                let mut candidate = lit.items.clone();
                candidate.insert(i1);

                if candidate.iter().fold(true, |acc, elem| {
                    let subset = candidate.difference(&vec![elem.clone()].into_iter().collect::<HashSet<String>>()).cloned().collect();
                    acc && large.contains(&ItemSet { items: subset, ..Default::default() })
                }) {
                    acc.insert(ItemSet { items: candidate, ..Default::default() });
                }
            }
        }

        acc
    })
}


pub fn apriori(sets: Vec<Vec<String>>, min_support: f64) -> HashSet<ItemSet> {
    let (mut large, sets_count) = first_pass(&sets, min_support);
    let mut output = HashSet::<ItemSet>::new();

    while !large.is_empty() {
        let mut candidates = generate_subsets(large);

        for set in sets.iter() {
            let hash_set = HashSet::from_iter(set.iter().cloned());

            candidates = candidates.into_iter()
                .map(|mut x| {
                    if x.items.is_subset(&hash_set) {
                        x.count += 1;
                        x.support = x.count as f64 / sets_count as f64;
                    }

                    x
                })
                .collect();
        }

        large =
            HashSet::from_iter(candidates.iter().cloned().filter(|x| x.support > min_support));

        output.extend(large.clone());
    }

    output
}

#[cfg(test)]

mod tests {
use recommendation::*;

#[test]
fn it_works() {
    let sets = vec![vec!["1".to_string(), "2".to_string(), "3".to_string(), "4".to_string()],
                    vec!["1".to_string(), "2".to_string(), "4".to_string()],
                    vec!["1".to_string(), "2".to_string()],
                    vec!["2".to_string(), "3".to_string(), "4".to_string()],
                    vec!["2".to_string(), "3".to_string()],
                    vec!["3".to_string(), "4".to_string()],
                    vec!["2".to_string(), "4".to_string()]];

    let output = apriori(sets, 0.42);

    assert_eq!(output.len(), 4);

    let set1output =
        output.get(&ItemSet { items: vec!["4".to_string(), "2".to_string()].into_iter().collect(), ..Default::default() });
    let set2output =
        output.get(&ItemSet { items: vec!["3".to_string(), "2".to_string()].into_iter().collect(), ..Default::default() });
    let set3output =
        output.get(&ItemSet { items: vec!["1".to_string(), "2".to_string()].into_iter().collect(), ..Default::default() });
    let set4output =
        output.get(&ItemSet { items: vec!["3".to_string(), "4".to_string()].into_iter().collect(), ..Default::default() });

    assert!(set1output.is_some());
    assert!(set2output.is_some());
    assert!(set3output.is_some());
    assert!(set4output.is_some());

    println!("Output: {:?}", output);
}
