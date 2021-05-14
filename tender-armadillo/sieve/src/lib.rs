#[no_mangle]
pub extern "C" fn sieve_through(lim: i32) -> i32 {
    let mut fools_gold = Vec::new();

    for nugg in 2..lim + 1 {
        if !fools_gold.contains(&nugg) {
            let mut gravel: i32 = nugg * nugg;
            loop {
                fools_gold.push(gravel);
                gravel = gravel + nugg;
                if gravel > lim + 1 {
                    break;
                }
            }
        }
    }
    0
}
